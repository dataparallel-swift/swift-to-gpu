import CUDA
import Logging

private let logger = Logger(label: "Marshal")

public func getDevicePointer(_ ptr: UnsafeMutableRawPointer, _ count: Int, _ stride: Int) -> CUdeviceptr
{
    var dptr : CUdeviceptr = 0
    let bytes = count * stride

    let result = cuMemHostRegister_v2(ptr, bytes, UInt32(CU_MEMHOSTREGISTER_DEVICEMAP))
    switch result {
        // Allowing the ALREADY_REGISTERED case to count as success might hide
        // some subtle bugs (e.g. choosing the size of the array incorrectly, or
        // if the size needs to be page aligned, etc.), but simplifies not
        // having to keep track of what we have registered ourselves.
        case CUDA_SUCCESS, CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED: break;
        default:
            var name : UnsafePointer<CChar>? = nil
            var desc : UnsafePointer<CChar>? = nil
            cuGetErrorName(result, &name)
            cuGetErrorString(result, &desc)
            fatalError("CUDA call failed with error \(String.init(cString: name!)) (\(result.rawValue)): \(String.init(cString: desc!)): ptr=\(ptr), count=\(count), stride=\(stride)")
    }

    cuda_safe_call{cuMemHostGetDevicePointer_v2(&dptr, ptr, 0)}

    logger.info("Registered \(bytes) bytes of memory @ \(ptr)")
    return dptr
}

public func getDevicePointer<T>(_ ptr: UnsafeMutablePointer<T>, _ count: Int) -> CUdeviceptr
{
    getDevicePointer(ptr, count, MemoryLayout<T>.stride)
}

// public func getDevicePointer(_ buffer: UnsafeMutableRawBufferPointer, _ count: Int, stride: Int) -> CUdeviceptr
// {
//     getDevicePointer(buffer.baseAddress!, count, stride)
// }

// public func getDevicePointer<T>(_ buffer: UnsafeMutableBufferPointer<T>) -> CUdeviceptr
// {
//     getDevicePointer(buffer.baseAddress!, buffer.count, MemoryLayout<T>.stride)
// }

// public func getDevicePointer<T>(_ array: inout Array<T>) -> CUdeviceptr
// {
//     array.withUnsafeMutableBufferPointer{getDevicePointer($0)}
// }

// public func getDevicePointer<T>(_ array: inout ContiguousArray<T>) -> CUdeviceptr
// {
//     array.withUnsafeMutableBufferPointer{getDevicePointer($0)}
// }

// public func getDevicePointer<T>(_ array: Array<T>) -> CUdeviceptr
// {
//     array.withUnsafeBufferPointer{getDevicePointer(UnsafeMutableBufferPointer(mutating: $0))}
// }

