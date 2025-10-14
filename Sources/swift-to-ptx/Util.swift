// Copyright (c) 2025 PassiveLogic, Inc.

import CUDA

@usableFromInline
func cuda_safe_call(file: StaticString = #file, line: UInt = #line, _ function: () -> CUresult) {
    let result = function()
    guard CUDA_SUCCESS == result else {
        var name: UnsafePointer<CChar>? = nil
        var desc: UnsafePointer<CChar>? = nil
        cuGetErrorName(result, &name)
        cuGetErrorString(result, &desc)
        // swiftformat:disable wrap wrapArguments
        // swiftlint:disable:next force_unwrapping no_fatalerror
        fatalError("CUDA call failed with error \(String(cString: name!)) (\(result.rawValue)): \(String(cString: desc!))", file: file, line: line)
    }
}
