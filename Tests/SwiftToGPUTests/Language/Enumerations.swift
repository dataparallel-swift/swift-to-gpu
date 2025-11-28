// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Enumerations")
struct EnumerationTests {
    @Suite("PlainEnumeration")
    struct PlainEnumerationTests {
        enum E1: Arbitrary {
            case opt1

            static var arbitrary: Gen<Self> {
                Bool.arbitrary.map { _ in Self.opt1 }
            }
        }

        @Test func switchE1() {
            func switchE1(_ value: E1) -> Int32 {
                switch value {
                    case .opt1: 0
                }
            }
            property(#function) <-
                forAllNoShrink([E1].arbitrary) { xs in
                    let expected = xs.map(switchE1)
                    let actual = map(xs, switchE1)
                    return try? #require(expected == actual)
                }
        }

        enum E2: Arbitrary {
            case opt1
            case opt2

            static var arbitrary: Gen<Self> {
                Bool.arbitrary.map { $0 ? Self.opt1 : Self.opt2 }
            }
        }

        @Test func switchE2() {
            func switchE2(_ value: E2) -> Int32 {
                switch value {
                    case .opt1: 0
                    case .opt2: 1
                }
            }
            property(#function) <-
                forAllNoShrink([E2].arbitrary) { xs in
                    let expected = xs.map(switchE2)
                    let actual = map(xs, switchE2)
                    return try? #require(expected == actual)
                }
        }

        enum E3: Arbitrary, Equatable {
            case opt1
            case opt2
            case opt3

            static var arbitrary: Gen<Self> {
                UInt8.arbitrary.map {
                    switch $0 % 3 {
                        case 0: Self.opt1
                        case 1: Self.opt2
                        default: Self.opt3
                    }
                }
            }
        }

        @Test func switchE3() {
            func switchE3(_ value: E3) -> Int32 {
                switch value {
                    case .opt1: 0
                    case .opt2: 1
                    case .opt3: 2
                }
            }
            property(#function) <-
                forAllNoShrink([E3].arbitrary) { xs in
                    let expected = xs.map(switchE3)
                    let actual = map(xs, switchE3)
                    return try? #require(expected == actual)
                }
        }

        enum E4: Arbitrary {
            case opt1
            case opt2
            case opt3
            case opt4

            static var arbitrary: Gen<Self> {
                UInt8.arbitrary.map {
                    switch $0 % 4 {
                        case 0: Self.opt1
                        case 1: Self.opt2
                        case 2: Self.opt3
                        default: Self.opt4
                    }
                }
            }
        }

        @Test func switchE4() {
            func switchE4(_ value: E4) -> Int32 {
                switch value {
                    case .opt1: 0
                    case .opt2: 1
                    case .opt3: 2
                    case .opt4: 3
                }
            }
            property(#function) <-
                forAllNoShrink([E4].arbitrary) { xs in
                    let expected = xs.map(switchE4)
                    let actual = map(xs, switchE4)
                    return try? #require(expected == actual)
                }
        }
    }

    // Enumerations With Associated Values
    //
    // The types of the associated values are parameterized. The size and
    // alignment of the enumeration will depend on the sizes and alignment
    // requirements of the types of associated values and how they are organized
    // therein. Here we explore whether the (GPU) code generator is able to
    // handle varying layout requirements.
    //
    // Select an arbitrary subset from the below, rather than the entire
    // cartesian product.
    //
    @Suite("EnumerationWithAssociatedValues")
    struct EnumerationWithAssociatedValuesTests {
        @Suite("Int")
        struct IntTests {
            @Test func switchEV1() { switchEV1Test(Int.self) }

            @Suite("Int")
            struct IntTests {
                @Test func switchEV2() { switchEV2Test(Int.self, Int.self) }
                @Test func switchEV3() { switchEV3Test(Int.self, Int.self) }
                @Test func switchEV4() { switchEV4Test(Int.self, Int.self) }
            }

            @Suite("Int8")
            struct Int8Tests {
                @Test func switchEV2() { switchEV2Test(Int.self, Int8.self) }
                @Test func switchEV3() { switchEV3Test(Int.self, Int8.self) }
                @Test func switchEV4() { switchEV4Test(Int.self, Int8.self) }
            }

            // @Suite("Int16") struct Int16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, Int16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, Int16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, Int16.self) }
            // }

            // @Suite("Int32") struct Int32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, Int32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, Int32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, Int32.self) }
            // }

            // @Suite("Int64") struct Int64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, Int64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, Int64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, Int64.self) }
            // }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, UInt.self) }
            // }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int.self, UInt64.self) }
            // }
        }

        @Suite("Int8")
        struct Int8Tests {
            @Test func switchEV1() { switchEV1Test(Int8.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, Int.self) }
            // }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, Int8.self) }
            // }

            @Suite("Int16")
            struct Int16Tests {
                @Test func switchEV2() { switchEV2Test(Int8.self, Int16.self) }
                @Test func switchEV3() { switchEV3Test(Int8.self, Int16.self) }
                @Test func switchEV4() { switchEV4Test(Int8.self, Int16.self) }
            }

            @Suite("Int32")
            struct Int32Tests {
                @Test func switchEV2() { switchEV2Test(Int8.self, Int32.self) }
                @Test func switchEV3() { switchEV3Test(Int8.self, Int32.self) }
                @Test func switchEV4() { switchEV4Test(Int8.self, Int32.self) }
            }

            // @Suite("Int64") struct Int64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, Int64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, Int64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, Int64.self) }
            // }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, UInt.self) }
            // }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int8.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int8.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int8.self, UInt64.self) }
            // }
        }

        @Suite("Int16")
        struct Int16Tests {
            @Test func switchEV1() { switchEV1Test(Int16.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, Int.self) }
            // }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, Int8.self) }
            // }

            // @Suite("Int16") struct Int16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, Int16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, Int16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, Int16.self) }
            // }

            // @Suite("Int32") struct Int32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, Int32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, Int32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, Int32.self) }
            // }

            @Suite("Int64")
            struct Int64Tests {
                @Test func switchEV2() { switchEV2Test(Int16.self, Int64.self) }
                @Test func switchEV3() { switchEV3Test(Int16.self, Int64.self) }
                @Test func switchEV4() { switchEV4Test(Int16.self, Int64.self) }
            }

            @Suite("UInt")
            struct UIntTests {
                @Test func switchEV2() { switchEV2Test(Int16.self, UInt.self) }
                @Test func switchEV3() { switchEV3Test(Int16.self, UInt.self) }
                @Test func switchEV4() { switchEV4Test(Int16.self, UInt.self) }
            }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int16.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int16.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int16.self, UInt64.self) }
            // }
        }

        @Suite("Int32")
        struct Int32Tests {
            @Test func switchEV1() { switchEV1Test(Int32.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, Int.self) }
            // }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, Int8.self) }
            // }

            // @Suite("Int16") struct Int16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, Int16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, Int16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, Int16.self) }
            // }

            // @Suite("Int32") struct Int32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, Int32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, Int32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, Int32.self) }
            // }

            // @Suite("Int64") struct Int64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, Int64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, Int64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, Int64.self) }
            // }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, UInt.self) }
            // }

            @Suite("UInt8")
            struct UInt8Tests {
                @Test func switchEV2() { switchEV2Test(Int32.self, UInt8.self) }
                @Test func switchEV3() { switchEV3Test(Int32.self, UInt8.self) }
                @Test func switchEV4() { switchEV4Test(Int32.self, UInt8.self) }
            }

            @Suite("UInt16")
            struct UInt16Tests {
                @Test func switchEV2() { switchEV2Test(Int32.self, UInt16.self) }
                @Test func switchEV3() { switchEV3Test(Int32.self, UInt16.self) }
                @Test func switchEV4() { switchEV4Test(Int32.self, UInt16.self) }
            }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int32.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int32.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int32.self, UInt64.self) }
            // }
        }

