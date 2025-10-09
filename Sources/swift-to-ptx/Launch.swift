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
    let image: UnsafePointer<UInt8>
    let name: UnsafePointer<CChar>
    var module: CUmodule?
    var function: CUfunction
    var smallBlockSize: Int32
    var largeBlockSize: Int32
}

@inline(never) // we need to access this from the llvm-plugin
@discardableResult
// swiftlint:disable:next function_body_length function_parameter_count
public func launch_parallel_for
(
    iterations: Int,
    context: Context,
    stream: Stream,
    kernel: inout ParallelForKernel,
    env: UnsafeMutableRawPointer,
    swifterror: UnsafeMutableRawPointer,
    thrownerror: UnsafeMutableRawPointer
) -> Event
{
    let __zone = #Zone
    defer { __zone.end() }

    context.push()

    if kernel.module == nil {
        // Technically this configuration is per-context, since we could have
        // different contexts referring to devices of differing compute
        // capability. ---TLM 2025-09-23
        var staticSharedMem: Int32 = 0
        let dynamicSharedMem: Int = 0
        var function: CUfunction? = nil

        cuda_safe_call{cuModuleLoadData(&kernel.module, kernel.image)}
        cuda_safe_call{cuModuleGetFunction(&function, kernel.module, kernel.name)}
        kernel.function = function! // swiftlint:disable:this force_unwrapping

        // active threads per multiprocessor
        var smallBlockActiveThreads: Int32 = 0
        var largeBlockActiveThreads: Int32 = 0

        for blockSize in stride(from: context.warpSize, through: context.maxThreadsPerMultiprocessor, by: Int(context.warpSize)) {
            var activeBlocks: Int32 = 0
            cuda_safe_call{cuOccupancyMaxActiveBlocksPerMultiprocessor(&activeBlocks, function, blockSize, dynamicSharedMem)}

            // No coming back from here
            if activeBlocks == 0 {
                break
            }

            // Record thread block sizes for local maximums in occupancy
            let activeThreads = blockSize * activeBlocks
            if activeThreads > smallBlockActiveThreads {
                kernel.smallBlockSize = blockSize
                smallBlockActiveThreads = activeThreads
            }

            if activeThreads >= largeBlockActiveThreads {
                kernel.largeBlockSize = blockSize
                largeBlockActiveThreads = activeThreads
            }
        }

        let activeThreads = smallBlockActiveThreads
        let activeBlocks = smallBlockActiveThreads / kernel.smallBlockSize
        let activeWarps = activeThreads / context.warpSize
        let occupancy: Float = Float(activeThreads) / Float(context.maxThreadsPerMultiprocessor) * 100.0

        var registersPerThread: Int32 = 0
        var constantMem: Int32 = 0
        var localMem: Int32 = 0
        cuda_safe_call{cuFuncGetAttribute(&registersPerThread, CU_FUNC_ATTRIBUTE_NUM_REGS, kernel.function)}
        cuda_safe_call{cuFuncGetAttribute(&staticSharedMem, CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES, kernel.function)}
        cuda_safe_call{cuFuncGetAttribute(&constantMem, CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES, kernel.function)}
        cuda_safe_call{cuFuncGetAttribute(&localMem, CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES, kernel.function)}

        logger.trace("Kernel function \"\(String(cString: kernel.name))\"")
        logger.trace(" ├ Uses \(registersPerThread) registers, \(Int(staticSharedMem) + dynamicSharedMem) bytes shared memory, \(localMem) bytes local memory, and \(constantMem) bytes constant memory")
        logger.trace(" └ Multiprocessor occupancy \(occupancy) % : \(activeThreads) threads over \(activeWarps) warps in \(activeBlocks) blocks")
    }

    if iterations > 0 {
        // Try to automatically choose a good thread block size. Currently we only
        // support kernels that do not require inter-block thread communication, so
        // we prefer smaller block sizes so that we can fill the available
        // multiprocessors and improve load balancing. However, once the problem
        // size is large enough, switch over to the large block size in order to
        // reduce overheads of launching a large grid. A good point might be when we
        // have more thread blocks per multiprocessor than can be supported by the
        // hardware.
        let blockSize = iterations <= context.maxBlocksPerMultiprocessor * context.multiProcessorCount * kernel.smallBlockSize
                      ? kernel.smallBlockSize
                      : kernel.largeBlockSize
        let gridSize = Int32((iterations + Int(blockSize - 1)) / Int(blockSize))

        logger.trace("launching parallel_for<<<\(gridSize), \(blockSize)>>>(\(iterations), \(env))")

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
            cuda_safe_call{cuLaunchKernel(kernel.function, UInt32(gridSize), 1, 1, UInt32(blockSize), 1, 1, 0, stream.rawStream, buffer.baseAddress, nil)}
        })})})})})
    }

    let event = stream.record()
    context.pop()

    return event
}

