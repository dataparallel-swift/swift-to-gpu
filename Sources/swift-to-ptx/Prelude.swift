
// Running the corresponding llvm optimisation plugin on code that calls this
// function will result in the 'body' closure being translated into a CUDA
// kernel such that all `iterations` are executed at once in data-parallel.
//
@inline(never)
public func parallel_for(iterations: Int, _ body: (Int) -> ()) {
    for i in 0..<iterations {
        body(i)
    }
}

