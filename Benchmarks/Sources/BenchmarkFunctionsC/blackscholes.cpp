#include <cuda.h>
#include <stdio.h>

#include "cutil.h"
#include "blackscholes.h"
// nvcc -O3 -cubin -Iinclude -arch sm_87 blackscholes.cu
// bin2c --static --const --name blackscholes_image_data blackscholes.cubin > include/blackscholes_image.h
#include "blackscholes_image.h"

static CUmodule blackscholes_module = nullptr;
static CUfunction blackscholes_f32 = nullptr;

static CUdevice default_device = 0;
static CUcontext default_context = nullptr;

template <typename T>
void blackscholes_cuda
(
    CUfunction& blackscholes_function,
    const char* name,
    const T riskfree,
    const T volatility,
    const T* __restrict__ price,
    const T* __restrict__ strike,
    const T* __restrict__ years,
    T* __restrict__ call,
    T* __restrict__ put,
    size_t n
)
{
  if (!default_context) {
    CUDA_SAFE_CALL(cuDeviceGet(&default_device, 0));
    CUDA_SAFE_CALL(cuDevicePrimaryCtxRetain(&default_context, default_device));
  }
  CUDA_SAFE_CALL(cuCtxPushCurrent(default_context));
  if (!blackscholes_module) {
    CUDA_SAFE_CALL(cuModuleLoadData(&blackscholes_module, blackscholes_image_data));
  }

  if (!blackscholes_function) {
    CUDA_SAFE_CALL(cuModuleGetFunction(&blackscholes_function, blackscholes_module, name));
  }

  size_t blockDimX = 128;
  size_t gridDimX = (n + blockDimX - 1) / blockDimX;
  size_t sharedMemBytes = 0;
  void* kernelParams[] = {
    const_cast<T*>(&riskfree),
    const_cast<T*>(&volatility),
    const_cast<T**>(&price),
    const_cast<T**>(&strike),
    const_cast<T**>(&years),
    const_cast<T**>(&call),
    const_cast<T**>(&put),
    &n
  };

  CUDA_SAFE_CALL(cuLaunchKernel(blackscholes_function, gridDimX, 1, 1, blockDimX, 1, 1, sharedMemBytes, CU_STREAM_PER_THREAD, kernelParams, nullptr));
  CUDA_SAFE_CALL(cuStreamSynchronize(CU_STREAM_PER_THREAD));
  CUDA_SAFE_CALL(cuCtxPopCurrent(NULL));
}

void blackscholes_cuda_f32(const float32_t riskfree, const float32_t volatility, const float32_t* __restrict__ price, const float32_t* __restrict__ strike, const float32_t* __restrict__ years, float32_t* __restrict__ call, float32_t* __restrict__ put, size_t n)
{
  blackscholes_cuda(blackscholes_f32, "blackscholes_f32", riskfree, volatility, price, strike, years, call, put, n);
}

