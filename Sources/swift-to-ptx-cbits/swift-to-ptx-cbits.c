
#include <errno.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "mimalloc-cbits.h"
#include "swift-to-ptx-cbits.h"

// NOTE: [mimalloc/cuda memory allocator]
//
// The current implementation is a bit unsatisfactory in that we have both a
// custom version of mimalloc AND a custom swift compiler, so that we can
// replace the allocation method in both. Realistically we only need one of
// those.
//
// 1. A custom implementation of mimallc that does allocation using the CUDA
//    runtime, and we completely interpose malloc/free in all clients. I think
//    this is the ideal situation.
//
//    PROS:
//     * We do not need a custom swift runtime with interposable allocation symbols
//     * mimalloc handles all page allocation logic
//
//    CONS:
//     * Difficult to implement. Namely we need to initialise the CUDA runtime
//       using a heap from system memory, and then transition to heaps allocated
//       by the CUDA runtime. Getting this working correctly proved challenging!
//
// 2. Use a separate heap for the swift runtime, do not interpose malloc/free
//    for other applications.
//
//    PROS:
//      * We do not need a custom implementation of mimalloc with CUDA
//        allocation backend
//
//    CONS:
//      * We will need a custom swift compiler moving forward to continue
//        interposing swift runtime allocation symbols
//      * We are in charge of allocating memory pages for mimalloc to manage.
//        In particular we need to determine what size pages we should allocate
//        and pass to it. Some research/investigation as to what the optimal
//        sizes for this may be required (i.e. look at the source and see what
//        it does). If we are not trying to be too fancy here even a dumb
//        strategy that over-allocates (+ minor guardrails) is probably fine,
//        but we have to be a little careful because CUDA host memory
//        allocations are pinned and immediately committed, meaning less memory
//        becomes available for the rest of the system to use and overall
//        performance can degrade. It is also not exactly clear if an existing
//        heap can be added to (with a new OS allocation) once it becomes full,
//        or if we need to destroy the existing heap and migrate in-use blocks
//        to the new one somehow.
//      * Pages are only freed once the program exits (c.f. overall system
//        performance)
//
// We should continue to work towards one of these two.

// Minimum alignment for memory returned by mi_malloc. On most platforms 16
// bytes are needed due to SSE registers for example. This must be at least
// `sizeof(void*)`. This is also the alignment required by the swift runtime.
#ifndef MI_MALLOC_ALIGN_SIZE
#define MI_MALLOC_ALIGN_SIZE  16    // sizeof(max_align_t)
#endif

#ifndef MALLOC_ALIGN_MASK
#define MALLOC_ALIGN_MASK  15
#endif

#ifndef UNUSED
#define UNUSED(x)  (void)(x)
#endif

static size_t compute_alignment(size_t align_mask) {
  return (align_mask == ~((size_t)0)) ? MI_MALLOC_ALIGN_SIZE : align_mask + 1;
}

static void crash(int err, const char* fmt, ...) {
  va_list args;
  va_start(args, fmt);
  vfprintf(stderr, fmt, args);
  va_end(args);
  exit(err);
}

void* swift_slowAlloc(size_t size, size_t align_mask) {
  void* p = NULL;

  if (align_mask <= MALLOC_ALIGN_MASK) {
    p = mi_malloc(size);
  } else {
    p = mi_malloc_aligned(size, compute_alignment(align_mask));
  }

  if (!p) crash(ENOMEM, "Could not allocate %zu bytes memory.\n", size);
  return p;
}

void* swift_slowAllocTyped(size_t size, size_t align_mask, uint64_t typeId) {
  UNUSED(typeId);
  return swift_slowAlloc(size, align_mask);
}

void* swift_slowRealloc(void* ptr, size_t size, size_t align_mask) {
  void* p;

  if (align_mask <= MALLOC_ALIGN_MASK) {
    p = mi_realloc(ptr, size);
  } else {
    p = mi_realloc_aligned(ptr, size, compute_alignment(align_mask));
  }

  if (!p) crash(ENOMEM, "Could not reallocate 0x%zx to %zu bytes memory.\n", ptr, size);
  return p;
}

/* mi_malloc makes no distinction between mi_free() and mi_free_aligned(), other
 * than that the latter has an assert in debug mode to check the pointer is
 * aligned as expected. Unfortunately, it turns out the swift runtime is not
 * consistently de/allocating with the same alignment mask, so we do hit that
 * assert. Perhaps we should track down that bug within the swift compiler
 * itself and fix it...
 */
void swift_slowDealloc(void* ptr, size_t size, size_t align_mask) {
  UNUSED(size);
  UNUSED(align_mask);
  mi_free(ptr);
}

size_t swift_usableSize(const void* ptr) {
  return mi_usable_size(ptr);
}

