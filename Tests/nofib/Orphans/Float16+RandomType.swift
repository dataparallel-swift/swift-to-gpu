// Copyright (c) 2025 PassiveLogic, Inc.

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
