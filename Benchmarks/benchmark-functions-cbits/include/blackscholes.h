
#ifndef __BLACKSCHOLES_H__
#define __BLACKSCHOLES_H__

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

void blackscholes_cuda_f32(const float32_t riskfree, const float32_t volatility, const float32_t* __restrict__ price, const float32_t* __restrict__ strike, const float32_t* __restrict__ years, float32_t* __restrict__ call, float32_t* __restrict__ put, size_t n);

#ifdef __CUDA_ARCH__
__global__ void blackscholes_f32(const float32_t riskfree, const float32_t volatility, const float32_t* __restrict__ price, const float32_t* __restrict__ strike, const float32_t* __restrict__ years, float32_t* __restrict__ call, float32_t* __restrict__ put, size_t n);
#endif

#ifdef __cplusplus
}
#endif

#endif // __BLACKSCHOLES_H__
