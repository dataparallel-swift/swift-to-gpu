import CUDA
import Tracy
import Logging
import SwiftToPTX_cbits

private let logger = Logger(label: "Launch")

// XXX: This module will be loaded into a specific CUDA context, but on
// subsequent invocations this isn't checked. If we try to call the kernel again
// from a different context, the launch will fail. Once we move to CUDA 12 the
// CUfunction can be swapped for a CUkernel, which is context independent
// (automatically loaded into different contexts as necessary, by the driver).
//
// XXX: The CUDA module should only be initialised once. It's (I think) not
// really an error if multiple threads race at this point, since they should all
// produce the same result, but it is definitely a memory leak.
//
public struct ParallelForKernel {
    let image : UnsafePointer<UInt8>
    let name : UnsafePointer<CChar>
    var module : CUmodule?
    var function : CUfunction
    var blockSize : Int32
    var maxGridSize : Int32
}

@inline(never)  // we need to access this from the llvm-plugin
@discardableResult
public func launch_parallel_for
(
    iterations:     Int,
    context:        Context,
    stream:         Stream,
    kernel:         inout ParallelForKernel,
    env:            UnsafeMutableRawPointer,
    swifterror:     UnsafeMutableRawPointer,
    thrownerror:    UnsafeMutableRawPointer
) -> Event
{
    let __zone = #Zone
    defer { __zone.end() }

    context.push()

    if kernel.module == nil {
        var minGridSize : Int32 = 0
        var activeBlocks : Int32 = 0
        let dynamicSharedMem : Int = 0
        var function : CUfunction?

        cuda_safe_call{cuModuleLoadData(&kernel.module, kernel.image)}
        cuda_safe_call{cuModuleGetFunction(&function, kernel.module, kernel.name)}
        cuda_safe_call{cuOccupancyMaxPotentialBlockSize(&minGridSize, &kernel.blockSize, function, nil, dynamicSharedMem, 0)}
        cuda_safe_call{cuOccupancyMaxActiveBlocksPerMultiprocessor(&activeBlocks, function, kernel.blockSize, dynamicSharedMem)}

        kernel.function = function!
        kernel.maxGridSize = context.multiProcessorCount * activeBlocks

        let activeThreads = kernel.blockSize * activeBlocks
        let activeWarps = activeThreads / context.warpSize
        let occupancy : Float = Float(activeThreads) / Float(context.maxThreadsPerMultiprocessor) * 100.0

        var registersPerThread : Int32 = 0
        var staticSharedMem : Int32 = 0
        var constantMem : Int32 = 0
        var localMem : Int32 = 0
        cuda_safe_call{cuFuncGetAttribute(&registersPerThread, CU_FUNC_ATTRIBUTE_NUM_REGS, kernel.function)}
        cuda_safe_call{cuFuncGetAttribute(&staticSharedMem, CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES, kernel.function)}
        cuda_safe_call{cuFuncGetAttribute(&constantMem, CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES, kernel.function)}
        cuda_safe_call{cuFuncGetAttribute(&localMem, CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES, kernel.function)}

        logger.trace(
            """
            Kernel function \"\(kernel.name)\" used \(registersPerThread) registers, \(Int(staticSharedMem) + dynamicSharedMem) bytes shared memory, \(localMem) bytes local memory, \(constantMem) bytes constant memory
            Multiprocessor occupancy \(occupancy) % : \(activeThreads) threads over \(activeWarps) warps in \(activeBlocks) blocks
            """
        )
    }

    let gridSize = min(kernel.maxGridSize, Int32((iterations + Int(kernel.blockSize) - 1) / Int(kernel.blockSize)))

    if gridSize > 0 {
        logger.trace("launching parallel_for<<<\(gridSize), \(kernel.blockSize)>>>(\(iterations), \(env))")

        // To marshal the environment we want the equivalent of this C:
        //
        //   void* params[] = { &iterations, &env, &swifterror, &thrownerror }
        //
        // We use withUnsafeTemporaryAllocation here rather than using the built-in
        // array declaration syntax [...] because we want this to be allocated on
        // the stack (using alloca) rather than allocating a full
        // dynamically-resizable array on the heap. This is perhaps one of those cases where
        // the Swift/C++ interop is a bit sharp, but the extra effort is worth it.
        //
        var _iterations = iterations
        var _env = env
        var _swifterror = swifterror
        var _thrownerror = thrownerror
        withUnsafeTemporaryAllocation(of: UnsafeMutableRawPointer?.self, capacity: 4, { buffer in
        withUnsafeMutablePointer(to: &_iterations, { p_iterations in
        withUnsafeMutablePointer(to: &_env, { p_env in
        withUnsafeMutablePointer(to: &_swifterror, { p_swifterror in
        withUnsafeMutablePointer(to: &_thrownerror, { p_thrownerror in
            buffer[0] = UnsafeMutableRawPointer(p_iterations)
            buffer[1] = UnsafeMutableRawPointer(p_env)
            buffer[2] = UnsafeMutableRawPointer(p_swifterror)
            buffer[3] = UnsafeMutableRawPointer(p_thrownerror)
            cuda_safe_call{cuLaunchKernel(kernel.function, UInt32(gridSize), 1, 1, UInt32(kernel.blockSize), 1, 1, 0, stream.rawStream, buffer.baseAddress, nil)}
        })})})})})
    }

    let event = stream.record()
    context.pop()

    return event
}

