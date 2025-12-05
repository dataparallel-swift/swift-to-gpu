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

import Testing

#if false
// TLM you are not meant to call the testing library in this way, there should
// be a way to hook into the stable ABI entry point and call that directly, but
// I was unable to get it to work. c.f. swt_abiv0_getEntryPoint
@main
struct Runner {
    static func main() async {
        await Testing.__swiftPMEntryPoint() as Never
    }
}
#endif
