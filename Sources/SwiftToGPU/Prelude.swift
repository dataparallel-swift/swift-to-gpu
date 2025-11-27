// Copyright (c) 2025 PassiveLogic, Inc.

// swiftlint:disable identifier_name force_try
// swiftformat:disable unusedArguments

// NOTE [Annotations that are required for public-facing functions]:
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

#if CPU
import CPUBackend
#endif
#if PTX
import PTXBackend
#endif

/// # Construction
/// ## Initialisation

/// Construct a new array by applying a function at each index
@inline(__always)
@_alwaysEmitIntoClient
public func generate<A, E: Error>(
    count: Int,
    _ f: (Int) throws(E) -> A
) throws(E) -> Array<A> {
    // SEE: [Array initialiser with typed throws]
    var xs = Array<A>(unsafeUninitializedCapacity: count)
    try generate(into: &xs, f)
    return xs
}

/// Regenerate an existing array by applying a function at each index
@inline(__always)
@_alwaysEmitIntoClient
public func generate<A, E: Error>(
    into xs: inout Array<A>,
    _ f: (Int) throws(E) -> A
) throws(E) {
    let event = try parallel_for(iterations: xs.count) { i throws(E) in
        xs[i] = try f(i)
    }
    try! event.sync()
}

/// Construct a new array where all elements have the same element
@inline(__always)
@_alwaysEmitIntoClient
public func fill<A>(count: Int, with x: A) -> Array<A> {
    generate(count: count) { _ in x }
}

/// Set all elements of an array to the given value
@inline(__always)
@_alwaysEmitIntoClient
public func fill<A>(into xs: inout Array<A>, with x: A) {
    generate(into: &xs) { _ in x }
}

/// ## Element-wise operations

/// Construct a new array by applying the function `f` element-wise to an array.
/// Denotationally we have:
///
/// > map([x₁, x₂, x₃], f) === [f(x₁), f(x₂), f(x₃)]
///
@inline(__always)
@_alwaysEmitIntoClient
public func map<A, B, E: Error>(
    _ xs: Array<A>,
    _ f: (A) throws(E) -> B
) throws(E) -> Array<B> {
    try imap(xs) { _, x throws(E) in try f(x) }
}

/// Update an array by applying a function `f` element-wise to each value of the
/// source array `xs`. At most the first `xs.count` elements of `ys` will be
/// updated.
@inline(__always)
@_alwaysEmitIntoClient
public func map<A, B, E: Error>(
    _ xs: Array<A>,
    into ys: inout Array<B>,
    _ f: (A) throws(E) -> B
) throws(E) {
    try imap(xs, into: &ys) { _, x throws(E) in try f(x) }
}

/// Construct a new array by applying a function `f` to every element of an
/// array with its index.
@inline(__always)
@_alwaysEmitIntoClient
public func imap<A, B, E: Error>(
    _ xs: Array<A>,
    _ f: (Int, A) throws(E) -> B
) throws(E) -> Array<B> {
    // SEE: [Array initialiser with typed throws]
    var ys = Array<B>(unsafeUninitializedCapacity: xs.count)
    try imap(xs, into: &ys, f)
    return ys
}

/// Update an array by applying a function to every element of the source array
/// together with its index. At most the first `xs.count` elements of `ys` will
/// be updated.
@inline(__always)
@_alwaysEmitIntoClient
public func imap<A, B, E: Error>(
    _ xs: Array<A>,
    into ys: inout Array<B>,
    _ f: (Int, A) throws(E) -> B
) throws(E) {
    let n = min(xs.count, ys.count)

    let event = try parallel_for(iterations: n) { i throws(E) in
        ys[i] = try f(i, xs[i])
    }

    try! event.sync()
}

/// Construct a new array by applying the given binary function element-wise to
/// two arrays. The extent of the new array is the intersection of the extents
/// of the two source arrays.
@inline(__always)
@_alwaysEmitIntoClient
public func zipWith<A, B, C, E: Error>(
    _ xs: Array<A>,
    _ ys: Array<B>,
    _ f: (A, B) throws(E) -> C
) throws(E) -> Array<C> {
    try izipWith(xs, ys) { _, x, y throws(E) in try f(x, y) }
}

/// Update an array by applying the binary function element-wise from the two
/// source arrays. This function has intersection semantics.
@inline(__always)
@_alwaysEmitIntoClient
public func zipWith<A, B, C, E: Error>(
    _ xs: Array<A>,
    _ ys: Array<B>,
    into zs: inout Array<C>,
    _ f: (A, B) throws(E) -> C
) throws(E) {
    try izipWith(xs, ys, into: &zs) { _, x, y throws(E) in try f(x, y) }
}

/// Construct a new array by applying the given binary function element-wise to
/// two arrays, together with the index of that element. This function has
/// intersection semantics.
@inline(__always)
@_alwaysEmitIntoClient
public func izipWith<A, B, C, E: Error>(
    _ xs: Array<A>,
    _ ys: Array<B>,
    _ f: (Int, A, B) throws(E) -> C
) throws(E) -> Array<C> {
    let n  = min(xs.count, ys.count)
    // SEE: [Array initialiser with typed throws]
    var zs = Array<C>(unsafeUninitializedCapacity: n)
    try izipWith(xs, ys, into: &zs, f)
    return zs
}

