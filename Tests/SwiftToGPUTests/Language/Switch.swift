// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Switch") struct SwitchTests {
    @Suite("Int") struct IntTests {
        @Test func switch1() { switch1Test(Int.self) }
        @Test func switch2() { switch2Test(Int.self) }
        @Test func switch3() { switch3Test(Int.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(Int.self) }
        @Test func switch5() { switch5Test(Int.self) }
        @Test func switch6() { switch6Test(Int.self) }
    }

    @Suite("Int8") struct Int8Tests {
        @Test func switch1() { switch1Test(Int8.self) }
        @Test func switch2() { switch2Test(Int8.self) }
        @Test func switch3() { switch3Test(Int8.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(Int8.self) }
        @Test func switch5() { switch5Test(Int8.self) }
        @Test func switch6() { switch6Test(Int8.self) }
    }

    @Suite("Int16") struct Int16Tests {
        @Test func switch1() { switch1Test(Int16.self) }
        @Test func switch2() { switch2Test(Int16.self) }
        @Test func switch3() { switch3Test(Int16.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(Int16.self) }
        @Test func switch5() { switch5Test(Int16.self) }
        @Test func switch6() { switch6Test(Int16.self) }
    }

    @Suite("Int32") struct Int32Tests {
        @Test func switch1() { switch1Test(Int32.self) }
        @Test func switch2() { switch2Test(Int32.self) }
        @Test func switch3() { switch3Test(Int32.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(Int32.self) }
        @Test func switch5() { switch5Test(Int32.self) }
        @Test func switch6() { switch6Test(Int32.self) }
    }

    @Suite("Int64") struct Int64Tests {
        @Test func switch1() { switch1Test(Int64.self) }
        @Test func switch2() { switch2Test(Int64.self) }
        @Test func switch3() { switch3Test(Int64.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(Int64.self) }
        @Test func switch5() { switch5Test(Int64.self) }
        @Test func switch6() { switch6Test(Int64.self) }
    }

    @Suite("UInt") struct UIntTests {
        @Test func switch1() { switch1Test(UInt.self) }
        @Test func switch2() { switch2Test(UInt.self) }
        @Test func switch3() { switch3Test(UInt.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(UInt.self) }
        @Test func switch5() { switch5Test(UInt.self) }
        @Test func switch6() { switch6Test(UInt.self) }
    }

    @Suite("UInt8") struct UInt8Tests {
        @Test func switch1() { switch1Test(UInt8.self) }
        @Test func switch2() { switch2Test(UInt8.self) }
        @Test func switch3() { switch3Test(UInt8.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(UInt8.self) }
        @Test func switch5() { switch5Test(UInt8.self) }
        @Test func switch6() { switch6Test(UInt8.self) }
    }

    @Suite("UInt16") struct UInt16Tests {
        @Test func switch1() { switch1Test(UInt16.self) }
        @Test func switch2() { switch2Test(UInt16.self) }
        @Test func switch3() { switch3Test(UInt16.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(UInt16.self) }
        @Test func switch5() { switch5Test(UInt16.self) }
        @Test func switch6() { switch6Test(UInt16.self) }
    }

    @Suite("UInt32") struct UInt32Tests {
        @Test func switch1() { switch1Test(UInt32.self) }
        @Test func switch2() { switch2Test(UInt32.self) }
        @Test func switch3() { switch3Test(UInt32.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(UInt32.self) }
        @Test func switch5() { switch5Test(UInt32.self) }
        @Test func switch6() { switch6Test(UInt32.self) }
    }

    @Suite("UInt64") struct UInt64Tests {
        @Test func switch1() { switch1Test(UInt64.self) }
        @Test func switch2() { switch2Test(UInt64.self) }
        @Test func switch3() { switch3Test(UInt64.self) }
        // @Test(.bug(id: "86b6xaz1f")) func switch4() { switch4Test(UInt64.self) }
        @Test func switch5() { switch5Test(UInt64.self) }
        @Test func switch6() { switch6Test(UInt64.self) }
    }
}

private func switch1Test<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func switch1(_ x: T) -> T {
        switch x {
            case 0: 42
            default: x
        }
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in switch1(x) }
        let actual = map(xs, switch1)
        return try? #require(actual == expected)
      }
}

private func switch2Test<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func switch2(_ x: T) -> T {
        switch x {
            case 0: 0
            case 1: 2
            default: x
        }
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in switch2(x) }
        let actual = map(xs, switch2)
        return try? #require(actual == expected)
      }
}

private func switch3Test<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func switch3(_ x: T) -> T {
        // introduce non-contiguity in the cases
        switch x {
            case 0: 1
            case 1: 3
            case 4: 7
            default: x
        }
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map { x in switch3(x) }
        let actual = map(xs, switch3)
        return try? #require(actual == expected)
      }
}

private func switch4Test<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func switch4(_ x: T) -> T {
        switch x {
            case 0: 1
            case 1: 3
            case 4: 7
            case 7: 255
            default: x
        }
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(switch4)
        let actual = map(xs, switch4)
        return try? #require(actual == expected)
      }
}

private func switch5Test<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func switch5(_ x: T) -> T {
        switch x {
            case 0: 1
            case 1: 3
            case 4: 7
            case 7: 255
            case 214: 11
            default: x
        }
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(switch5)
        let actual = map(xs, switch5)
        return try? #require(actual == expected)
      }
}

private func switch6Test<T: Arbitrary & FixedWidthInteger>(_: T.Type) {
    func switch6(_ x: T) -> T {
        // introduce range-based case in the mix
        switch x {
            case 8 ... 100: 99
            default: x
        }
    }
    property(#function) <-
      forAllNoShrink([T].arbitrary) { (xs: [T]) in
        let expected = xs.map(switch6)
        let actual = map(xs, switch6)
        return try? #require(actual == expected)
      }
}
