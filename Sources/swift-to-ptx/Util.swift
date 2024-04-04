import CUDA

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