/// Update an array by applying the binary function element-wise from the two
/// source arrays, together with the index of that element. This function has
/// intersection semantics.
@inline(__always)
@_alwaysEmitIntoClient
public func izipWith<A, B, C, E: Error>(
    _ xs: Array<A>,
    _ ys: Array<B>,
    into zs: inout Array<C>,
    _ f: (Int, A, B) throws(E) -> C
) throws(E) {
    let n = min(xs.count, min(ys.count, zs.count))

    let event = try parallel_for(iterations: n) { i throws(E) in
        zs[i] = try f(i, xs[i], ys[i])
    }
    try! event.sync()
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
@inline(__always)
@_alwaysEmitIntoClient
public func permute<A, E: Error>(
    from: Array<A>,
    into: inout Array<A>,
    combining f: (A, A) throws(E) -> A,
    _ p: (Int) throws(E) -> Int?
) throws(E) {
    typealias Lock = UInt32.AtomicRepresentation
    var locks: Array<Lock> = fill(count: from.count, with: .init(0))

    let event = try parallel_for(iterations: from.count) { i throws(E) in
        if let j = try p(i) {
            // Mutex spin-lock with exponential backoff. This is only valid on
            // compute devices 7.0 or higher that have independent thread
            // scheduling. For older devices that have warp scheduling, this can
            // deadlock.
            //
            // Here, 0 means the element at that slot is unlocked, 1 means that
            // the slot is currently locked.
            var ns: UInt32 = 8
            while Lock.atomicCompareExchange(expected: 0, desired: 1, at: &locks[i], ordering: .acquiring).original == 1 {
                nanosleep(ns)
                if ns < 256 {
                    ns *= 2
                }
            }

            // Critical section
            let new = from[i]
            let old = into[j]
            into[j] = try f(new, old)

            // Mutex unlock. We lack atomic store instructions on 32-bit
            // integers, so use atomic exchange instead.
            _ = Lock.atomicExchange(0, at: &locks[i], ordering: .releasing)
        }
    }
    try! event.sync()
}

/// A variant of permute that does not take a combination function, and simply
/// replaces elements in the destination array with new values. If the
/// permutation function maps multiple elements to the same location (the
/// function is not surjective) then the result is non-deterministic.
@inline(__always)
@_alwaysEmitIntoClient
public func permute<A, E: Error>(from: Array<A>, into: inout Array<A>, _ p: (Int) throws(E) -> Int?) throws(E) {
    let event = try parallel_for(iterations: from.count) { i throws(E) in
        if let j = try p(i) {
            into[j] = from[i]
        }
    }
    try! event.sync()
}

/// ### Backward permutations (gather)

/// Generalised backwards permutation operation (array gather, parallel array
/// read)
///
/// Backward permutation specified by a function mapping indices in the
/// destination array to indices in the source array. Elements of the output
/// array are thus generated by reading from the corresponding index in the
/// source array.
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, count: Int, _ p: (Int) throws(E) -> Int) throws(E) -> Array<A> {
    // SEE: [Array initialiser with typed throws]
    var into = Array<A>(unsafeUninitializedCapacity: count)
    try backpermute(from: from, into: &into, p)
    return into
}

/// Backwards permutation operation which updates an array by reading values
/// from the source array according to the permutation function.
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, into: inout Array<A>, _ p: (Int) throws(E) -> Int) throws(E) {
    let event = try parallel_for(iterations: into.count) { i throws(E) in
        into[i] = from[try p(i)]
    }
    try! event.sync()
}

/// Backwards permutation where the permutation function provides either the
/// index to read the source value from, or provides it directly (nominally, a
/// constant value used as a default)
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, count: Int, _ p: (Int) throws(E) -> Either<Int, A>) throws(E) -> Array<A> {
    // SEE: [Array initialiser with typed throws]
    var into = Array<A>(unsafeUninitializedCapacity: count)
    try backpermute(from: from, into: &into, p)
    return into
}

/// Backwards permutation operation which updates an array according to the
/// given permutation function, which provides either an index to read the
/// source value  from, or provides it directly (nominally, a constant value
/// used as a default).
@inline(__always)
@_alwaysEmitIntoClient
public func backpermute<A, E: Error>(from: Array<A>, into: inout Array<A>, _ p: (Int) throws(E) -> Either<Int, A>) throws(E) {
    let event = try parallel_for(iterations: into.count) { i throws(E) in
        let v = switch try p(i) {
            case let .left(j): from[j]
            case let .right(v): v
        }
        into[i] = v
    }
    try! event.sync()
}

// # Specialised permutations
// filter
// compact

// # Folding
// fold, fold1
// foldSeg, fold1Seg

// # Scans (prefix-sums)
// scanl, scanl1, scanl'
// scanr, scanr1, scanr'
// ... and segmented versions of the above

// # Stencils
// cursored stencils?

// --------------------------------------------------------------------------------
// Internals
// --------------------------------------------------------------------------------

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

private nonisolated(unsafe) var blackhole: Any?
