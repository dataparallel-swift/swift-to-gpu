#include "saxpy.h"

template<typename T>
__device__ inline void saxpy(const T alpha, const T* __restrict__ xs, const T* __restrict__ ys, T* __restrict__ zs, const size_t n)
{
  size_t start  = blockIdx.x * blockDim.x + threadIdx.x;
  size_t stride = gridDim.x * blockDim.x;

  for (size_t i = start; i < n; i += stride) {
    zs[i] = alpha * xs[i] + ys[i];
  }
}

__global__ void
saxpy_f16(const float16_t alpha, const float16_t* __restrict__ xs, const float16_t* __restrict__ ys, float16_t* __restrict__ zs, size_t n)
{
  saxpy<float16_t>(alpha, xs, ys, zs, n);
}

__global__ void
saxpy_f32(const float32_t alpha, const float32_t* __restrict__ xs, const float32_t* __restrict__ ys, float32_t* __restrict__ zs, size_t n)
{
  saxpy<float32_t>(alpha, xs, ys, zs, n);
}

__global__ void
saxpy_f64(const float64_t alpha, const float64_t* __restrict__ xs, const float64_t* __restrict__ ys, float64_t* __restrict__ zs, size_t n)
{
  saxpy<float64_t>(alpha, xs, ys, zs, n);
}

