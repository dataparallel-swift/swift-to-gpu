import Logging


// Running the corresponding llvm optimisation plugin on code that calls this
// function will result in the 'body' closure being translated into a CUDA
// kernel such that all `iterations` are executed at once in data-parallel.
//
//
@discardableResult
// ↓ disabled until we tackle generic specialisation ---TLM 2025-02-26
// @_alwaysEmitIntoClient  // make sure the body can be specialised at the call site...
@inline(never)          // ...but don't actually inline it; we still need to look for this symbol from the llvm-plugin
public func parallel_for<E: Error>
(
    iterations: Int,
    context:    Context = defaultContext,
    allocator:  CachingHostAllocator = smallBlockAllocator,
    stream:     Stream = streamDefault,
    _ body:     (Int) throws(E) -> ()
) throws(E) -> Event
{
    // Initialise and use the logger directly inline in order to avoid needing
    // to mark it as usableFromInline, as that causes conflicts with the loggers
    // defined in other modules (and which are actually used).
    let logger = Logger.init(label: "")
    logger.warning("""
        *** WARNING *** parallel_for loop executing on the host!
        Compile in release mode to enable PTX translation. Failing that, please submit a bug to: https://gitlab.com/PassiveLogic/experiments/swift-to-ptx/-/issues
        """)

    dontLetTheCompilerOptimizeThisAway(context)
    dontLetTheCompilerOptimizeThisAway(allocator)
    dontLetTheCompilerOptimizeThisAway(stream)

    for i in 0..<iterations {
        try body(i)
    }

    return Event.init()
}

@inline(never)
@usableFromInline
func dontLetTheCompilerOptimizeThisAway<T>(_ it: T) {
    blackhole = it
}

private var blackhole: Any?

