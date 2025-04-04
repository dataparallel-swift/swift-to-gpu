# Swift-to-PTX

Lift Swift code to parallel CUDA kernels.

## Adding it to your project

Add to your `Package.swift`:

```swift
    dependencies: [
        .package(url: "git@gitlab.com/PassiveLogic/Experiments/swift-to-ptx")
    ]
```

## Adding it to your code

In a module containing a loop(s) that you wish to hoist to the GPU:

```swift
import SwiftToPTX
```

and replace `for` loops with the provided `parallel_for` construct. Example:

```swift
func nondeterministicIndex(of target: Float, in array: [Float]) -> Int?
{
    var index : Int? = nil
    parallel_for(iterations: array.count) { i in
        if array[i] == target {
            index = i
        }
    }.sync()
    return index
}
```

The `parallel_for` function takes a closure that is given an index in the range
`0..<iterations`, with which the loop body can do something to compute a result
(closing over captured variables). In principle all of the loop iterations are
executed concurrently in data-parallel, and thus must all be independent of one
another. The above example then is non-deterministic because if the target value
exists in multiple positions in the array, the function may return a different
index each time it is called.

Note that any data to be filled-in must be pre-allocated at the (maximum) size
required _before_ entering the parallel section: avoid using inherently
sequential operations such as Array.append(). (You should (almost) never be
using that anyway: figure out what the requirements of your program are
instead!)

You will need to compile your project with a swift toolchain that includes the
swift-to-ptx compiler transformation, e.g. available from here:

https://gitlab.com/PassiveLogic/experiments/swift

Note that the transformation is only enabled when compiling with optimisations
(release mode).

## Limitations

  * All code to be lifted to the device must be present in a single module

## TODO

  * ...

