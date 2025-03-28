import SwiftCheck

extension Optional: @retroactive Testable where Wrapped == () {
    public var property: Property {
        if let () = self {
            TestResult.succeeded.property
        } else {
            TestResult.failed("Falsifiable").property
        }
    }
}

