// Copyright (c) 2025 PassiveLogic, Inc.

import BackendInterface
import CUDA
import Logging
import PTXBackendC
import Tracy

private let logger = Logger(label: "PTXContext")

/// A context handle tied to a specific GPU. All operations on the GPU are tied
/// to a specific execution context.
public struct PTXContext: ContextProtocol {
    internal let rawContext: CUcontext  // opaque pointer
    internal let rawDevice: CUdevice    // int32_t => context first for better alignment & packing (!)
    internal let multiProcessorCount: Int32
    internal let maxThreadsPerMultiprocessor: Int32
    internal let maxBlocksPerMultiprocessor: Int32

    /// The default context to use for swift-to-ptx lifted operations. This
    /// corresponds to the primary context of the first device, which is the same
    /// context implicitly used by the CUDA Runtime API.
    public static let defaultContext = try! PTXContext() // swiftlint:disable:this force_try

    @inline(__always)
    internal var warpSize: Int32 {
        return 32
    }

    /// Initialise (retain) the primary context on the given GPU ordinal
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__PRIMARY__CTX.html#group__CUDA__PRIMARY__CTX_1g9051f2d5c31501997a6cb0530290a300
    public init(deviceID: Int = 0) throws(CUDAError) {
        let zone = #Zone
        defer { zone.end() }

        var rawDevice: CUdevice = 0
        var rawContext: CUcontext? = nil

        try cuda_safe_call { cuInit(0) }
        try cuda_safe_call { cuDeviceGet(&rawDevice, Int32(deviceID)) }
        try cuda_safe_call { cuDevicePrimaryCtxRetain(&rawContext, rawDevice) }
        try cuda_safe_call { cuCtxPushCurrent_v2(rawContext) }

        // Nicely format some information about the selected device, e.g.:
        // Device 0: GeForce 9600M GT (compute capability 1.1), 4 multiprocessors @ 1.25GHz (32 cores), 512MB global memory
        //
        // XXX: Because we don't have a typed-throws variant of creating a
        // temporary buffer, we need to do a bit of work to tunnel the result
        // out of the closure without expanding it into an 'any Error' context.
        func tunnel(buffer: UnsafeMutableBufferPointer<CChar>) -> Result<String, CUDAError> {
            do {
                try cuda_safe_call { cuDeviceGetName(buffer.baseAddress, 128, rawDevice) }
                return .success(String(cString: buffer.baseAddress!)) // swiftlint:disable:this force_unwrapping
            }
            catch {
                return .failure(error)
            }
        }
        let name = try withUnsafeTemporaryAllocation(of: CChar.self, capacity: 128, tunnel).get()

        var major: Int32 = 0
        var minor: Int32 = 0
        try cuda_safe_call { cuDeviceGetAttribute(&major, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR, rawDevice) }
        try cuda_safe_call { cuDeviceGetAttribute(&minor, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR, rawDevice) }

        // Define the GPU architecture types (using the SM version in
        // hexadecimal notation) to determine the number of cores per SM.
        // swiftlint:disable colon
        let gpuArchCoresPerSM: [Int32: Int32] =
            [
                0x30: 192, 0x32: 192, 0x35: 192, 0x37: 192,
                0x50: 128, 0x52: 128, 0x53: 128,
                0x60:  64, 0x61: 128, 0x62: 128,
                0x70:  64, 0x72:  64, 0x75:  64,
                0x80:  64, 0x86: 128, 0x87: 128, 0x89: 128,
                0x90: 128,
            ]
        // swiftlint:enable colon
        let coresPerMP =
            if let x = gpuArchCoresPerSM[(major << 4) + minor] { x } else {
                fatalError("Number of cores for SM \(major).\(minor) is undefined") // swiftlint:disable:this no_fatalerror
            }
        var multiProcessorCount: Int32 = 0
        try cuda_safe_call { cuDeviceGetAttribute(&multiProcessorCount, CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT, rawDevice) }

        var maxThreadsPerMultiprocessor: Int32 = 0
        try cuda_safe_call { cuDeviceGetAttribute(
            &maxThreadsPerMultiprocessor,
            CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR,
            rawDevice
        ) }

        var maxBlocksPerMultiprocessor: Int32 = 0
        try cuda_safe_call {
            cuDeviceGetAttribute(&maxBlocksPerMultiprocessor, CU_DEVICE_ATTRIBUTE_MAX_BLOCKS_PER_MULTIPROCESSOR, rawDevice) }

        var totalGlobalMem: Int = 0
        try cuda_safe_call { cuDeviceTotalMem_v2(&totalGlobalMem, rawDevice) }

        var gpuClock: Int32 = 0
        try cuda_safe_call { cuDeviceGetAttribute(&gpuClock, CU_DEVICE_ATTRIBUTE_CLOCK_RATE, rawDevice) }

        try cuda_safe_call { cuCtxPopCurrent_v2(nil) }

        // swiftformat:disable:next wrap
        logger.trace("Device 0: \(name) (compute capability \(major).\(minor)), \(multiProcessorCount) multiprocessors @ \(gpuClock / 1000) MHz (\(coresPerMP * multiProcessorCount) cores), \(totalGlobalMem / (1024 * 1024)) MB global memory")

        self.rawDevice = rawDevice
        self.rawContext = rawContext! // swiftlint:disable:this force_unwrapping
        self.multiProcessorCount = multiProcessorCount
        self.maxThreadsPerMultiprocessor = maxThreadsPerMultiprocessor
        self.maxBlocksPerMultiprocessor = maxBlocksPerMultiprocessor
    }

    /// Pushes this context onto the current CPU thread
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__CTX.html#group__CUDA__CTX_1gb02d4c850eb16f861fe5a29682cc90ba
    public func push() throws(CUDAError) {
        try cuda_safe_call { cuCtxPushCurrent_v2(self.rawContext) }
    }

    /// Pops the current context from the current CPU thread
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__CTX.html#group__CUDA__CTX_1g2fac188026a062d92e91a8687d0a7902
    public func pop() throws(CUDAError) {
        try cuda_safe_call { cuCtxPopCurrent_v2(nil) }
    }

    /// Release the primary context from this device
    /// https://docs.nvidia.com/cuda/archive/12.6.3/cuda-driver-api/group__CUDA__PRIMARY__CTX.html#group__CUDA__PRIMARY__CTX_1gf2a8bc16f8df0c88031f6a1ba3d6e8ad
    public func destroy() throws(CUDAError) {
        try cuda_safe_call { cuDevicePrimaryCtxRelease_v2(self.rawDevice) }
    }
}