        @Suite("Int64")
        struct Int64Tests {
            @Test func switchEV1() { switchEV1Test(Int64.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, Int.self) }
            // }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, Int8.self) }
            // }

            // @Suite("Int16") struct Int16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, Int16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, Int16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, Int16.self) }
            // }

            // @Suite("Int32") struct Int32Tests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, Int32.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, Int32.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, Int32.self) }
            // }

            // @Suite("Int64") struct Int64Tests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, Int64.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, Int64.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, Int64.self) }
            // }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, UInt.self) }
            // }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(Int64.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(Int64.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(Int64.self, UInt16.self) }
            // }

            @Suite("UInt32")
            struct UInt32Tests {
                @Test func switchEV2() { switchEV2Test(Int64.self, UInt32.self) }
                @Test func switchEV3() { switchEV3Test(Int64.self, UInt32.self) }
                @Test func switchEV4() { switchEV4Test(Int64.self, UInt32.self) }
            }

            @Suite("UInt64")
            struct UInt64Tests {
                @Test func switchEV2() { switchEV2Test(Int64.self, UInt64.self) }
                @Test func switchEV3() { switchEV3Test(Int64.self, UInt64.self) }
                @Test func switchEV4() { switchEV4Test(Int64.self, UInt64.self) }
            }
        }

