
#include <stddef.h>
#include <stdint.h>

#include "mimalloc-cbits.h"
#include "swift-to-ptx-cbits.h"

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

