// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck

// swiftlint:disable public_in_test

extension Optional: @retroactive Testable where Wrapped == () {
    public var property: Property {
        if self != nil {
            TestResult.succeeded.property
        }
        else {
            TestResult.failed("Falsifiable").property
        }
    }
}
