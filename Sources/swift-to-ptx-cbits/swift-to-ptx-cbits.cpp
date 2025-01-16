#include <assert.h>
#include <malloc.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#include "swift-to-ptx-cbits.h"

#define USE_CUDA 1
#define USE_COLOUR 1
#define SWIFT2PTX_DEBUG 0

#if USE_COLOUR
#define BLACK "\x1b[30m"
#define RED "\x1b[31m"
#define GREEN "\x1b[32m"
#define YELLOW "\x1b[33m"
#define BLUE "\x1b[34m"
#define MAGENTA "\x1b[35m"
#define CYAN "\x1b[36m"
#define WHITE "\x1b[37m"
#define RESET "\x1b[0m"
#else
#define BLACK
#define RED
#define GREEN
#define YELLOW
#define BLUE
#define MAGENTA
#define CYAN
#define WHITE
#define RESET
#endif

#if SWIFT2PTX_DEBUG
#define TRACE(...) fprintf(stderr, __VA_ARGS__)
#else
#define TRACE(...)
#endif


// Note: [SwiftToPTX context]
//
// Since we must initialise the device and create a context in order to
// [de]allocate memory with our interposition---which will certainly be called
// before we reach context initialisation in the SwiftToPTX package---we just
// use the default context and re-export this for reuse this from the swift
// package as well.
//
// In future we might want to at least make this configurable via an environment
// variable or similar.
//
int32_t   default_device_id = 0;
CUdevice  default_device    = 0;
CUcontext default_context   = 0;


#define CUDA_SAFE_CALL(it)                                                                                               \
  do {                                                                                                                   \
    CUresult status = it;                                                                                                \
    if (SWIFT_UNLIKELY(CUDA_SUCCESS != status)) {                                                                        \
      const char* name;                                                                                                  \
      const char* description;                                                                                           \
      cuGetErrorName(status, &name);                                                                                     \
      cuGetErrorString(status, &description);                                                                            \
      fprintf(stderr, "%s:%d CUDA call failed with error %s (%d): %s\n", __FILE__, __LINE__, name, status, description); \
      abort();                                                                                                           \
    }                                                                                                                    \
  } while (0);


static pthread_once_t cuda_is_initialised = PTHREAD_ONCE_INIT;
static bool initialised = false;

static void initialise_cuda()
{
  CUDA_SAFE_CALL(cuInit(0));
  CUDA_SAFE_CALL(cuDeviceGet(&default_device, default_device_id));
  CUDA_SAFE_CALL(cuDevicePrimaryCtxRetain(&default_context, default_device));
  CUDA_SAFE_CALL(cuCtxPushCurrent(default_context));
  initialised = true;
}

// Replacement for libswiftCore swift_slowAlloc
void *swift_slowAlloc(size_t size, size_t alignMask)
{
  void *p;
  size_t s;

  // Make sure CUDA is initialised. This is safe for multithreaded environments.
  pthread_once(&cuda_is_initialised, initialise_cuda);

#if USE_CUDA
  // Allocate all memory as CUDA pinned host memory. This memory is directly
  // accessible from the Tegra iGPU from the same pointer address.
  //
  // Note that this memory is _not_ cached on the iGPU. If memory is repeatedly
  // accessed from the iGPU then using unified memory could be a better
  // alternative, although there is some overhead on every kernel launch in
  // order to ensure memory coherency. For buffers that are only used from
  // kernel code (e.g. intermediate buffers) we would prefer to allocate these
  // as device memory; these are not directly accessible from the host but are
  // cached on the iGPU and do not have the per-launch overhead of
  // software-managed coherency.
  //
  // https://docs.nvidia.com/cuda/cuda-for-tegra-appnote/index.html#memory-management
  /* assert(alignMask <= MALLOC_ALIGN_MASK && "TODO: aligned (de)allocation"); */
  CUDA_SAFE_CALL(cuCtxPushCurrent(default_context));
  CUDA_SAFE_CALL(cuMemAllocHost(&p, size));
  CUDA_SAFE_CALL(cuMemGetAddressRange(NULL, &s, (CUdeviceptr) p));
  CUDA_SAFE_CALL(cuCtxPopCurrent(NULL));
#else
  p = malloc(size);
  s = malloc_usable_size(p);
#endif

  TRACE(BLUE  "swift_slowAlloc (%4ld):    %p-%p (%ld bytes)\n" RESET, size, p, (uint8_t*)p+s, s);

  if (nullptr == p) {
    fprintf(stderr, "Could not allocate memory.");
    exit(EXIT_FAILURE);
  }

  return p;
}

void *swift_slowAllocTyped(size_t size, size_t alignMask, uint64_t typeId)
{
  return swift_slowAlloc(size, alignMask);
}

void swift_slowDealloc(void* ptr, size_t size, size_t alignMask)
{
  if (!ptr)
    return;

  TRACE(BLUE "swift_slowDealloc:         %p\n" RESET, ptr);

#if USE_CUDA
  CUDA_SAFE_CALL(cuCtxPushCurrent(default_context));
  CUDA_SAFE_CALL(cuMemFreeHost(ptr));
  CUDA_SAFE_CALL(cuCtxPopCurrent(NULL));
#else
  free(ptr);
#endif
}


size_t swift_usableSize(const void* ptr)
{
  size_t s;

#if USE_CUDA
  CUDA_SAFE_CALL(cuCtxPushCurrent(default_context));
  CUDA_SAFE_CALL(cuMemGetAddressRange(NULL, &s, (CUdeviceptr) ptr));
  CUDA_SAFE_CALL(cuCtxPopCurrent(NULL));
#else
  s = malloc_usable_size(const_cast<void*>(ptr));
#endif

  TRACE(BLUE "swift_usableSize()         %p = %ld\n" RESET, ptr, s);
  return s;
}

