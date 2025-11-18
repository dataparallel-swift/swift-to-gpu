// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToGPU
import Testing

// swiftlint:disable file_length nesting

// The types of the members of the struct determine its layout: size, alignment,
// and padding. The purpose of these tests is to check property access for
// varying layouts.
//
@Suite("Structs")
struct StructTests {
    @Suite("WithOneMember")
    struct S1Tests {
        @Suite("Bool")
        struct BoolTests {
            @Test func get() { getTest(Bool.self) }
            @Test func set() { setTest(Bool.self) }
            @Test func setInout() { setInoutTest(Bool.self) }
            // @Test func defaultInitialiser() { defaultInitialiserTest(Bool.self) }
        }

        @Suite("Int")
        struct IntTests {
            @Test func get() { getTest(Int.self) }
            @Test func set() { setTest(Int.self) }
            @Test func setInout() { setInoutTest(Int.self) }
            @Test func defaultInitialiser() { defaultInitialiserTest(Int.self) }
        }

        @Suite("Int8")
        struct Int8Tests {
            @Test func get() { getTest(Int8.self) }
            @Test func set() { setTest(Int8.self) }
            @Test func setInout() { setInoutTest(Int8.self) }
            @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self) }
        }

        @Suite("Int16")
        struct Int16Tests {
            @Test func get() { getTest(Int16.self) }
            @Test func set() { setTest(Int16.self) }
            @Test func setInout() { setInoutTest(Int16.self) }
            @Test func defaultInitialiser() { defaultInitialiserTest(Int16.self) }
        }

        @Suite("Int32")
        struct Int32Tests {
            @Test func get() { getTest(Int32.self) }
            @Test func set() { setTest(Int32.self) }
            @Test func setInout() { setInoutTest(Int32.self) }
            @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self) }
        }

        @Suite("Int64")
        struct Int64Tests {
            @Test func get() { getTest(Int64.self) }
            // @Test(.bug(id: "86b70m272")) func set() { setTest(Int64.self) }
            // @Test(.bug(id: "86b70m272")) func setInout() { setInoutTest(Int64.self) }
            // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int64.self) }
        }

        @Suite("UInt")
        struct UIntTests {
            @Test func get() { getTest(UInt.self) }
            // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt.self) }
            // @Test(.bug(id: "86b70m272")) func setInout() { setInoutTest(UInt.self) }
            // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt.self) }
        }

        @Suite("UInt8")
        struct UInt8Tests {
            @Test func get() { getTest(UInt8.self) }
            // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt8.self) }
            // @Test(.bug(id: "86b70m272")) func setInout() { setInoutTest(UInt8.self) }
            // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt8.self) }
        }

        @Suite("UInt16")
        struct UInt16Tests {
            @Test func get() { getTest(UInt16.self) }
            // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt16.self) }
            // @Test(.bug(id: "86b70m272")) func setInout() { setInoutTest(UInt16.self) }
            // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt16.self) }
        }

        @Suite("UInt32")
        struct UInt32Tests {
            @Test func get() { getTest(UInt32.self) }
            // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt32.self) }
            // @Test(.bug(id: "86b70m272")) func setInout() { setInoutTest(UInt32.self) }
            // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt32.self) }
        }

        @Suite("UInt64")
        struct UInt64Tests {
            @Test func get() { getTest(UInt64.self) }
            // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt64.self) }
            // @Test(.bug(id: "86b70m272")) func setInout() { setInoutTest(UInt64.self) }
            // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt64.self) }
        }

        #if arch(arm64)
        @Suite("Float16")
        struct Float16Tests {
            @Test func get() { getTest(Float16.self) }
            @Test func set() { setTest(Float16.self) }
            @Test func setInout() { setInoutTest(Float16.self) }
            @Test func defaultInitialiser() { defaultInitialiserTest(Float16.self) }
        }
        #endif

        @Suite("Float32")
        struct Float32Tests {
            @Test func get() { getTest(Float32.self) }
            @Test func set() { setTest(Float32.self) }
            @Test func setInout() { setInoutTest(Float32.self) }
            @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self) }
        }

        @Suite("Float64")
        struct Float64Tests {
            @Test func get() { getTest(Float64.self) }
            @Test func set() { setTest(Float64.self) }
            @Test func setInout() { setInoutTest(Float64.self) }
            @Test func defaultInitialiser() { defaultInitialiserTest(Float64.self) }
        }

        // Throw some non-primitive values into the mix
        @Suite("S2<Int64, Int8>")
        struct S2Int64Int8Tests {
            @Test func get() { getTest(S2<Int64, Int8>.self) }
            @Test func set() { setTest(S2<Int64, Int8>.self) }
            @Test func setInout() { setInoutTest(S2<Int64, Int8>.self) }
        }

        @Suite("S3<Int64, Int8, Float64>")
        struct S3Int64Int8Float64Tests {
            @Test func get() { getTest(S3<Int64, Int8, Float64>.self) }
            @Test func set() { setTest(S3<Int64, Int8, Float64>.self) }
            @Test func setInout() { setInoutTest(S3<Int64, Int8, Float64>.self) }
        }

        // @Suite("Array<Int32>") struct ArrayInt32Tests {
        //     @Test(.bug(id: "86b79rt9h")) func get { getTest(Array<Int32>.self) }
        //     @Test(.bug(id: "86b79rt9h")) func set { setTest(Array<Int32>.self) }
        //     @Test(.bug(id: "86b79rt9h")) func setInout { setInoutTest(Array<Int32>.self) }
        // }
    }

    @Suite("WithTwoMembers")
    struct S2Tests {
        @Suite("Int8")
        struct Int8Tests {
            @Suite("Int8")
            struct Int8Tests {
                @Test func get1() { get1Test(Int8.self, Int8.self) }
                @Test func get2() { get2Test(Int8.self, Int8.self) }
                @Test func set() { setTest(Int8.self, Int8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Int8.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int8.self, Int8.self) }
            }

            @Suite("Int16")
            struct Int16Tests {
                @Test func get1() { get1Test(Int8.self, Int16.self) }
                @Test func get2() { get2Test(Int8.self, Int16.self) }
                @Test func set() { setTest(Int8.self, Int16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Int16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self, Int16.self) }
            }

            @Suite("Int32")
            struct Int32Tests {
                @Test func get1() { get1Test(Int8.self, Int32.self) }
                @Test func get2() { get2Test(Int8.self, Int32.self) }
                @Test func set() { setTest(Int8.self, Int32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Int32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self, Int32.self) }
            }

            @Suite("Int64")
            struct Int64Tests {
                @Test func get1() { get1Test(Int8.self, Int64.self) }
                @Test func get2() { get2Test(Int8.self, Int64.self) }
                @Test func set() { setTest(Int8.self, Int64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Int64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self, Int64.self) }
            }

            @Suite("UInt8")
            struct UInt8Tests {
                @Test func get1() { get1Test(Int8.self, UInt8.self) }
                @Test func get2() { get2Test(Int8.self, UInt8.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int8.self, UInt8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, UInt8.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self, UInt8.self) }
            }

            @Suite("UInt32")
            struct UInt32Tests {
                @Test func get1() { get1Test(Int8.self, UInt32.self) }
                @Test func get2() { get2Test(Int8.self, UInt32.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int8.self, UInt32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, UInt32.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int8.self, UInt32.self) }
            }

            @Suite("UInt16")
            struct UInt16Tests {
                @Test func get1() { get1Test(Int8.self, UInt16.self) }
                @Test func get2() { get2Test(Int8.self, UInt16.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int8.self, UInt16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, UInt16.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int8.self, UInt16.self) }
            }

            @Suite("UInt64")
            struct UInt64Tests {
                @Test func get1() { get1Test(Int8.self, UInt64.self) }
                @Test func get2() { get2Test(Int8.self, UInt64.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int8.self, UInt64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, UInt64.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int8.self, UInt64.self) }
            }

            #if arch(arm64)
            @Suite("Float16")
            struct Float16Tests {
                @Test func get1() { get1Test(Int8.self, Float16.self) }
                @Test func get2() { get2Test(Int8.self, Float16.self) }
                @Test func set() { setTest(Int8.self, Float16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Float16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self, Float16.self) }
            }
            #endif

            @Suite("Float32")
            struct Float32Tests {
                @Test func get1() { get1Test(Int8.self, Float32.self) }
                @Test func get2() { get2Test(Int8.self, Float32.self) }
                @Test func set() { setTest(Int8.self, Float32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Float32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self, Float32.self) }
            }

            @Suite("Float64")
            struct Float64Tests {
                @Test func get1() { get1Test(Int8.self, Float64.self) }
                @Test func get2() { get2Test(Int8.self, Float64.self) }
                @Test func set() { setTest(Int8.self, Float64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Float64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int8.self, Float64.self) }
            }
        }

        @Suite("Int32")
        struct Int32Tests {
            @Suite("Int8")
            struct Int8Tests {
                @Test func get1() { get1Test(Int32.self, Int8.self) }
                @Test func get2() { get2Test(Int32.self, Int8.self) }
                @Test func set() { setTest(Int32.self, Int8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, Int8.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int32.self, Int8.self) }
            }

            @Suite("Int16")
            struct Int16Tests {
                @Test func get1() { get1Test(Int32.self, Int16.self) }
                @Test func get2() { get2Test(Int32.self, Int16.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int32.self, Int16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, Int16.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int32.self, Int16.self) }
            }

            @Suite("Int32")
            struct Int32Tests {
                @Test func get1() { get1Test(Int32.self, Int32.self) }
                @Test func get2() { get2Test(Int32.self, Int32.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int32.self, Int32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, Int32.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int32.self, Int32.self) }
            }

            @Suite("Int64")
            struct Int64Tests {
                @Test func get1() { get1Test(Int32.self, Int64.self) }
                @Test func get2() { get2Test(Int32.self, Int64.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int32.self, Int64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, Int64.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int32.self, Int64.self) }
            }

            @Suite("UInt8")
            struct UInt8Tests {
                @Test func get1() { get1Test(Int32.self, UInt8.self) }
                @Test func get2() { get2Test(Int32.self, UInt8.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Int32.self, UInt8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, UInt8.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self, UInt8.self) }
            }

            @Suite("UInt16")
            struct UInt16Tests {
                @Test func get1() { get1Test(Int32.self, UInt16.self) }
                @Test func get2() { get2Test(Int32.self, UInt16.self) }
                @Test func set() { setTest(Int32.self, UInt16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, UInt16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self, UInt16.self) }
            }

            @Suite("UInt32")
            struct UInt32Tests {
                @Test func get1() { get1Test(Int32.self, UInt32.self) }
                @Test func get2() { get2Test(Int32.self, UInt32.self) }
                @Test func set() { setTest(Int32.self, UInt32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, UInt32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self, UInt32.self) }
            }

            @Suite("UInt64")
            struct UInt64Tests {
                @Test func get1() { get1Test(Int32.self, UInt64.self) }
                @Test func get2() { get2Test(Int32.self, UInt64.self) }
                @Test func set() { setTest(Int32.self, UInt64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, UInt64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self, UInt64.self) }
            }

            #if arch(arm64)
            @Suite("Float16")
            struct Float16Tests {
                @Test func get1() { get1Test(Int32.self, Float16.self) }
                @Test func get2() { get2Test(Int32.self, Float16.self) }
                @Test func set() { setTest(Int32.self, Float16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, Float16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self, Float16.self) }
            }
            #endif

            @Suite("Float32")
            struct Float32Tests {
                @Test func get1() { get1Test(Int32.self, Float32.self) }
                @Test func get2() { get2Test(Int32.self, Float32.self) }
                @Test func set() { setTest(Int32.self, Float32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, Float32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self, Float32.self) }
            }

            @Suite("Float64")
            struct Float64Tests {
                @Test func get1() { get1Test(Int32.self, Float64.self) }
                @Test func get2() { get2Test(Int32.self, Float64.self) }
                @Test func set() { setTest(Int32.self, Float64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int32.self, Float64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Int32.self, Float64.self) }
            }
        }

        @Suite("UInt64")
        struct UInt64Tests {
            @Suite("Int8")
            struct Int8Tests {
                @Test func get1() { get1Test(UInt64.self, Int8.self) }
                @Test func get2() { get2Test(UInt64.self, Int8.self) }
                @Test func set() { setTest(UInt64.self, Int8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, Int8.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(UInt64.self, Int8.self) }
            }

            @Suite("Int16")
            struct Int16Tests {
                @Test func get1() { get1Test(UInt64.self, Int16.self) }
                @Test func get2() { get2Test(UInt64.self, Int16.self) }
                @Test func set() { setTest(UInt64.self, Int16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, Int16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(UInt64.self, Int16.self) }
            }

            @Suite("Int32")
            struct Int32Tests {
                @Test func get1() { get1Test(UInt64.self, Int32.self) }
                @Test func get2() { get2Test(UInt64.self, Int32.self) }
                @Test func set() { setTest(UInt64.self, Int32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, Int32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(UInt64.self, Int32.self) }
            }

            @Suite("Int64")
            struct Int64Tests {
                @Test func get1() { get1Test(UInt64.self, Int64.self) }
                @Test func get2() { get2Test(UInt64.self, Int64.self) }
                @Test func set() { setTest(UInt64.self, Int64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, Int64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(UInt64.self, Int64.self) }
            }

            @Suite("UInt8")
            struct UInt8Tests {
                @Test func get1() { get1Test(UInt64.self, UInt8.self) }
                @Test func get2() { get2Test(UInt64.self, UInt8.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt64.self, UInt8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, UInt8.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt64.self, UInt8.self) }
            }

            @Suite("UInt16")
            struct UInt16Tests {
                @Test func get1() { get1Test(UInt64.self, UInt16.self) }
                @Test func get2() { get2Test(UInt64.self, UInt16.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt64.self, UInt16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, UInt16.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt64.self, UInt16.self) }
            }

            @Suite("UInt32")
            struct UInt32Tests {
                @Test func get1() { get1Test(UInt32.self, UInt32.self) }
                @Test func get2() { get2Test(UInt32.self, UInt32.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt32.self, UInt32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt32.self, UInt32.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt32.self, UInt32.self) }
            }

            @Suite("UInt64")
            struct UInt64Tests {
                @Test func get1() { get1Test(UInt64.self, UInt64.self) }
                @Test func get2() { get2Test(UInt64.self, UInt64.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(UInt64.self, UInt64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, UInt64.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt64.self, UInt64.self) }
            }

            #if arch(arm64)
            @Suite("Float16")
            struct Float16Tests {
                @Test func get1() { get1Test(UInt64.self, Float16.self) }
                @Test func get2() { get2Test(UInt64.self, Float16.self) }
                @Test func set() { setTest(UInt64.self, Float16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, Float16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(UInt64.self, Float16.self) }
            }
            #endif

            @Suite("Float32")
            struct Float32Tests {
                @Test func get1() { get1Test(UInt64.self, Float32.self) }
                @Test func get2() { get2Test(UInt64.self, Float32.self) }
                @Test func set() { setTest(UInt64.self, Float32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, Float32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(UInt64.self, Float32.self) }
            }

            @Suite("Float64")
            struct Float64Tests {
                @Test func get1() { get1Test(UInt64.self, Float64.self) }
                @Test func get2() { get2Test(UInt64.self, Float64.self) }
                @Test func set() { setTest(UInt64.self, Float64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt64.self, Float64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(UInt64.self, Float64.self) }
            }
        }

        @Suite("Float32")
        struct Float32Tests {
            @Suite("Int8")
            struct Int8Tests {
                @Test func get1() { get1Test(Float32.self, Int8.self) }
                @Test func get2() { get2Test(Float32.self, Int8.self) }
                @Test func set() { setTest(Float32.self, Int8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, Int8.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self, Int8.self) }
            }

            @Suite("Int16")
            struct Int16Tests {
                @Test func get1() { get1Test(Float32.self, Int16.self) }
                @Test func get2() { get2Test(Float32.self, Int16.self) }
                @Test func set() { setTest(Float32.self, Int16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, Int16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self, Int16.self) }
            }

            @Suite("Int32")
            struct Int32Tests {
                @Test func get1() { get1Test(Float32.self, Int32.self) }
                @Test func get2() { get2Test(Float32.self, Int32.self) }
                @Test func set() { setTest(Float32.self, Int32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, Int32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self, Int32.self) }
            }

            @Suite("Int64")
            struct Int64Tests {
                @Test func get1() { get1Test(Float32.self, Int64.self) }
                @Test func get2() { get2Test(Float32.self, Int64.self) }
                @Test func set() { setTest(Float32.self, Int64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, Int64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self, Int64.self) }
            }

            @Suite("UInt8")
            struct UInt8Tests {
                @Test func get1() { get1Test(Float32.self, UInt8.self) }
                @Test func get2() { get2Test(Float32.self, UInt8.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Float32.self, UInt8.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, UInt8.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Float32.self, UInt8.self) }
            }

            @Suite("UInt16")
            struct UInt16Tests {
                @Test func get1() { get1Test(Float32.self, UInt16.self) }
                @Test func get2() { get2Test(Float32.self, UInt16.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Float32.self, UInt16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, UInt16.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Float32.self, UInt16.self) }
            }

            @Suite("UInt64")
            struct UInt64Tests {
                @Test func get1() { get1Test(Float32.self, UInt64.self) }
                @Test func get2() { get2Test(Float32.self, UInt64.self) }
                // @Test(.bug(id: "86b70m272")) func set() { setTest(Float32.self, UInt64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, UInt64.self) }
                // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Float32.self, UInt64.self) }
            }

            #if arch(arm64)
            @Suite("Float16")
            struct Float16Tests {
                @Test func get1() { get1Test(Float32.self, Float16.self) }
                @Test func get2() { get2Test(Float32.self, Float16.self) }
                @Test func set() { setTest(Float32.self, Float16.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, Float16.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self, Float16.self) }
            }
            #endif

            @Suite("Float32")
            struct Float32Tests {
                @Test func get1() { get1Test(Float32.self, Float32.self) }
                @Test func get2() { get2Test(Float32.self, Float32.self) }
                @Test func set() { setTest(Float32.self, Float32.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, Float32.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self, Float32.self) }
            }

            @Suite("Float64")
            struct Float64Tests {
                @Test func get1() { get1Test(Float32.self, Float64.self) }
                @Test func get2() { get2Test(Float32.self, Float64.self) }
                @Test func set() { setTest(Float32.self, Float64.self) }
                // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float32.self, Float64.self) }
                @Test func defaultInitialiser() { defaultInitialiserTest(Float32.self, Float64.self) }
            }
        }
    }

    // More of the same, now with even less working. Pick some random types
    // because computing the entire cartesian product is silly.
    @Suite("WithThreeMembers")
    struct S3Tests {
        @Suite("Int8")
        struct Int8Tests {
            @Suite("Int8")
            struct Int8Tests {
                @Suite("Int8")
                struct Int8Tests {
                    @Test func get() { getTest(Int8.self, Int8.self, Int8.self) }
                    @Test func set() { setTest(Int8.self, Int8.self, Int8.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Int8.self, Int8.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int8.self, Int8.self, Int8.self) }
                }

                @Suite("UInt64")
                struct UInt64Tests {
                    @Test func get() { getTest(Int8.self, Int8.self, UInt64.self) }
                    @Test func set() { setTest(Int8.self, Int8.self, UInt64.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Int8.self, UInt64.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int8.self, Int8.self, UInt64.self) }
                }

                @Suite("Float32")
                struct Float32Tests {
                    @Test func get() { getTest(Int8.self, Int8.self, Float32.self) }
                    @Test func set() { setTest(Int8.self, Int8.self, Float32.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Int8.self, Int8.self, Float32.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Int8.self, Int8.self, Float32.self) }
                }
            }
        }

        @Suite("UInt32")
        struct UInt32Tests {
            @Suite("Int64")
            struct Int64Tests {
                @Suite("Int16")
                struct Int16Tests {
                    @Test func get() { getTest(UInt32.self, Int64.self, Int16.self) }
                    @Test func set() { setTest(UInt32.self, Int64.self, Int16.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt32.self, Int64.self, Int16.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt32.self, Int64.self, Int16.self) }
                }

                @Suite("UInt64")
                struct UInt64Tests {
                    @Test func get() { getTest(UInt32.self, Int64.self, UInt64.self) }
                    @Test func set() { setTest(UInt32.self, Int64.self, UInt64.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt32.self, Int64.self, UInt64.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt32.self, Int64.self, UInt64.self) }
                }

                @Suite("Float32")
                struct Float32Tests {
                    @Test func get() { getTest(UInt32.self, Int64.self, Float32.self) }
                    @Test func set() { setTest(UInt32.self, Int64.self, Float32.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(UInt32.self, Int64.self, Float32.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(UInt32.self, Int64.self, Float32.self) }
                }
            }
        }

        @Suite("Float64")
        struct Float64Tests {
            @Suite("Int64")
            struct Int64Tests {
                @Suite("Int16")
                struct Int16Tests {
                    @Test func get() { getTest(Float64.self, Int64.self, Int16.self) }
                    @Test func set() { setTest(Float64.self, Int64.self, Int16.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float64.self, Int64.self, Int16.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Float64.self, Int64.self, Int16.self) }
                }

                @Suite("UInt64")
                struct UInt64Tests {
                    @Test func get() { getTest(Float64.self, Int64.self, UInt64.self) }
                    @Test func set() { setTest(Float64.self, Int64.self, UInt64.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float64.self, Int64.self, UInt64.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Float64.self, Int64.self, UInt64.self) }
                }

                @Suite("Float32")
                struct Float32Tests {
                    @Test func get() { getTest(Float64.self, Int64.self, Float32.self) }
                    @Test func set() { setTest(Float64.self, Int64.self, Float32.self) }
                    // @Test(.bug(id: "86b7ef7w7")) func setInout() { setInoutTest(Float64.self, Int64.self, Float32.self) }
                    // @Test(.bug(id: "86b70m272")) func defaultInitialiser() { defaultInitialiserTest(Float64.self, Int64.self, Float32.self) }
                }
            }
        }
    }
}

struct S1<T: Arbitrary & Equatable>: Arbitrary & Equatable {
    var member: T

    static var arbitrary: Gen<Self> {
        T.arbitrary.map { Self(member: $0) }
    }
}

private func getTest<T: Arbitrary & Equatable>(_: T.Type) {
    func get(_ x: S1<T>) -> T {
        x.member
    }
    property(#function) <-
        forAllNoShrink([S1].arbitrary) { xs in
            let expected = xs.map(get)
            let actual = map(xs, get)
            return try? #require(expected == actual)
        }
}

private func setTest<T: Arbitrary & Equatable>(_: T.Type) {
    func set(_ x: S1<T>, _ member: T) -> S1<T> {
        var y = x
        y.member = member
        return y
    }
    property(#function) <-
        forAllNoShrink([S1<T>].arbitrary, [T].arbitrary) { xs, ys in
            let expected = zip(xs, ys).map { x, member in set(x, member) }
            let actual = zipWith(xs, ys, set)
            return try? #require(expected == actual)
        }
}

private func setInoutTest<T: Arbitrary & Equatable>(_: T.Type) {
    func setInout(_ x: inout S1<T>, _ member: T) {
        x.member = member
    }
    func set(_ x: S1<T>, _ member: T) -> S1<T> {
        var x = x
        setInout(&x, member)
        return x
    }
    property(#function) <-
        forAllNoShrink([S1<T>].arbitrary, [T].arbitrary) { xs, ys in
            let count = min(xs.count, ys.count)
            let expected = zip(xs, ys).map { x, member in set(x, member) }
            var actual = Array(xs.prefix(count))
            // NOTE: `parallel_for` required here because of in-place mutation,
            // i.e. modify accessor instead of subscript set
            try parallel_for(iterations: count) { i in
                setInout(&actual[i], ys[i])
            }.sync()
            return try? #require(expected == actual)
        }
}

struct S2<A: Arbitrary & Equatable, B: Arbitrary & Equatable>: Arbitrary, Equatable {
    var member1: A
    var member2: B

    init(_ member1: A, _ member2: B) {
        self.member1 = member1
        self.member2 = member2
    }

    static var arbitrary: Gen<Self> {
        Gen<Self>.compose { composer in
            Self(
                composer.generate(),
                composer.generate()
            )
        }
    }
}

private func get1Test<A: Arbitrary & Equatable, B: Arbitrary & Equatable>(_: A.Type, _: B.Type) {
    func get1(_ x: S2<A, B>) -> A {
        x.member1
    }
    property(#function) <-
        forAllNoShrink([S2<A, B>].arbitrary) { xs in
            let expected = xs.map(get1)
            let actual = map(xs, get1)
            return try? #require(expected == actual)
        }
}

private func get2Test<A: Arbitrary & Equatable, B: Arbitrary & Equatable>(_: A.Type, _: B.Type) {
    func get2(_ x: S2<A, B>) -> B {
        x.member2
    }
    property(#function) <-
        forAllNoShrink([S2<A, B>].arbitrary) { xs in
            let expected = xs.map(get2)
            let actual = map(xs, get2)
            return try? #require(expected == actual)
        }
}

private func setTest<A: Arbitrary & Equatable, B: Arbitrary & Equatable>(_: A.Type, _: B.Type) {
    func set(_ x: S2<A, B>, _ member1: A, _ member2: B) -> S2<A, B> {
        var x = x
        x.member1 = member1
        x.member2 = member2
        return x
    }

    property(#function) <-
        forAllNoShrink([S2<A, B>].arbitrary, A.arbitrary, B.arbitrary) { xs, member1, member2 in
            let expected = xs.map { set($0, member1, member2) } // TODO: zipWith3
            let actual = map(xs) { set($0, member1, member2) }
            return try? #require(expected == actual)
        }
}

private func setInoutTest<A: Arbitrary & Equatable, B: Arbitrary & Equatable>(_: A.Type, _: B.Type) {
    func setInout(_ x: inout S2<A, B>, _ member1: A, _ member2: B) {
        x.member1 = member1
        x.member2 = member2
    }

    func set(_ x: S2<A, B>, _ member1: A, _ member2: B) -> S2<A, B> {
        var x = x
        setInout(&x, member1, member2)
        return x
    }

    property(#function) <-
        forAllNoShrink([S2<A, B>].arbitrary, A.arbitrary, B.arbitrary) { (xs: [S2<A, B>], member1: A, member2: B) in
            let expected = xs.map { set($0, member1, member2) }
            var actual = xs
            // NOTE: `parallel_for` required here because of in-place mutation,
            // i.e. modify accessor instead of subscript set
            try parallel_for(iterations: xs.count) { i in
                setInout(&actual[i], member1, member2)
            }.sync()
            return try? #require(expected == actual)
        }
}

struct S3<A: Arbitrary & Equatable, B: Arbitrary & Equatable, C: Arbitrary & Equatable>: Arbitrary, Equatable {
    var member1: A
    var member2: B
    var member3: C

    init(_ member1: A, _ member2: B, _ member3: C) {
        self.member1 = member1
        self.member2 = member2
        self.member3 = member3
    }

    static var arbitrary: Gen<Self> {
        Gen<Self>.compose { composer in
            Self(
                composer.generate(),
                composer.generate(),
                composer.generate()
            )
        }
    }
}

private func getTest<A: Arbitrary & Equatable, B: Arbitrary & Equatable, C: Arbitrary & Equatable>(
    _: A.Type,
    _: B.Type,
    _: C.Type
) {
    func get(_ x: S3<A, B, C>, _ get1: Bool, _ get2: Bool, _ get3: Bool) -> S3<A?, B?, C?> {
        S3(
            get1 ? x.member1 : nil,
            get2 ? x.member2 : nil,
            get3 ? x.member3 : nil
        )
    }

    property(#function) <-
        forAllNoShrink(NonNegative<Int>.arbitrary) { n in
            forAllNoShrink(
                S3<A, B, C>.arbitrary.proliferate(withSize: n.getNonNegative),
                Bool.arbitrary.proliferate(withSize: n.getNonNegative),
                Bool.arbitrary.proliferate(withSize: n.getNonNegative),
                Bool.arbitrary.proliferate(withSize: n.getNonNegative)
            ) { xs, get1s, get2s, get3s in
                let expected = (0 ..< n.getNonNegative).map { i in get(xs[i], get1s[i], get2s[i], get3s[i]) }
                let actual = generate(count: n.getNonNegative) { i in get(xs[i], get1s[i], get2s[i], get3s[i]) }
                return try? #require(expected == actual)
            }
        }
}

private func setTest<A: Arbitrary & Equatable, B: Arbitrary & Equatable, C: Arbitrary & Equatable>(
    _: A.Type,
    _: B.Type,
    _: C.Type
) {
    func set(_ x: S3<A, B, C>, _ member1: A?, _ member2: B?, _ member3: C?) -> S3<A, B, C> {
        var x = x
        if let member1 = member1 {
            x.member1 = member1
        }
        if let member2 = member2 {
            x.member2 = member2
        }
        if let member3 = member3 {
            x.member3 = member3
        }
        return x
    }

    property(#function) <-
        forAllNoShrink(NonNegative<Int>.arbitrary) { n in
            forAllNoShrink(
                S3<A, B, C>.arbitrary.proliferate(withSize: n.getNonNegative),
                A?.arbitrary.proliferate(withSize: n.getNonNegative),
                B?.arbitrary.proliferate(withSize: n.getNonNegative),
                C?.arbitrary.proliferate(withSize: n.getNonNegative)
            ) { structs, xs, ys, zs in
                let expected = (0 ..< n.getNonNegative).map { i in set(structs[i], xs[i], ys[i], zs[i]) }
                let actual = generate(count: n.getNonNegative) { i in set(structs[i], xs[i], ys[i], zs[i]) }
                return try? #require(expected == actual)
            }
        }
}

private func setInoutTest<A: Arbitrary & Equatable, B: Arbitrary & Equatable, C: Arbitrary & Equatable>(
    _: A.Type,
    _: B.Type,
    _: C.Type
) {
    func setInout(_ x: inout S3<A, B, C>, _ member1: A?, _ member2: B?, _ member3: C?) {
        if let member1 = member1 {
            x.member1 = member1
        }
        if let member2 = member2 {
            x.member2 = member2
        }
        if let member3 = member3 {
            x.member3 = member3
        }
    }

    func set(_ x: S3<A, B, C>, _ member1: A?, _ member2: B?, _ member3: C?) -> S3<A, B, C> {
        var x = x
        setInout(&x, member1, member2, member3)
        return x
    }

    property(#function) <-
        forAllNoShrink(NonNegative<Int>.arbitrary) { n in
            forAllNoShrink(
                S3<A, B, C>.arbitrary.proliferate(withSize: n.getNonNegative),
                A?.arbitrary.proliferate(withSize: n.getNonNegative),
                B?.arbitrary.proliferate(withSize: n.getNonNegative),
                C?.arbitrary.proliferate(withSize: n.getNonNegative)
            ) { structs, xs, ys, zs in
                var actual = structs
                let expected = (0 ..< n.getNonNegative).map { i in set(structs[i], xs[i], ys[i], zs[i]) }

                // NOTE: `parallel_for` required here because of in-place mutation,
                // i.e. modify accessor instead of subscript set
                try parallel_for(iterations: n.getNonNegative) { i in
                    setInout(&actual[i], xs[i], ys[i], zs[i])
                }.sync()

                return try? #require(expected == actual)
            }
        }
}

// MARK: structs with default initializers

struct S1d<A: ExpressibleByIntegerLiteral & Equatable>: Equatable {
    var vd1: A = 42
}

private func defaultInitialiserTest<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(#function) <-
        forAllNoShrink(gen) { (n: Int) in
            let expected = [S1d<T>](repeating: S1d<T>(), count: n)
            let actual = generate(count: n) { _ in S1d<T>() }
            return try? #require(expected == actual)
        }
}

struct S2d<
    A: Equatable & ExpressibleByIntegerLiteral,
    B: Equatable & ExpressibleByIntegerLiteral
>: Equatable {
    var v1d: A = 42
    var v2d: B = 7
}

private func defaultInitialiserTest<
    A: Arbitrary & Equatable & ExpressibleByIntegerLiteral,
    B: Arbitrary & Equatable & ExpressibleByIntegerLiteral
>(_: A.Type, _: B.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(#function) <-
        forAllNoShrink(gen) { n in
            let expected = [S2d<A, B>](repeating: .init(), count: n)
            let actual = fill(count: n, with: S2d<A, B>())
            return try? #require(expected == actual)
        }
}

struct S3d<
    A: Equatable & ExpressibleByIntegerLiteral,
    B: Equatable & ExpressibleByIntegerLiteral,
    C: Equatable & ExpressibleByIntegerLiteral
>: Equatable {
    var member1: A = 42
    var member2: B = 7
    var member3: C = 13
}

private func defaultInitialiserTest<
    A: Equatable & ExpressibleByIntegerLiteral,
    B: Equatable & ExpressibleByIntegerLiteral,
    C: Equatable & ExpressibleByIntegerLiteral
>(_: A.Type, _: B.Type, _: C.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(#function) <-
        forAllNoShrink(gen) { (n: Int) in
            let expected = [S3d<A, B, C>](repeating: .init(), count: n)
            let actual = fill(count: n, with: S3d<A, B, C>())
            return try? #require(expected == actual)
        }
}
