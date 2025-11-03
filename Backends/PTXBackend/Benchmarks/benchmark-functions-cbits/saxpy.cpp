#include <cuda.h>
#include <stdlib.h>
#include <stdio.h>

#include "cutil.h"
#include "saxpy.h"
// nvcc -O3 -cubin -Iinclude -arch sm_87 saxpy.cu
// bin2c --static --const --name saxpy_image_data saxpy.cubin > include/saxpy_image.h
#include "saxpy_image.h"

#include "swift-to-ptx-cbits.h"

static CUmodule saxpy_module = nullptr;
static CUfunction saxpy_f16 = nullptr;
static CUfunction saxpy_f32 = nullptr;
static CUfunction saxpy_f64 = nullptr;

static CUdevice default_device = 0;
static CUcontext default_context = nullptr;

template <typename T>
void saxpy_cuda(CUfunction& saxpy_function, const char* name, const T alpha, const T* __restrict__ xs, const T* __restrict__ ys, T* __restrict__ zs, size_t n)
{
  if (!default_context) {
    CUDA_SAFE_CALL(cuDeviceGet(&default_device, 0));
    CUDA_SAFE_CALL(cuDevicePrimaryCtxRetain(&default_context, default_device));
  }
  CUDA_SAFE_CALL(cuCtxPushCurrent(default_context));
  if (!saxpy_module) {
    CUDA_SAFE_CALL(cuModuleLoadData(&saxpy_module, saxpy_image_data));
  }

  if (!saxpy_function) {
    CUDA_SAFE_CALL(cuModuleGetFunction(&saxpy_function, saxpy_module, name));

#if 0
    int32_t maxThreadsPerBlock = 0;
    int32_t registersPerThread = 0;
    int32_t staticSharedMem = 0;
    int32_t dynamicSharedMem = 0;
    int32_t constantMem = 0;
    int32_t localMem = 0;

    CUDA_SAFE_CALL(cuFuncGetAttribute(&maxThreadsPerBlock, CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK, saxpy_function));
    CUDA_SAFE_CALL(cuFuncGetAttribute(&registersPerThread, CU_FUNC_ATTRIBUTE_NUM_REGS, saxpy_function));
    CUDA_SAFE_CALL(cuFuncGetAttribute(&staticSharedMem, CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES, saxpy_function));
    CUDA_SAFE_CALL(cuFuncGetAttribute(&constantMem, CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES, saxpy_function));
    CUDA_SAFE_CALL(cuFuncGetAttribute(&localMem, CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES, saxpy_function));

    printf("Kernel function \"%s\" used %d registers, %d bytes shared memory, %d bytes local memory, %d bytes constant memory\n",
        name,
        registersPerThread,
        staticSharedMem+dynamicSharedMem,
        localMem,
        constantMem);
#endif
  }

  size_t blockDimX = 128;
  size_t gridDimX = (n + blockDimX - 1) / blockDimX;
  size_t sharedMemBytes = 0;
  void* kernelParams[] = {
    const_cast<T*>(&alpha),
    const_cast<T**>(&xs),
    const_cast<T**>(&ys),
    const_cast<T**>(&zs),
    &n };

  CUDA_SAFE_CALL(cuLaunchKernel(saxpy_function, gridDimX, 1, 1, blockDimX, 1, 1, sharedMemBytes, CU_STREAM_PER_THREAD, kernelParams, nullptr));
  CUDA_SAFE_CALL(cuStreamSynchronize(CU_STREAM_PER_THREAD));
  CUDA_SAFE_CALL(cuCtxPopCurrent(NULL));
}


void saxpy_cuda_f16(const float16_t alpha, const float16_t* __restrict__ xs, const float16_t* __restrict__ ys, float16_t* __restrict__ zs, size_t n)
{
  saxpy_cuda(saxpy_f16, "saxpy_f16", alpha, xs, ys, zs, n);
}

void saxpy_cuda_f32(const float32_t alpha, const float32_t* __restrict__ xs, const float32_t* __restrict__ ys, float32_t* __restrict__ zs, size_t n)
{
  saxpy_cuda(saxpy_f32, "saxpy_f32", alpha, xs, ys, zs, n);
}

void saxpy_cuda_f64(const float64_t alpha, const float64_t* __restrict__ xs, const float64_t* __restrict__ ys, float64_t* __restrict__ zs, size_t n)
{
  saxpy_cuda(saxpy_f64, "saxpy_f64", alpha, xs, ys, zs, n);
}

