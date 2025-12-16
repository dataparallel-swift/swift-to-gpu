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

#ifndef __PTX_BACKEND__
#define __PTX_BACKEND__

#include <stddef.h>
#include <stdint.h>

void* swift_slowAlloc(size_t size, size_t align_mask);
void* swift_slowAllocTyped(size_t size, size_t align_mask, uint64_t typeId);
void* swift_slowRealloc(void* ptr, size_t size, size_t align_mask);
void swift_slowDealloc(void* ptr, size_t size, size_t align_mask);

#endif // __PTX_BACKEND__
