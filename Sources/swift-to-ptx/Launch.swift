import CUDA
import Logging

private let logger = Logger(label: "CUDA Launch")

// XXX: This module will be loaded into a specific CUDA context, but on
// subsequent invocations this isn't checked. If we try to call the kernel again
// from a different context, the launch will fail. Once we move to CUDA 12 the
// CUfunction can be swapped for a CUkernel, which is context independent
// (automatically loaded into different contexts as necessary, by the driver).
//
public struct ParallelForKernel {
    let image : UnsafePointer<UInt8>
    var module : CUmodule?
    var function : CUfunction
    var blockSize : Int32
    var maxGridSize : Int32
}

@inline(never)  // we need to access this from the llvm-plugin
@discardableResult
public func launch_parallel_for
(
    iterations: Int,
    kernel:     inout ParallelForKernel,
    env:        UnsafeMutableRawPointer,
    context:    Context,
    stream:     Stream
) -> Event
{
    if kernel.module == nil {
        var minGridSize : Int32 = 0
        var activeBlocks : Int32 = 0
        let dynamicSharedMem : Int = 0
        var function : CUfunction?

        cuda_safe_call{cuModuleLoadData(&kernel.module, kernel.image)}
        cuda_safe_call{cuModuleGetFunction(&function, kernel.module, "parallel_for")}
        cuda_safe_call{cuOccupancyMaxPotentialBlockSize(&minGridSize, &kernel.blockSize, function, nil, dynamicSharedMem, 0)}
        cuda_safe_call{cuOccupancyMaxActiveBlocksPerMultiprocessor(&activeBlocks, function, kernel.blockSize, dynamicSharedMem)}

        kernel.function = function!
        kernel.maxGridSize = context.multiProcessorCount * activeBlocks
    }

    let gridSize = min(kernel.maxGridSize, Int32((iterations + Int(kernel.blockSize) - 1) / Int(kernel.blockSize)))
    logger.info("launching parellel_for<<<\(gridSize), \(kernel.blockSize)>>>(\(iterations), \(env))")

    // To marshal the environment we want the equivalent of this C:
    //
    //   void* params[] = { &iterations, &env }
    //
    // We use withUnsafeTemporaryAllocation here rather than using the built-in
    // array declaration syntax [...] because we want this to be allocated on
    // the stack (using alloca) rather than allocating a full
    // dynamically-resizable array on the heap. This is perhaps one of those cases where
    // the Swift/C++ interop is a bit sharp, but the extra effort is worth it.
    //
    var _iterations = iterations
    var _env = env
    withUnsafeTemporaryAllocation(of: UnsafeMutableRawPointer?.self, capacity: 2, { buffer in
    withUnsafeMutablePointer(to: &_iterations, { p_iterations in
    withUnsafeMutablePointer(to: &_env, { p_env in
        buffer[0] = UnsafeMutableRawPointer(p_iterations)
        buffer[1] = UnsafeMutableRawPointer(p_env)
        cuda_safe_call{cuLaunchKernel(kernel.function, UInt32(gridSize), 1, 1, UInt32(kernel.blockSize), 1, 1, 0, stream.rawStream, buffer.baseAddress, nil)}
    })})})

    return stream.record()
}

