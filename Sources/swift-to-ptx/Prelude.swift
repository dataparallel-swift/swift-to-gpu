
// Running the corresponding llvm optimisation plugin on code that calls this
// function will result in the 'body' closure being translated into a CUDA
// kernel such that all `iterations` are executed at once in data-parallel.
//
@inline(never)  // we need to access this from the llvm-plugin
public func parallel_for
(
    iterations: Int,
    _ body:     (Int) -> (),
    context:    Context = defaultContext,
    allocator:  CachingHostAllocator = smallBlockAllocator,
    stream:     Stream = streamPerThread
)
{
    dontLetTheCompilerOptimizeThisAway(context)
    dontLetTheCompilerOptimizeThisAway(allocator)
    dontLetTheCompilerOptimizeThisAway(stream)
    for i in 0..<iterations {
        body(i)
    }
}

private var blackhole: Any?
@inline(never)
func dontLetTheCompilerOptimizeThisAway<T>(_ it: T) {
    blackhole = it
}

