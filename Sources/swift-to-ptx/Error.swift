// Copyright (c) 2025 PassiveLogic, Inc.

import CUDA

public struct CUDAError: Error, CustomStringConvertible {
    let status: CUresult
    public var description: String {
        var name: UnsafePointer<CChar>? = nil
        var desc: UnsafePointer<CChar>? = nil
        cuGetErrorName(status, &name)
        cuGetErrorString(status, &desc)
        // These are pointers to static strings, they can never be null
        // swiftlint:disable:next force_unwrapping
        return "CUDA call failed with error \(String(cString: name!)) (\(status.rawValue)): \(String(cString: desc!))"
    }
}

@usableFromInline
func cuda_safe_call(_ function: () -> CUresult) throws(CUDAError) {
    let result = function()
    guard CUDA_SUCCESS == result else {
        throw CUDAError(status: result)
    }
}

@usableFromInline
func cuda_safe_async_call(_ function: () -> CUresult) throws(CUDAError) -> Bool {
    let result = function()
    return switch result {
        case CUDA_SUCCESS: true
        case CUDA_ERROR_NOT_READY: false
        default: throw CUDAError(status: result)
    }
}
