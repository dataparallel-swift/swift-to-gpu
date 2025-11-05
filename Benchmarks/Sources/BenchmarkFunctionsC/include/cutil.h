
#ifndef __CUTIL_H__
#define __CUTIL_H__

#if PTX

#include <cuda.h>

#define CUDA_SAFE_CALL(call)                                                   \
  do {                                                                         \
    CUresult status = call;                                                    \
    if (CUDA_SUCCESS != status) {                                              \
      const char* name;                                                        \
      const char* desc;                                                        \
      cuGetErrorName(status, &name);                                           \
      cuGetErrorString(status, &desc);                                         \
      fprintf(stderr, "%s (%d): CUDA call failed with error %s (%d): %s",      \
          __FILE__, __LINE__, name, status, desc);                             \
      exit(1);                                                                 \
    }                                                                          \
  } while (0)

#endif

#endif // __CUTIL_H__

