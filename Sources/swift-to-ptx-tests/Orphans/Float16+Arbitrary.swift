import SwiftCheck

extension Float16: @retroactive Arbitrary {
    /// Returns a generator of `Float16` values.
    public static var arbitrary : Gen<Float16> {
        let precision : Int16 = 9999

            return Gen<Float16>.sized { n in
                if n == 0 {
                    return Gen<Float16>.pure(0.0)
                }

                let numerator = Gen<Int16>.choose((Int16(-n) * precision, Int16(n) * precision))
                    let denominator = Gen<Int16>.choose((1, precision))

                    return numerator.flatMap { a in
                        return denominator.flatMap { b in Gen<Float16>.pure(Float16(a) / Float16(b)) }
                    }
            }
    }

    /// The default shrinking function for `Float16` values.
    public static func shrink(_ x : Float16) -> [Float16] {
        let tail = Int16(x).shrinkIntegral.map(Float16.init(_:))
            if (x.sign == .minus) {
                return [Swift.abs(x)] + tail
            }
        return tail
    }
}

