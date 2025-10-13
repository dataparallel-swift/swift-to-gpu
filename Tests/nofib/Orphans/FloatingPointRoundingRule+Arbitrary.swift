import SwiftCheck

// swiftlint:disable public_in_test

extension FloatingPointRoundingRule: @retroactive Arbitrary {
    public static var arbitrary: Gen<FloatingPointRoundingRule> {
        return Gen<FloatingPointRoundingRule>.fromElements(of: [
            .awayFromZero,
            .down,
            .toNearestOrAwayFromZero,
            .toNearestOrEven,
            .towardZero,
            .up
        ])
    }
}