        @Suite("UInt")
        struct UIntTests {
            @Test func switchEV1() { switchEV1Test(UInt.self) }

            @Suite("Int")
            struct IntTests {
                @Test func switchEV2() { switchEV2Test(UInt.self, Int.self) }
                @Test func switchEV3() { switchEV3Test(UInt.self, Int.self) }
                @Test func switchEV4() { switchEV4Test(UInt.self, Int.self) }
            }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, Int8.self) }
            // }

            @Suite("Int16")
            struct Int16Tests {
                @Test func switchEV2() { switchEV2Test(UInt.self, Int16.self) }
                @Test func switchEV3() { switchEV3Test(UInt.self, Int16.self) }
                @Test func switchEV4() { switchEV4Test(UInt.self, Int16.self) }
            }

            // @Suite("Int32") struct Int32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, Int32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, Int32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, Int32.self) }
            // }

            // @Suite("Int64") struct Int64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, Int64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, Int64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, Int64.self) }
            // }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, UInt.self) }
            // }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt.self, UInt64.self) }
            // }
        }

        @Suite("UInt8")
        struct UInt8Tests {
            @Test func switchEV1() { switchEV1Test(UInt8.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, Int.self) }
            // }

            @Suite("Int8")
            struct Int8Tests {
                @Test func switchEV2() { switchEV2Test(UInt8.self, Int8.self) }
                @Test func switchEV3() { switchEV3Test(UInt8.self, Int8.self) }
                @Test func switchEV4() { switchEV4Test(UInt8.self, Int8.self) }
            }

            // @Suite("Int16") struct Int16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, Int16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, Int16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, Int16.self) }
            // }

            @Suite("Int32")
            struct Int32Tests {
                @Test func switchEV2() { switchEV2Test(UInt8.self, Int32.self) }
                @Test func switchEV3() { switchEV3Test(UInt8.self, Int32.self) }
                @Test func switchEV4() { switchEV4Test(UInt8.self, Int32.self) }
            }

            // @Suite("Int64") struct Int64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, Int64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, Int64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, Int64.self) }
            // }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, UInt.self) }
            // }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt8.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt8.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt8.self, UInt64.self) }
            // }
        }

        @Suite("UInt16")
        struct UInt16Tests {
            @Test func switchEV1() { switchEV1Test(UInt16.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, Int.self) }
            // }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, Int8.self) }
            // }

            @Suite("Int16")
            struct Int16Tests {
                @Test func switchEV2() { switchEV2Test(UInt16.self, Int16.self) }
                @Test func switchEV3() { switchEV3Test(UInt16.self, Int16.self) }
                @Test func switchEV4() { switchEV4Test(UInt16.self, Int16.self) }
            }

            // @Suite("Int32") struct Int32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, Int32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, Int32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, Int32.self) }
            // }

            @Suite("Int64")
            struct Int64Tests {
                @Test func switchEV2() { switchEV2Test(UInt16.self, Int64.self) }
                @Test func switchEV3() { switchEV3Test(UInt16.self, Int64.self) }
                @Test func switchEV4() { switchEV4Test(UInt16.self, Int64.self) }
            }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, UInt.self) }
            // }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt16.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt16.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt16.self, UInt64.self) }
            // }
        }

        @Suite("UInt32")
        struct UInt32Tests {
            @Test func switchEV1() { switchEV1Test(UInt32.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, Int.self) }
            // }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, Int8.self) }
            // }

            // @Suite("Int16") struct Int16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, Int16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, Int16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, Int16.self) }
            // }

            @Suite("Int32")
            struct Int32Tests {
                @Test func switchEV2() { switchEV2Test(UInt32.self, Int32.self) }
                @Test func switchEV3() { switchEV3Test(UInt32.self, Int32.self) }
                @Test func switchEV4() { switchEV4Test(UInt32.self, Int32.self) }
            }

            // @Suite("Int64") struct Int64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, Int64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, Int64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, Int64.self) }
            // }

            @Suite("UInt")
            struct UIntTests {
                @Test func switchEV2() { switchEV2Test(UInt32.self, UInt.self) }
                @Test func switchEV3() { switchEV3Test(UInt32.self, UInt.self) }
                @Test func switchEV4() { switchEV4Test(UInt32.self, UInt.self) }
            }

            // @Suite("UInt8") struct UInt8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, UInt8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, UInt8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, UInt8.self) }
            // }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt32.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt32.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt32.self, UInt64.self) }
            // }
        }

        @Suite("UInt64")
        struct UInt64Tests {
            @Test func switchEV1() { switchEV1Test(UInt64.self) }

            // @Suite("Int") struct IntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, Int.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, Int.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, Int.self) }
            // }

            // @Suite("Int8") struct Int8Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, Int8.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, Int8.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, Int8.self) }
            // }

            // @Suite("Int16") struct Int16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, Int16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, Int16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, Int16.self) }
            // }

            // @Suite("Int32") struct Int32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, Int32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, Int32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, Int32.self) }
            // }

            @Suite("Int64")
            struct Int64Tests {
                @Test func switchEV2() { switchEV2Test(UInt64.self, Int64.self) }
                @Test func switchEV3() { switchEV3Test(UInt64.self, Int64.self) }
                @Test func switchEV4() { switchEV4Test(UInt64.self, Int64.self) }
            }

            // @Suite("UInt") struct UIntTests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, UInt.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, UInt.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, UInt.self) }
            // }

            @Suite("UInt8")
            struct UInt8Tests {
                @Test func switchEV2() { switchEV2Test(UInt64.self, UInt8.self) }
                @Test func switchEV3() { switchEV3Test(UInt64.self, UInt8.self) }
                @Test func switchEV4() { switchEV4Test(UInt64.self, UInt8.self) }
            }

            // @Suite("UInt16") struct UInt16Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, UInt16.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, UInt16.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, UInt16.self) }
            // }

            // @Suite("UInt32") struct UInt32Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, UInt32.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, UInt32.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, UInt32.self) }
            // }

            // @Suite("UInt64") struct UInt64Tests {
            //     @Test func switchEV2() { switchEV2Test(UInt64.self, UInt64.self) }
            //     @Test func switchEV3() { switchEV3Test(UInt64.self, UInt64.self) }
            //     @Test func switchEV4() { switchEV4Test(UInt64.self, UInt64.self) }
            // }
        }
    }
}

