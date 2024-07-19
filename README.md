# Swift-to-PTX

Lift Swift code to parallel CUDA kernels.

## Adding it to your project

Add to your `Package.swift`:

```swift
    dependencies: [
        .package(url: "git@gitlab.com/PassiveLogic/swift-to-ptx")
    ]
```

## Adding it to your code

In a module containing a loop(s) that you wish to hoist to the GPU:

```swift
import SwiftToPTX
```

and replace `for` loops with the provided `parallel_for` construct. Example:

```swift
func fill(count: Int) -> Array<Float>
{
    Array<Float>.init(
        unsafeUninitializedCapacity: count,
        initializingWith: { buffer, initializedCount in
            let event = parallel_for(iterations: count) { i in
                buffer[i] = 42
            }
            initializedCount = count
            event.sync()    // wait for the GPU to finish; do this right before
                            // the result is required
        })
}
```

The `parallel_for` function takes a closure that is given an index in the range
`0..<iterations`, with which the loop body can do something to compute a result
(closing over captured variables). In principle all of the loop iterations are
executed concurrently in data-parallel, and thus must all be independent of one
another. In particular, note in the example that we pre-allocate the array at
the size we require _before_ entering the parallel section: avoid using
inherently sequential operations such as Array.append().

You should (almost) never be using that anyway: figure out what the requirements
of your program are instead.

You will need to compile your project with a swift toolchain that includes the
swift-to-ptx compiler transformation, e.g. available from here:

...

## TODO

