/// # Swift-to-PTX

// Annotations that are required for public-facing functions:
//
//   @inlinable -- makes the function body available to clients as part of the
//   module's public interface. This makes the implementation of the function
//   available to the optimizer when referenced from other modules so that it
//   can be inlined/optimised in the caller. Without @inlinable all calls to
//   generics in other modules will be made to the unspecialised version.

//   Note that this could be a problem if we want to keep a stable ABI, because
//   old versions will continue to exist (and might have already been inlined
//   into a client somewhere). This can be a problem with library evolution (so,
//   we probably don't need to care about it for a while).
//
//   @_alwaysEmitIntoClient -- similar to inlinable, but the declaration is not
//   part of the module's ABI, meaning that the client must always emit their
//   own copy.
//
//   @inline(__always) -- ignore compiler inlining heuristics and always inline
//   the function. Outside the current module this will only be possible if the
//   body of the function is available (via one of the above two annotations).
//   We need this so that the public API functions are all optimised out so that
//   we are only left with a bare parallel_for (that the plugin looks for).

import Atomics
import Logging

/// ## Construction
/// ### Initialisation

/// Construct a new array by applying a function at each index
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func generate<A, E: Error>(count: Int, _ f: (Int) throws(E) -> A) throws(E) -> Array<A>
{
    var xs = Array<A>.init(unsafeUninitializedCapacity: count)
    try parallel_for(iterations: count) { i throws(E) in
        xs[i] = try f(i)
    }
    return xs
}

/// Regenerate an existing array by applying a function at each index
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func generate<A, E: Error>(into: inout Array<A>, _ f: (Int) throws(E) -> A) throws(E)
{
    try parallel_for(iterations: into.count) { i throws (E) in
        into[i] = try f(i)
    }
}

/// Construct a new array where all elements have the same element
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func fill<A>(with x: A, count: Int) -> Array<A>
{
    generate(count: count) { _ in x }
}

/// Set all elements of an array to the given value
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func fill<A>(with x: A, into: inout Array<A>)
{
    generate(into: &into) { _ in x }
}

