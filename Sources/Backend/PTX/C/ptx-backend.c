// Copyright (c) 2025 The swift-to-gpu authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <errno.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "tracy-cbits.h"
#include "mimalloc-cbits.h"
#include "ptx-backend.h"

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

#ifndef TRACY_CALLSTACK
#define TRACY_CALLSTACK 0
#endif

#ifndef UNUSED
#define UNUSED(x)  (void)(x)
#endif

#ifndef TRACY_ENABLE
#define TRACY_UNLIKELY(x)     (false)
#define TRACY_LIKELY(x)       (false)
#else
#if defined(__GNUC__) || defined(__clang__)
#define TRACY_UNLIKELY(x)     (__builtin_expect(!!(x),false))
#define TRACY_LIKELY(x)       (__builtin_expect(!!(x),true))
#elif (defined(__cplusplus) && (__cplusplus >= 202002L)) || (defined(_MSVC_LANG) && _MSVC_LANG >= 202002L)
#define TRACY_UNLIKELY(x)     (x) [[unlikely]]
#define TRACY_LIKELY(x)       (x) [[likely]]
#else
#define TRACY_UNLIKELY(x)     (x)
#define TRACY_LIKELY(x)       (x)
#endif
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

static const char* swift = "Swift memory usage";

void* swift_slowAlloc(size_t size, size_t align_mask) {
  void* ptr = NULL;

  if (align_mask <= MALLOC_ALIGN_MASK) {
    ptr = mi_malloc(size);
  } else {
    ptr = mi_malloc_aligned(size, compute_alignment(align_mask));
  }

  if (!ptr) crash(ENOMEM, "Could not allocate %zu bytes memory.\n", size);

  if TRACY_LIKELY(TracyCIsStarted) {
    TracyCAllocN(ptr, size, swift);
  }

  return ptr;
}

void* swift_slowAllocTyped(size_t size, size_t align_mask, uint64_t typeId) {
  UNUSED(typeId);
  return swift_slowAlloc(size, align_mask);
}

void* swift_slowRealloc(void* old_ptr, size_t new_size, size_t align_mask) {
  void* new_ptr;

  if TRACY_LIKELY(TracyCIsStarted) {
    TracyCFreeN(old_ptr, swift);
  }

  if (align_mask <= MALLOC_ALIGN_MASK) {
    new_ptr = mi_realloc(old_ptr, new_size);
  } else {
    new_ptr = mi_realloc_aligned(old_ptr, new_size, compute_alignment(align_mask));
  }

  if (!new_ptr) crash(ENOMEM, "Could not reallocate 0x%zx to %zu bytes memory.\n", old_ptr, new_size);

  if TRACY_LIKELY(TracyCIsStarted) {
    TracyCAllocN(new_ptr, new_size, swift);
  }

  return new_ptr;
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

  if TRACY_LIKELY(TracyCIsStarted) {
    TracyCFreeN(ptr, swift);
  }

  mi_free(ptr);
}

size_t swift_usableSize(const void* ptr) {
  return mi_usable_size(ptr);
}
