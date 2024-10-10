
#ifndef __SWIFT2PTX_CBITS__
#define __SWIFT2PTX_CBITS__

#include <cuda.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

extern int32_t default_device_id;
extern CUdevice default_device;
extern CUcontext default_context;

void* swift_slowAlloc(size_t size, size_t alignMask);
void* swift_slowAllocTyped(size_t size, size_t alignMask, uint64_t typeId);
void swift_slowDealloc(void* ptr, size_t size, size_t alignMask);
size_t swift_usableSize(const void* ptr);

// cuMemAllocHost _seems to_ allocate at 256-byte alignment. This might be
// device specific. The documentation does not comment on the alignment of host
// allocated memory, only that device allocated memory is "suitably aligned for
// any kind of variable". It follows that this also applies to host allocated
// memory, since this is directly accessible by the device.
//
#define CUDA_MALLOC_ALIGN_MASK 256

#if __has_builtin(__builtin_expect)
#define SWIFT_LIKELY(expression) (__builtin_expect(!!(expression), 1))
#define SWIFT_UNLIKELY(expression) (__builtin_expect(!!(expression), 0))
#else
#define SWIFT_LIKELY(expression) ((expression))
#define SWIFT_UNLIKELY(expression) ((expression))
#endif

#ifdef __cplusplus
}
#endif

#endif // __SWIFT2PTX_CBITS__

