import CUDA
import Logging

private let logger = Logger(label: "CUDA Context")

internal class Context {
    var device : CUdevice = 0
    var context : CUcontext? = nil

    init(deviceID: Int = 0) {
        cuda_safe_call{cuInit(0)}
        cuda_safe_call{cuDeviceGet(&self.device, Int32(deviceID))}
        cuda_safe_call{cuCtxCreate_v2(&self.context, CU_CTX_MAP_HOST.rawValue, self.device)}

        // Nicely format some information about the selected device
        // Device 0: GeForce 9600M GT (compute capability 1.1), 4 multiprocessors @ 1.25GHz (32 cores), 512MB global memory
        //
        let name = withUnsafeTemporaryAllocation(of: CChar.self, capacity: 128, { buffer in
            cuda_safe_call{cuDeviceGetName(buffer.baseAddress, 128, self.device)}
            return String.init(cString: buffer.baseAddress!)
        })

        var major : Int32 = 0
        var minor : Int32 = 0
        cuda_safe_call{cuDeviceGetAttribute(&major, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR, self.device)}
        cuda_safe_call{cuDeviceGetAttribute(&minor, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR, self.device)}

        // Define the GPU architecture types (using the SM version in
        // hexadecimal notation) to determine the number of cores per SM.
        let gpuArchCoresPerSM : [Int32: Int32] =
            [ 0x30: 192 , 0x32: 192 , 0x35: 192 , 0x37: 192
            , 0x50: 128 , 0x52: 128 , 0x53: 128
            , 0x60:  64 , 0x61: 128 , 0x62: 128
            , 0x70:  64 , 0x72:  64 , 0x75:  64
            , 0x80:  64 , 0x86: 128 , 0x87: 128 , 0x89: 128
            , 0x90: 128
            ]
        let coresPerMP =
          if let r = gpuArchCoresPerSM[(major << 4)+minor] { r } else {
              fatalError("Number of cores for SM \(major).\(minor) is undefined")
          }
        var multiProcessorCount : Int32 = 0
        cuda_safe_call{cuDeviceGetAttribute(&multiProcessorCount, CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT, self.device)}

        var totalGlobalMem = 0
        cuda_safe_call{cuDeviceTotalMem_v2(&totalGlobalMem, self.device)}

        var gpuClock : Int32 = 0
        cuda_safe_call{cuDeviceGetAttribute(&gpuClock, CU_DEVICE_ATTRIBUTE_CLOCK_RATE, self.device)}

        logger.info("Device \(deviceID): \(name) (compute capability \(major).\(minor)), \(multiProcessorCount) multiprocessors @ \(gpuClock / 1000) MHz (\(coresPerMP * multiProcessorCount) cores), \(totalGlobalMem / (1024 * 1024)) MB global memory")
    }

    deinit {
        cuda_safe_call{cuCtxDestroy_v2(self.context)}
    }
}

