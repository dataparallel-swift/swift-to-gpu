
import Foundation
import CUDA

@usableFromInline
func cuda_safe_call(file: StaticString = #file, line: UInt = #line, _ function: () -> CUresult) -> ()
{
    let result = function()
    guard CUDA_SUCCESS == result else {
        var name : UnsafePointer<CChar>? = nil
        var desc : UnsafePointer<CChar>? = nil
        cuGetErrorName(result, &name)
        cuGetErrorString(result, &desc)
        fatalError("CUDA call failed with error \(String.init(cString: name!)) (\(result.rawValue)): \(String.init(cString: desc!))", file: file, line: line)
    }
}

@usableFromInline
func bool(_ val: Int32) -> String
{
    val == 0 ? "no" : "yes"
}

// Define the GPU architecture types (using the SM version in hexadecimal
// notation) to determine the number of cores per SM.
let gpuArchCoresPerSM : [Int32: Int32] =
    [ 0x30: 192 , 0x32: 192 , 0x35: 192 , 0x37: 192
    , 0x50: 128 , 0x52: 128 , 0x53: 128
    , 0x60:  64 , 0x61: 128 , 0x62: 128
    , 0x70:  64 , 0x72:  64 , 0x75:  64
    , 0x80:  64 , 0x86: 128 , 0x87: 128 , 0x89: 128
    , 0x90: 128
    ]

// Initialise the CUDA runtime and query the attributes for each connected device
var ver : Int32 = 0
var count : Int32 = 0
cuda_safe_call{cuDriverGetVersion(&ver)}

print("CUDA API version \(ver / 1000).\((ver % 100)/10)")

cuda_safe_call{cuInit(0)}
cuda_safe_call{cuDeviceGetCount(&count)}

if count == 0 {
    print("No CUDA capable devices were detected")
} else {
    print("Detected \(count) CUDA capable device\(count > 1 ? "s" : "")")

    for devid in 0..<count {
        var dev : CUdevice = 0
        cuda_safe_call{cuDeviceGet(&dev, devid)}

        let name = withUnsafeTemporaryAllocation(of: CChar.self, capacity: 128, { buffer in
            cuda_safe_call{cuDeviceGetName(buffer.baseAddress, 128, dev)}
            return String.init(cString: buffer.baseAddress!)
        })

        var major : Int32 = 0
        var minor : Int32 = 0
        cuda_safe_call{cuDeviceGetAttribute(&major, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&minor, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR, dev)}

        var multiProcessorCount : Int32 = 0
        let coresPerMP =
          if let r = gpuArchCoresPerSM[(major << 4)+minor] { r } else {
              fatalError("Number of cores for SM \(major).\(minor) is undefined")
          }
        cuda_safe_call{cuDeviceGetAttribute(&multiProcessorCount, CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT, dev)}

        var totalGlobalMem = 0
        var totalConstantMem : Int32 = 0
        var sharedMemoryPerBlock : Int32 = 0
        var registersPerBlock : Int32 = 0
        var l2CacheSize : Int32 = 0
        cuda_safe_call{cuDeviceTotalMem_v2(&totalGlobalMem, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&totalConstantMem, CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&sharedMemoryPerBlock, CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&registersPerBlock, CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&l2CacheSize, CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE, dev)}

        var warpSize : Int32 = 0
        var maxThreadsPerMultiprocessor : Int32 = 0
        var maxThreadsPerBlock : Int32 = 0
        var maxBlockDim : (Int32, Int32, Int32) = (0, 0, 0)
        var maxGridDim : (Int32, Int32, Int32) = (0, 0, 0)
        cuda_safe_call{cuDeviceGetAttribute(&warpSize, CU_DEVICE_ATTRIBUTE_WARP_SIZE, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxThreadsPerMultiprocessor, CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxThreadsPerBlock, CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxBlockDim.0, CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxBlockDim.1, CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxBlockDim.2, CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxGridDim.0, CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxGridDim.1, CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&maxGridDim.2, CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z, dev)}

        var gpuClock : Int32 = 0
        var memoryClock : Int32 = 0
        var memoryBusWidth : Int32 = 0
        cuda_safe_call{cuDeviceGetAttribute(&gpuClock, CU_DEVICE_ATTRIBUTE_CLOCK_RATE, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&memoryClock, CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&memoryBusWidth, CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH, dev)}

        var concurrentKernels : Int32 = 0
        var gpuOverlap : Int32 = 0
        var asyncEngineCount : Int32 = 0
        var kernelExecTimeoutEnabled : Int32 = 0
        var integrated : Int32 = 0
        var canMapHostMemory : Int32 = 0
        var canUseHostPointer : Int32 = 0
        var eccEnabled : Int32 = 0
        var unifedAddressing : Int32 = 0
        var computePreemption : Int32 = 0
        var cooperativeLaunch : Int32 = 0
        var cooperativeLaunchMulti : Int32 = 0
        cuda_safe_call{cuDeviceGetAttribute(&concurrentKernels, CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&gpuOverlap, CU_DEVICE_ATTRIBUTE_GPU_OVERLAP, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&asyncEngineCount, CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&kernelExecTimeoutEnabled, CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&integrated, CU_DEVICE_ATTRIBUTE_INTEGRATED, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&canMapHostMemory, CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&canUseHostPointer, CU_DEVICE_ATTRIBUTE_CAN_USE_HOST_POINTER_FOR_REGISTERED_MEM, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&eccEnabled, CU_DEVICE_ATTRIBUTE_ECC_ENABLED, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&unifedAddressing, CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&computePreemption, CU_DEVICE_ATTRIBUTE_COMPUTE_PREEMPTION_SUPPORTED, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&cooperativeLaunch, CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&cooperativeLaunchMulti, CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH, dev)}

        var pageableMemory : Int32 = 0
        var virtualMemory : Int32 = 0
        var managedMemory : Int32 = 0
        var managedMemoryConcurrent : Int32 = 0
        var managedMemoryFromHost : Int32 = 0
        cuda_safe_call{cuDeviceGetAttribute(&pageableMemory, CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&virtualMemory, CU_DEVICE_ATTRIBUTE_VIRTUAL_MEMORY_MANAGEMENT_SUPPORTED, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&managedMemory, CU_DEVICE_ATTRIBUTE_MANAGED_MEMORY, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&managedMemoryConcurrent, CU_DEVICE_ATTRIBUTE_CONCURRENT_MANAGED_ACCESS, dev)}
        cuda_safe_call{cuDeviceGetAttribute(&managedMemoryFromHost, CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST, dev)}

        print("Device \(devid): \(name)")
        print("  CUDA capability:                               \(major).\(minor)")
        print("  CUDA cores:                                    \(coresPerMP * multiProcessorCount) cores in \(multiProcessorCount) multiprocessors (\(coresPerMP) cores/MP)")
        print("  Global memory:                                 \(totalGlobalMem / 1048576) MB")
        print("  Constant memory:                               \(totalConstantMem / 1024) kB")
        print("  Shared memory per block:                       \(sharedMemoryPerBlock / 1024) kB")
        print("  L2 cache per block:                            \(l2CacheSize / 1024) kB")
        print("  Registers per block:                           \(registersPerBlock)")
        print("  Maximum threads per multiprocessor:            \(maxThreadsPerMultiprocessor)")
        print("  Maximum threads per block:                     \(maxThreadsPerBlock)")
        print("  Maximum grid dimensions:                       \(maxGridDim)")
        print("  Maximum block dimensions:                      \(maxBlockDim)")
        print("  GPU clock frequency:                           \(gpuClock / 1000) MHz")
        print("  Memory clock frequency:                        \(memoryClock / 1000) MHz")
        print("  Memory bus width:                              \(memoryBusWidth)-bit")
        print("  Concurrent kernel execution:                   \(bool(concurrentKernels))")
        print("  Concurrent copy and kernel execution:          \(gpuOverlap == 0 ? "no" : "yes, with \(asyncEngineCount) copy engine\(asyncEngineCount > 1 ? "s" : "")")")
        print("  Runtime limit on kernel execution:             \(bool(kernelExecTimeoutEnabled))")
        print("  Integrated GPU sharing host memory:            \(bool(integrated))")
        print("  Host page-locked memory mapping:               \(bool(canMapHostMemory))")
        print("  Can access registered memory:                  \(bool(canUseHostPointer))")
        print("  ECC memory support:                            \(bool(eccEnabled))")
        print("  Unified addressing (UVA):                      \(bool(unifedAddressing))")
        print("  Compute preemption:                            \(bool(computePreemption))")
        print("  Direct access to pageable memory:              \(bool(pageableMemory))")
        print("  Virtual memory management:                     \(bool(virtualMemory))")
        print("  Managed memory:                                \(bool(managedMemory))")
        if managedMemory != 0 {
            print("    Concurrent access with host:                 \(bool(managedMemoryConcurrent))")
            print("    Direct access from host:                     \(bool(managedMemoryFromHost))")
        }
        print("  Cooperative kernel launch:                     \(bool(cooperativeLaunch))")
        print("  Multi-device cooperative kernel launch:        \(bool(cooperativeLaunchMulti))")
        print("")
    }
}

