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

// swiftlint:disable public_in_test

#if arch(arm64)
extension Float16: @retroactive Arbitrary {
    /// Returns a generator of `Float16` values.
    public static var arbitrary: Gen<Float16> {
        let precision: Int64 = 99999

        return Gen<Float16>.sized { n in
            if n == 0 {
                return Gen<Float16>.pure(0.0)
            }

            let numerator = Gen<Int64>.choose((Int64(-n) * precision, Int64(n) * precision))
            let denominator = Gen<Int64>.choose((1, precision))

            return numerator.flatMap { x in
                denominator.flatMap { y in
                    Gen<Float16>.pure(Float16(Float64(x) / Float64(y)))
                }
            }
        }
    }

    /// The default shrinking function for `Float16` values.
    public static func shrink(_ x: Float16) -> [Float16] {
        let tail = Int64(x).shrinkIntegral.map(Float16.init(_:))
        if x.sign == .minus {
            return [Swift.abs(x)] + tail
        }
        return tail
    }
}
#endif
