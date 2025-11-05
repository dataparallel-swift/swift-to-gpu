
#ifndef __SAXPY_H__
#define __SAXPY_H__

#if PTX

#include <cuda_fp16.h>

#if defined(__CUDA_FP16_TYPES_EXIST__)
typedef __half float16_t; // cuda
#else
typedef __fp16 float16_t; // swift
#endif

typedef float  float32_t;
typedef double float64_t;

#ifdef __cplusplus
extern "C" {
#endif

void saxpy_cuda_f16(const float16_t alpha, const float16_t* __restrict__ xs, const float16_t* __restrict__ ys, float16_t* __restrict__ zs, size_t n);
void saxpy_cuda_f32(const float32_t alpha, const float32_t* __restrict__ xs, const float32_t* __restrict__ ys, float32_t* __restrict__ zs, size_t n);
void saxpy_cuda_f64(const float64_t alpha, const float64_t* __restrict__ xs, const float64_t* __restrict__ ys, float64_t* __restrict__ zs, size_t n);

#ifdef __CUDA_ARCH__
__global__ void saxpy_f16(const float16_t alpha, const float16_t* __restrict__ xs, const float16_t* __restrict__ ys, float16_t* __restrict__ zs, size_t n);
__global__ void saxpy_f32(const float32_t alpha, const float32_t* __restrict__ xs, const float32_t* __restrict__ ys, float32_t* __restrict__ zs, size_t n);
__global__ void saxpy_f64(const float64_t alpha, const float64_t* __restrict__ xs, const float64_t* __restrict__ ys, float64_t* __restrict__ zs, size_t n);
#endif

#ifdef __cplusplus
}
#endif

#endif

#endif // __SAXPY_H__
