// Copyright (c) 2026 The swift-to-gpu authors. All rights reserved.
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

@inline(never)
func copy<T>(_ xs: [T]) -> [T] {
    // NOTE: [Array literals on the GPU]
    // There is an optimization pass/a combination of passes that lifts array literals
    // into one of the constant data section. On Linux, they end up in the .data section, which
    // is inaccessible to the GPU runtime. We rely on the compiler being unable to const-fold
    // `map` to work around this and create a new heap-allocated array from a static array.
    xs.map(\.self)
}
