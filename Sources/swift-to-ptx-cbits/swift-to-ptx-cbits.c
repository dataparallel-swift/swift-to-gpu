
#include <stddef.h>
#include <stdint.h>

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

// TODO handle alignment properly, c.f. stdlib/public/runtime/Heap.cpp

void* swift_slowAlloc(size_t size, size_t alignMask) {
  return mi_malloc(size);
}

void* swift_slowAllocTyped(size_t size, size_t alignMask, uint64_t typeId) {
   return mi_malloc(size);
}

void swift_slowDealloc(void* ptr, size_t size, size_t alignMask) {
  mi_free(ptr);
}

size_t swift_usableSize(const void* ptr) {
  return mi_usable_size(ptr);
}

