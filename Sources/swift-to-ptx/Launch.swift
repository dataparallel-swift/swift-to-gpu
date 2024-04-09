import CUDA
import Logging

private let logger = Logger(label: "CUDA Launch")

// XXX: This module will be loaded into a specific CUDA context, but on
// subsequent invocations this isn't checked. If we try to call the kernel again
// in a different context, we'll crash with a (weird?) error message.
public struct ParallelForKernel {
    let image : UnsafePointer<UInt8>
    var function : CUfunction?
    var module : CUmodule?
    var blockSize : Int32
    var maxGridSize : Int32
}

@inline(never)  // we need to access this from the llvm-plugin
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

        cuda_safe_call{cuModuleLoadData(&kernel.module, kernel.image)}
        cuda_safe_call{cuModuleGetFunction(&kernel.function, kernel.module, "parallel_for")}
        cuda_safe_call{cuOccupancyMaxPotentialBlockSize(&minGridSize, &kernel.blockSize, kernel.function, nil, dynamicSharedMem, 0)}
        cuda_safe_call{cuOccupancyMaxActiveBlocksPerMultiprocessor(&activeBlocks, kernel.function, kernel.blockSize, dynamicSharedMem)}

        kernel.maxGridSize = context.multiProcessorCount * activeBlocks
    }

    let gridSize = min(kernel.maxGridSize, Int32((iterations + Int(kernel.blockSize) - 1) / Int(kernel.blockSize)))
    logger.info("launching parellel_for<<<\(gridSize), \(kernel.blockSize)>>>(\(iterations), \(env))")

    // Marshalling the environment is a PITA. We want the equivalent of this C:
    // void* params = { &iterations, &env }
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

