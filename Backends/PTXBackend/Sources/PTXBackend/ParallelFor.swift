// Copyright (c) 2025 PassiveLogic, Inc.

// Running the corresponding llvm optimisation plugin on code that calls this
// function will result in the 'body' closure being translated into a CUDA
// kernel such that all `iterations` are executed at once in data-parallel.
//
// TODO: We have a bunch of force-try in other parts of the code because we need
// to work out how to return multiple static types from the parallel_for (and
// have the compiler pass understand and use it).
//
// ↓ disabled until we tackle generic specialisation ---TLM 2025-02-26
// @_alwaysEmitIntoClient  // make sure the body can be specialised at the call site...
@inline(never)          // ...but don't actually inline it; we still need to look for this symbol from the llvm-plugin
// Internal function
// swiftlint:disable:next missing_docs
func parallel_for<E: Error>(
    iterations: Int,
    context: PTXContext = .defaultContext,
    allocator: CachingHostAllocator = .smallBlockAllocator,
    stream: PTXStream = streamPerThread,
    _: (Int) throws(E) -> Void
) throws(E) -> PTXEvent {
    dontLetTheCompilerOptimizeThisAway(iterations)
    dontLetTheCompilerOptimizeThisAway(context)
    dontLetTheCompilerOptimizeThisAway(allocator)
    dontLetTheCompilerOptimizeThisAway(stream)
    // swiftlint:disable:next no_fatalerror
    fatalError("""
    Swift-to-PTX translation failed.
    Compile in release mode to enable PTX translation. Failing that, please submit a bug to:
    https://gitlab.com/PassiveLogic/compiler/swift-to-ptx/-/issues
    """)
}

public func parallel_for<E: Error>(
    iterations: Int,
    _ body: (Int) throws(E) -> Void
) throws(E) -> PTXEvent {
    try parallel_for(iterations: iterations, context: .defaultContext, allocator: .smallBlockAllocator, body)
}

@inline(never)
@usableFromInline
func dontLetTheCompilerOptimizeThisAway<T>(_ it: T) {
    blackhole = it
}

private nonisolated(unsafe) var blackhole: Any?
