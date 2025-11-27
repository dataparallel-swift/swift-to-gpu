// Copyright (c) 2025 PassiveLogic, Inc.

#ifndef __PTX_BACKEND__
#define __PTX_BACKEND__

#include <stddef.h>
#include <stdint.h>

void* swift_slowAlloc(size_t size, size_t align_mask);
void* swift_slowAllocTyped(size_t size, size_t align_mask, uint64_t typeId);
void* swift_slowRealloc(void* ptr, size_t size, size_t align_mask);
void swift_slowDealloc(void* ptr, size_t size, size_t align_mask);

#endif // __PTX_BACKEND__