/// ## Element-wise operations

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func map<A, B, E: Error>(_ xs: Array<A>, _ f: (A) throws(E) -> B) throws(E) -> Array<B>
{
    try imap(xs) { _, x throws(E) in try f(x) }
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func map<A, E: Error>(_ /* into */ xs: inout Array<A>, _ f: (A) throws(E) -> A) throws(E)
{
    try imap(&xs) { _, x throws(E) in try f(x) }
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func imap<A, B, E: Error>(_ xs: Array<A>, _ f: (Int, A) throws(E) -> B) throws(E) -> Array<B>
{
    try generate(count: xs.count) { i throws(E) in
        try f(i, xs[i])
    }
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func imap<A, E: Error>(_ /* into */ xs: inout Array<A>, _ f: (Int, A) throws(E) -> A) throws(E)
{
    try parallel_for(iterations: xs.count) { i throws(E) in
        xs[i] = try f(i, xs[i])
    }
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func zipWith<A, B, C, E: Error>(_ xs: Array<A>, _ ys: Array<B>, _ f: (A,B) throws(E) -> C) throws(E) -> Array<C>
{
    try generate(count: min(xs.count, ys.count)) { i throws(E) in
        try f(xs[i], ys[i])
    }
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func zipWith<A, B, E: Error>(_ /* into */ xs: inout Array<A>, _ ys: Array<B>, truncating: Bool = false, _ f: (A,B) throws(E) -> A) throws(E)
{
    let n = min(xs.count, ys.count)
    if truncating && xs.count > n {
        xs = Array(xs.prefix(n))
    }

    try parallel_for(iterations: n) { i throws(E) in
        xs[i] = try f(xs[i], ys[i])
    }
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func zipWith<A, B, E: Error>(_ xs: Array<A>, _ /* into */ ys: inout Array<B>, truncating: Bool = false, _ f: (A,B) throws(E) -> B) throws(E)
{
    let n = min(xs.count, ys.count)
    if truncating && ys.count > n {
        ys = Array(ys.prefix(n))
    }

    try parallel_for(iterations: n) { i throws(E) in
        ys[i] = try f(xs[i], ys[i])
    }
}

// TODO: [i,]zipWith[3..9], [un,]zip[3..9]
//  Unsure how many of these will be used in practice, esp. without a fusion
//  framework in place to combine combinators.


/// ## Permutations
/// ### Forward permutations (scatter)

/// Generalised forward permutation operation (array scatter, parallel array
/// write)
///
/// Forward permutation specified by a function mapping indices from the source
/// array to indices in the destination array. Any values that are permuted into
/// the result array are added to the current value using the given combination
/// function.
///
/// The combination function must be associative and commutative. Elements for
/// which the permutation function returns 'nil' are dropped.
///
/// The combination function is given the new value being permuted as its first
/// argument, and the current value of the array as its second.
///
/// For example, we can use permute to compute the occurrence count (histogram)
/// for an array of values in the range [0,10):
///
/// ```swift
/// func histogram(_ xs: Array<Int>) -> Array<Int>
/// {
///     let ones    = fill(with: 1, count: xs.count)    // wouldn't it be great if this could fuse...
///     var buckets = fill(with: 0, count: 10)
///
///     permute(from: ones, into: &buckets, combining: +) { xs[$0] }
///
///     return buckets
/// }
/// ```
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func permute<A, E: Error>(from: Array<A>, into: inout Array<A>, combining f: (A, A) throws(E) -> A, _ p: (Int) throws(E) -> Int?) throws(E)
{
    typealias Lock = UInt32.AtomicRepresentation
    var locks : Array<Lock> = fill(with: .init(0), count: from.count)

    try parallel_for(iterations: from.count) { i throws(E) in
        if let j = try p(i) {
            // Mutex spin-lock with exponential backoff. This is only valid on
            // compute devices 7.0 or higher that have independent thread
            // scheduling. For older devices that have warp scheduling, this can
            // deadlock.
            //
            // Here, 0 means the element at that slot is unlocked, 1 means that
            // the slot is currently locked.
            var ns : UInt32 = 8
            while Lock.atomicCompareExchange(expected: 0, desired: 1, at: &locks[i], ordering: .acquiring).original == 1 {
                nanosleep(ns)
                if ns < 256 {
                    ns = ns * 2
                }
            }

            // Critical section
            let new = from[i]
            let old = into[j]
            into[j] = try f(new, old)

            // Mutex unlock. We lack atomic store instructions on 32-bit
            // integers, so use atomic exchange instead.
            let _ = Lock.atomicExchange(0, at: &locks[i], ordering: .releasing)
        }
    }
}

/// A variant of permute that does not take a combination function, and simply
/// replaces elements in the destination array with new values. If the
/// permutation function maps multiple elements to the same location (the
/// function is not surjective) then the result is non-deterministic.
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func permute<A, E: Error>(from: Array<A>, into: inout Array<A>, _ p: (Int) throws(E) -> Int?) throws(E)
{
    try parallel_for(iterations: from.count) { i throws(E) in
        if let j = try p(i) {
            into[j] = from[i]
        }
    }
}

/// ### Backward permutations (gather)

/// Generalised backwards permutation operation (array gather, parallel array
/// read)
///
/// Backward permutation specified by a function mapping indices in the
/// destination array to indices in the source array. Elements of the output
/// array are thus generated by reading from the corresponding index in the
/// source array.
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, count: Int, _ p: (Int) throws(E) -> Int) throws(E) -> Array<A>
{
    var into = Array<A>.init(unsafeUninitializedCapacity: count)
    try backpermute(from: from, into: &into, p)
    return into
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, into: inout Array<A>, _ p: (Int) throws(E) -> Int) throws(E)
{
    try parallel_for(iterations: into.count) { i throws(E) in
        into[i] = from[try p(i)]
    }
}

/// Backwards permutation where the permutation function provides either the
/// index to read the source value from, or provides it directly (nominally, a
/// constant value used as a default)
// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, count: Int, _ p: (Int) throws(E) -> Either<Int,A>) throws(E) -> Array<A>
{
    var into = Array<A>.init(unsafeUninitializedCapacity: count)
    try backpermute(from: from, into: &into, p)
    return into
}

// @inlinable
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, into: inout Array<A>, _ p: (Int) throws(E) -> Either<Int,A>) throws(E)
{
    try parallel_for(iterations: into.count) { i throws(E) in
        let v = switch try p(i) {
            case .left(let j): from[j]
            case .right(let v): v
        }
        into[i] = v
    }
}


/// ### Specialised permutations
// filter
// compact

/// ## Folding
// fold, fold1
// foldSeg, fold1Seg

/// ## Scans (prefix-sums)
// scanl, scanl1, scanl'
// scanr, scanr1, scanr'
// ... and segmented versions of the above

/// ## Stencils

// --------------------------------------------------------------------------------
// Internals
// --------------------------------------------------------------------------------

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

// This will be replaced by an nvvm intrinsic
@inline(never)
@usableFromInline
func nanosleep(_ ns: UInt32) {
    dontLetTheCompilerOptimizeThisAway(ns)
}

@inline(never)
@usableFromInline
func dontLetTheCompilerOptimizeThisAway<T>(_ it: T) {
    blackhole = it
}

private var blackhole: Any?

