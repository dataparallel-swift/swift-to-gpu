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

import SwiftCheck

// swiftlint:disable identifier_name public_in_test

#if arch(arm64)
extension Float16: @retroactive RandomType {
    /// Produces a random `Float16` value in the range `[Float16.min, Float16.max]`.
    static func random<G: RandomGeneneratorType>(_ rng: G) -> (Float16, G) {
        let (x, rng_): (Int16, G) = randomBound(rng)
        let twoto24: Int16 = 1 << 11
        let mask24 = twoto24 - 1

        return (Float16(mask24 & x) / Float16(twoto24), rng_)
    }

    /// Returns a random `Float16` value using the given range and generator.
    public static func randomInRange<G: RandomGeneneratorType>(_ range: (Float16, Float16), gen: G) -> (Float16, G) {
        let (l, h) = range
        if l > h {
            return Float16.randomInRange((h, l), gen: gen)
        }
        else {
            let (coef, g_) = Float16.random(gen)
            return (2.0 * (0.5 * l + coef * (0.5 * h - 0.5 * l)), g_)
        }
    }
}
#endif
