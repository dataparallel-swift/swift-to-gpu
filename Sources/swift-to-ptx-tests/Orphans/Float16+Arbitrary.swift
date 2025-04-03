import SwiftCheck

extension Float16: @retroactive Arbitrary {
    /// Returns a generator of `Float16` values.
    public static var arbitrary : Gen<Float16> {
        let precision : Int64 = 99999

        return Gen<Float16>.sized { n in
            if n == 0 {
                return Gen<Float16>.pure(0.0)
            }

            let numerator = Gen<Int64>.choose((Int64(-n) * precision, Int64(n) * precision))
            let denominator = Gen<Int64>.choose((1, precision))

            return numerator.flatMap { a in
                return denominator.flatMap { b in
                    Gen<Float16>.pure(Float16(Float64(a) / Float64(b))) }
            }
        }
    }

    /// The default shrinking function for `Float16` values.
    public static func shrink(_ x : Float16) -> [Float16] {
        let tail = Int64(x).shrinkIntegral.map(Float16.init(_:))
        if (x.sign == .minus) {
            return [Swift.abs(x)] + tail
        }
        return tail
    }
}