// MARK: Enumerations with associated values

enum EV1<T: Arbitrary>: Arbitrary {
    case opt1(T)

    static var arbitrary: Gen<Self> {
        T.arbitrary.map { Self.opt1($0) }
    }
}

private func switchEV1Test<T: Arbitrary & Equatable>(_: T.Type) {
    func switchEV1(_ value: EV1<T>) -> T {
        switch value {
            case let .opt1(payload): payload
        }
    }
    property(#function) <-
        forAllNoShrink([EV1<T>].arbitrary) { xs in
            let expected = xs.map(switchEV1)
            let actual = map(xs, switchEV1)
            return try? #require(expected == actual)
        }
}

enum EV2<A: Arbitrary, B: Arbitrary>: Arbitrary {
    case opt1(A)
    case opt2(B)

    static var arbitrary: Gen<Self> {
        Gen<EV2>.compose { composer -> EV2 in
            let select: Bool = composer.generate()
            return select ? Self.opt1(composer.generate()) : Self.opt2(composer.generate())
        }
    }
}

private func switchEV2Test<A: Arbitrary & FixedWidthInteger, B: Arbitrary & FixedWidthInteger>(_: A.Type, _: B.Type) {
    func switchEV2(_ value: EV2<A, B>) -> Float64 {
        switch value {
            case let .opt1(payload): Float64(payload)
            case let .opt2(payload): Float64(payload)
        }
    }
    property(#function) <-
        forAllNoShrink([EV2<A, B>].arbitrary) { xs in
            let expected = xs.map(switchEV2)
            let actual = map(xs, switchEV2)
            return try? #require(expected == actual)
        }
}

enum EV3<A: Arbitrary, B: Arbitrary>: Arbitrary {
    case opt1(A)
    case opt2(B)
    case opt3(A, B)

    static var arbitrary: Gen<Self> {
        Gen<EV3>.compose { composer -> EV3 in
            let select: UInt8 = composer.generate()
            return switch select % 3 {
                case 0: Self.opt1(composer.generate())
                case 1: Self.opt2(composer.generate())
                default: Self.opt3(composer.generate(), composer.generate())
            }
        }
    }
}

private func switchEV3Test<A: Arbitrary & BinaryInteger, B: Arbitrary & BinaryInteger>(_: A.Type, _: B.Type) {
    func switchEV3(_ value: EV3<A, B>) -> Float64 {
        switch value {
            case let .opt1(payload): Float64(payload)
            case let .opt2(payload): Float64(payload)
            case let .opt3(payload1, payload2): Float64(payload1) + Float64(payload2)
        }
    }
    property(#function) <-
        forAllNoShrink([EV3<A, B>].arbitrary) { xs in
            let expected = xs.map(switchEV3)
            let actual = map(xs, switchEV3)
            return try? #require(expected == actual)
        }
}

enum EV4<A: Arbitrary, B: Arbitrary>: Arbitrary {
    case opt1(A)
    case opt3(A, B)
    case opt2(B)
    case opt4

    static var arbitrary: Gen<Self> {
        Gen<EV4>.compose { composer -> EV4 in
            let select: UInt8 = composer.generate()
            return switch select % 4 {
                case 0: Self.opt1(composer.generate())
                case 1: Self.opt2(composer.generate())
                case 2: Self.opt3(composer.generate(), composer.generate())
                default: Self.opt4
            }
        }
    }
}

private func switchEV4Test<A: Arbitrary & BinaryInteger, B: Arbitrary & BinaryInteger>(_: A.Type, _: B.Type) {
    func switchEV4(_ value: EV4<A, B>) -> Float64 {
        switch value {
            case let .opt1(payload): Double(payload)
            case let .opt2(payload): Double(payload)
            case let .opt3(payload1, payload2): Double(payload1) + Double(payload2)
            case .opt4: 0
        }
    }
    property(#function) <-
        forAllNoShrink([EV4<A, B>].arbitrary) { xs in
            let expected = xs.map(switchEV4)
            let actual = map(xs, switchEV4)
            return try? #require(expected == actual)
        }
}
