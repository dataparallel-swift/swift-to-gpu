// Copyright (c) 2025 PassiveLogic, Inc.

import SwiftCheck
import SwiftToGPU
import Testing

// swiftlint:disable file_length type_body_length
// swiftformat:disable wrap wrapArguments wrapSingleLineComments trailingCommas

@Suite("structs") struct Structs {
    // The types of the members of the struct determine the layout (size, alignment, padding)
    // of the whole struct. The purpose of these tests is to check property access
    // for varying layouts.
    @Suite("PropertyGetters") struct PropertyGetters {
        // structs with 1 member variable
        @Suite("S1") struct S1Tests {
            @Test("S1<UInt>.get") func test_struct1_property_get_1() { prop_struct1_property_get(UInt.self) }
            @Test("S1<UInt8>.get") func test_struct1_property_get_2() { prop_struct1_property_get(UInt8.self) }
            @Test("S1<UInt16>.get") func test_struct1_property_get_3() { prop_struct1_property_get(UInt16.self) }
            @Test("S1<UInt32>.get") func test_struct1_property_get_4() { prop_struct1_property_get(UInt32.self) }
            @Test("S1<UInt64>.get") func test_struct1_property_get_5() { prop_struct1_property_get(UInt64.self) }
            // It was found in the property setters tests that some bugs can manifest depending on signedness for some reason
            // hence we cover both `Int` and `UInt` even though they have identical layouts.
            @Test("S1<Int>.get") func test_struct1_property_get_6() { prop_struct1_property_get(Int.self) }
            @Test("S1<Int8>.get") func test_struct1_property_get_7() { prop_struct1_property_get(Int8.self) }
            @Test("S1<Int16>.get") func test_struct1_property_get_8() { prop_struct1_property_get(Int16.self) }
            @Test("S1<Int32>.get") func test_struct1_property_get_9() { prop_struct1_property_get(Int32.self) }
            @Test("S1<Int64>.get") func test_struct1_property_get_10() { prop_struct1_property_get(Int64.self) }

            @Test("S1<Float32>.get") func test_struct1_property_get_12() { prop_struct1_property_get(Float32.self) }
            @Test("S1<Float64>.get") func test_struct1_property_get_13() { prop_struct1_property_get(Float64.self) }
            @Test("S1<Bool>.get") func test_struct1_property_get_14() { prop_struct1_property_get(Bool.self) }

            // non-primitive members
            @Test("S1<S2<Int64,Int8>>") func test_struct1_property_get_15() { prop_struct1_property_get(S2<Int64, Int8>.self) }
            @Test("S1<S3<Int64,Int8,Float64>>") func test_struct1_property_get_16() { prop_struct1_property_get(S3<Int64, Int8, Float64>.self) }
            // @Test("S1<Array<Int32>>", .bug(id: "86b79rt9h")) func test_struct1_property_get_17() { prop_struct1_property_get(Array<Int32>.self) }
        }

        // structs with 2 member variables
        @Suite("S2") struct S2Tests {
            // T1 = Int8
            @Test("S2<Int8,Int8>.get") func test_struct2_property_get_i8_1() { prop_struct2_property_get(Int8.self, Int8.self) }
            @Test("S2<Int8,Int16>.get") func test_struct2_property_get_i8_2() { prop_struct2_property_get(Int8.self, Int16.self) }
            @Test("S2<Int8,Int32>.get") func test_struct2_property_get_i8_3() { prop_struct2_property_get(Int8.self, Int32.self) }
            @Test("S2<Int8,Int64>.get") func test_struct2_property_get_k8_4() { prop_struct2_property_get(Int8.self, Int64.self) }
            @Test("S2<Int8,UInt8>.get") func test_struct2_property_get_i8_5() { prop_struct2_property_get(Int8.self, UInt8.self) }
            @Test("S2<Int8,UInt16>.get") func test_struct2_property_get_i8_6() { prop_struct2_property_get(Int8.self, UInt16.self) }
            @Test("S2<Int8,UInt32>.get") func test_struct2_property_get_i8_7() { prop_struct2_property_get(Int8.self, UInt32.self) }
            @Test("S2<Int8,UInt64>.get") func test_struct2_property_get_k8_8() { prop_struct2_property_get(Int8.self, UInt64.self) }

            // T1 = Int32
            @Test("S2<Int32,Int8>.get") func test_struct2_property_get_i32_1() { prop_struct2_property_get(Int32.self, Int8.self) }
            @Test("S2<Int32,Int16>.get") func test_struct2_property_get_i32_2() { prop_struct2_property_get(Int32.self, Int16.self) }
            @Test("S2<Int32,Int32>.get") func test_struct2_property_get_i32_3() { prop_struct2_property_get(Int32.self, Int32.self) }
            @Test("S2<Int32,Int64>.get") func test_struct2_property_get_i32_4() { prop_struct2_property_get(Int32.self, Int64.self) }
            @Test("S2<Int32,UInt8>.get") func test_struct2_property_get_i32_5() { prop_struct2_property_get(Int32.self, UInt8.self) }
            @Test("S2<Int32,UInt16>.get") func test_struct2_property_get_i32_6() { prop_struct2_property_get(Int32.self, UInt16.self) }
            @Test("S2<Int32,UInt32>.get") func test_struct2_property_get_i32_7() { prop_struct2_property_get(Int32.self, UInt32.self) }
            @Test("S2<Int32,UInt64>.get") func test_struct2_property_get_i32_8() { prop_struct2_property_get(Int32.self, UInt64.self) }

            // T1 = UInt32
            @Test("S2<UInt32,Int8>.get") func test_struct2_property_get_u32_1() { prop_struct2_property_get(UInt32.self, Int8.self) }
            @Test("S2<UInt32,Int16>.get") func test_struct2_property_get_u32_2() { prop_struct2_property_get(UInt32.self, Int16.self) }
            @Test("S2<UInt32,Int32>.get") func test_struct2_property_get_u32_3() { prop_struct2_property_get(UInt32.self, Int32.self) }
            @Test("S2<UInt32,Int64>.get") func test_struct2_property_get_u32_4() { prop_struct2_property_get(UInt32.self, Int64.self) }
            @Test("S2<UInt32,UInt8>.get") func test_struct2_property_get_u32_5() { prop_struct2_property_get(UInt32.self, UInt8.self) }
            @Test("S2<UInt32,UInt16>.get") func test_struct2_property_get_u32_6() { prop_struct2_property_get(UInt32.self, UInt16.self) }
            @Test("S2<UInt32,UInt32>.get") func test_struct2_property_get_u32_7() { prop_struct2_property_get(UInt32.self, UInt32.self) }
            @Test("S2<UInt32,UInt64>.get") func test_struct2_property_get_u32_8() { prop_struct2_property_get(UInt32.self, UInt64.self) }

            // T1 = Float32
            @Test("S2<Float32,Int8>.get") func test_struct2_property_get_f32_1() { prop_struct2_property_get(Float32.self, Int8.self) }
            @Test("S2<Float32,Int16>.get") func test_struct2_property_get_f32_2() { prop_struct2_property_get(Float32.self, Int16.self) }
            @Test("S2<Float32,Int32>.get") func test_struct2_property_get_f32_3() { prop_struct2_property_get(Float32.self, Int32.self) }
            @Test("S2<Float32,Int64>.get") func test_struct2_property_get_f32_4() { prop_struct2_property_get(Float32.self, Int64.self) }
            @Test("S2<Float32,UInt8>.get") func test_struct2_property_get_f32_5() { prop_struct2_property_get(Float32.self, UInt8.self) }
            @Test("S2<Float32,UInt16>.get") func test_struct2_property_get_f32_6() { prop_struct2_property_get(Float32.self, UInt16.self) }
            @Test("S2<Float32,UInt32>.get") func test_struct2_property_get_f32_7() { prop_struct2_property_get(Float32.self, UInt32.self) }
            @Test("S2<Float32,UInt64>.get") func test_struct2_property_get_f32_8() { prop_struct2_property_get(Float32.self, UInt64.self) }
            @Test("S2<Float32,Float32>.get") func test_struct2_property_get_f32_9() { prop_struct2_property_get(Float32.self, Float32.self) }
            @Test("S2<Float32,Float64>.get") func test_struct2_property_get_f32_10() { prop_struct2_property_get(Float32.self, Float64.self) }

            // T1 = Float64
            @Test("S2<Float64,Int8>.get") func test_struct2_property_get_f64_1() { prop_struct2_property_get(Float64.self, Int8.self) }
            @Test("S2<Float64,Int16>.get") func test_struct2_property_get_f64_2() { prop_struct2_property_get(Float64.self, Int16.self) }
            @Test("S2<Float64,Float32>.get") func test_struct2_property_get_f64_3() { prop_struct2_property_get(Float64.self, Int32.self) }
            @Test("S2<Float64,Int64>.get") func test_struct2_property_get_f64_4() { prop_struct2_property_get(Float64.self, Int64.self) }
            @Test("S2<Float64,UInt8>.get") func test_struct2_property_get_f64_5() { prop_struct2_property_get(Float64.self, UInt8.self) }
            @Test("S2<Float64,UInt16>.get") func test_struct2_property_get_f64_6() { prop_struct2_property_get(Float64.self, UInt16.self) }
            @Test("S2<Float64,UFloat32>.get") func test_struct2_property_get_f64_7() { prop_struct2_property_get(Float64.self, UInt32.self) }

            @Test("S2<Float64,UInt64>.get") func test_struct2_property_get_f64_8() { prop_struct2_property_get(Float64.self, UInt64.self) }
            @Test("S2<Float64,Float32>.get") func test_struct2_property_get_f64_9() { prop_struct2_property_get(Float64.self, Float32.self) }
            @Test("S2<Float64,Float64>.get") func test_struct2_property_get_f64_10() { prop_struct2_property_get(Float64.self, Float64.self) }

            // T1 = Array<Int32>
            // @Test("S2<Array<Int32>,Int8>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_1() { prop_struct2_property_get(Array<Int32>.self, Int8.self) }
            // @Test("S2<Array<Int32>,Int16>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_2() { prop_struct2_property_get(Array<Int32>.self, Int16.self) }
            // @Test("S2<Array<Int32>,Int32>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_3() { prop_struct2_property_get(Array<Int32>.self, Int32.self) }
            // @Test("S2<Array<Int32>,Int64>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_4() { prop_struct2_property_get(Array<Int32>.self, Int64.self) }
            // @Test("S2<Array<Int32>,UInt8>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_5() { prop_struct2_property_get(Array<Int32>.self, UInt8.self) }
            // @Test("S2<Array<Int32>,UInt16>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_6() { prop_struct2_property_get(Array<Int32>.self, UInt16.self) }
            // @Test("S2<Array<Int32>,UInt32>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_7() { prop_struct2_property_get(Array<Int32>.self, UInt32.self) }
            // @Test("S2<Array<Int32>,UInt64>.get", .bug(id: "86b6vgh48")) func test_struct2_property_get_i32s_8() { prop_struct2_property_get(Array<Int32>.self, UInt64.self) }
        }

        // structs with 3 member variables
        @Suite("S3") struct S3Tests {
            // This is where bugs started surfacing for the first time in the property setter tests
            @Suite("S3<Int8,T2,T3>") struct S3Int8Tests {
                // T2 = Int16
                // @Test("S3<Int8,Int16,Int8>.get", .bug(id: "86b79rt9h")) func test_struct3_property_get_i16_1() { prop_struct3_property_get(Int8.self, Int16.self, Int8.self) }
                // @Test("S3<Int8,Int16,Int16>.get", .bug(id: "86b79rt9h")) func test_struct3_property_get_i16_2() { prop_struct3_property_get(Int8.self, Int16.self, Int16.self) }
                // @Test("S3<Int8,Int16,Int32>.get", .bug(id: "86b79rt9h")) func test_struct3_property_get_i16_3() { prop_struct3_property_get(Int8.self, Int16.self, Int32.self) }
                // @Test("S3<Int8,Int16,Int64>.get", .bug(id: "86b79rt9h")) func test_struct3_property_get_i16_4() { prop_struct3_property_get(Int8.self, Int16.self, Int64.self) }
                // XXX: presence of unsigned integers seem to be causing a crash
                // @Test("S3<Int8,Int16,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_5() { prop_struct3_property_get(Int8.self, Int16.self, UInt8.self) }
                // @Test("S3<Int8,Int16,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_6() { prop_struct3_property_get(Int8.self, Int16.self, UInt16.self) }
                // @Test("S3<Int8,Int16,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_7() { prop_struct3_property_get(Int8.self, Int16.self, UInt32.self) }
                // @Test("S3<Int8,Int16,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_8() { prop_struct3_property_get(Int8.self, Int16.self, UInt64.self) }

                // T2 = Int64
                // @Test("S3<Int8,Int64,Int8>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_1() { prop_struct3_property_get(Int8.self, Int64.self, Int8.self) }
                // @Test("S3<Int8,Int64,Int16>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_2() { prop_struct3_property_get(Int8.self, Int64.self, Int16.self) }
                // @Test("S3<Int8,Int64,Int32>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_3() { prop_struct3_property_get(Int8.self, Int64.self, Int32.self) }
                // @Test("S3<Int8,Int64,Int64>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_4() { prop_struct3_property_get(Int8.self, Int64.self, Int64.self) }
                // @Test("S3<Int8,Int64,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_5() { prop_struct3_property_get(Int8.self, Int64.self, UInt8.self) }
                // @Test("S3<Int8,Int64,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_6() { prop_struct3_property_get(Int8.self, Int64.self, UInt16.self) }
                // @Test("S3<Int8,Int64,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_7() { prop_struct3_property_get(Int8.self, Int64.self, UInt32.self) }
                // @Test("S3<Int8,Int64,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_8() { prop_struct3_property_get(Int8.self, Int64.self, UInt64.self) }

                // T2 = Float32
                @Test("S3<Float32,Int64,Int8>.get") func test_struct3_property_get_f32_1() { prop_struct3_property_get(Float32.self, Int64.self, Int8.self) }
                @Test("S3<Float32,Int64,Int16>.get") func test_struct3_property_get_f32_2() { prop_struct3_property_get(Float32.self, Int64.self, Int16.self) }
                @Test("S3<Float32,Int64,Int32>.get") func test_struct3_property_get_f32_3() { prop_struct3_property_get(Float32.self, Int64.self, Int32.self) }
                @Test("S3<Float32,Int64,Int64>.get") func test_struct3_property_get_f32_4() { prop_struct3_property_get(Float32.self, Int64.self, Int64.self) }
                // @Test("S3<Float32,Int64,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f32_5() { prop_struct3_property_get(Float32.self, Int64.self, UInt8.self) }
                // @Test("S3<Float32,Int64,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f32_6() { prop_struct3_property_get(Float32.self, Int64.self, UInt16.self) }
                // @Test("S3<Float32,Int64,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f32_7() { prop_struct3_property_get(Float32.self, Int64.self, UInt32.self) }
                // @Test("S3<Float32,Int64,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f32_8() { prop_struct3_property_get(Float32.self, Int64.self, UInt64.self) }

                // T2 = Float64
                @Test("S3<Float64,Int64,Int8>.get") func test_struct3_property_get_f64_1() { prop_struct3_property_get(Float64.self, Int64.self, Int8.self) }
                @Test("S3<Float64,Int64,Int16>.get") func test_struct3_property_get_f64_2() { prop_struct3_property_get(Float64.self, Int64.self, Int16.self) }
                @Test("S3<Float64,Int64,Int32>.get") func test_struct3_property_get_f64_3() { prop_struct3_property_get(Float64.self, Int64.self, Int32.self) }
                @Test("S3<Float64,Int64,Int64>.get") func test_struct3_property_get_f64_4() { prop_struct3_property_get(Float64.self, Int64.self, Int64.self) }
                // @Test("S3<Float64,Int64,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f64_5() { prop_struct3_property_get(Float64.self, Int64.self, UInt8.self) }
                // @Test("S3<Float64,Int64,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f64_6() { prop_struct3_property_get(Float64.self, Int64.self, UInt16.self) }
                // @Test("S3<Float64,Int64,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f64_7() { prop_struct3_property_get(Float64.self, Int64.self, UInt32.self) }
                // @Test("S3<Float64,Int64,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_f64_8() { prop_struct3_property_get(Float64.self, Int64.self, UInt64.self) }
            }

            @Suite("S3<Int32,T2,T3>") struct S3Int32Tests {
                // T2 = Int16
                // @Test("S3<Int32,Int16,Int8>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i16_1() { prop_struct3_property_get(Int32.self, Int16.self, Int8.self) }
                // @Test("S3<Int32,Int16,Int16>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i16_2() { prop_struct3_property_get(Int32.self, Int16.self, Int16.self) }
                // @Test("S3<Int32,Int16,Int32>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i16_3() { prop_struct3_property_get(Int32.self, Int16.self, Int32.self) }
                // @Test("S3<Int32,Int16,Int64>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i16_4() { prop_struct3_property_get(Int32.self, Int16.self, Int64.self) }
                // @Test("S3<Int32,Int16,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_5() { prop_struct3_property_get(Int32.self, Int16.self, UInt8.self) }
                // @Test("S3<Int32,Int16,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_6() { prop_struct3_property_get(Int32.self, Int16.self, UInt16.self) }
                // @Test("S3<Int32,Int16,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_7() { prop_struct3_property_get(Int32.self, Int16.self, UInt32.self) }
                // @Test("S3<Int32,Int16,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_8() { prop_struct3_property_get(Int32.self, Int16.self, UInt64.self) }

                // T2 = Int64
                // @Test("S3<Int32,Int64,Int8>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_1() { prop_struct3_property_get(Int32.self, Int64.self, Int8.self) }
                // @Test("S3<Int32,Int64,Int16>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_2() { prop_struct3_property_get(Int32.self, Int64.self, Int16.self) }
                // @Test("S3<Int32,Int64,Int32>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_3() { prop_struct3_property_get(Int32.self, Int64.self, Int32.self) }
                // @Test("S3<Int32,Int64,Int64>.get", .bug(id: "86b6vgh48")) func test_struct3_property_get_i64_4() { prop_struct3_property_get(Int32.self, Int64.self, Int64.self) }
                // @Test("S3<Int32,Int64,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_5() { prop_struct3_property_get(Int32.self, Int64.self, UInt8.self) }
                // @Test("S3<Int32,Int64,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_6() { prop_struct3_property_get(Int32.self, Int64.self, UInt16.self) }
                // @Test("S3<Int32,Int64,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_7() { prop_struct3_property_get(Int32.self, Int64.self, UInt32.self) }
                // @Test("S3<Int32,Int64,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_8() { prop_struct3_property_get(Int32.self, Int64.self, UInt64.self) }
            }

            @Suite("S3<UInt32,T2,T3>") struct S3UInt32Tests {
                // T2 = Int16
                // @Test("S3<UInt32,Int16,Int8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_1() { prop_struct3_property_get(UInt32.self, Int16.self, Int8.self) }
                // @Test("S3<UInt32,Int16,Int16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_2() { prop_struct3_property_get(UInt32.self, Int16.self, Int16.self) }
                // @Test("S3<UInt32,Int16,Int32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_3() { prop_struct3_property_get(UInt32.self, Int16.self, Int32.self) }
                // @Test("S3<UInt32,Int16,Int64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_4() { prop_struct3_property_get(UInt32.self, Int16.self, Int64.self) }
                // @Test("S3<UInt32,Int16,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_5() { prop_struct3_property_get(UInt32.self, Int16.self, UInt8.self) }
                // @Test("S3<UInt32,Int16,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_6() { prop_struct3_property_get(UInt32.self, Int16.self, UInt16.self) }
                // @Test("S3<UInt32,Int16,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_7() { prop_struct3_property_get(UInt32.self, Int16.self, UInt32.self) }
                // @Test("S3<UInt32,Int16,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_8() { prop_struct3_property_get(UInt32.self, Int16.self, UInt64.self) }

                // T2 = Int64
                // @Test("S3<UInt32,Int64,Int8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_1() { prop_struct3_property_get(Int32.self, Int64.self, Int8.self) }
                // @Test("S3<UInt32,Int64,Int16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_2() { prop_struct3_property_get(Int32.self, Int64.self, Int16.self) }
                // @Test("S3<UInt32,Int64,Int32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_3() { prop_struct3_property_get(Int32.self, Int64.self, Int32.self) }
                // @Test("S3<UInt32,Int64,Int64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_4() { prop_struct3_property_get(Int32.self, Int64.self, Int64.self) }
                // @Test("S3<UInt32,Int64,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_5() { prop_struct3_property_get(Int32.self, Int64.self, UInt8.self) }
                // @Test("S3<UInt32,Int64,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_6() { prop_struct3_property_get(Int32.self, Int64.self, UInt16.self) }
                // @Test("S3<UInt32,Int64,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_7() { prop_struct3_property_get(Int32.self, Int64.self, UInt32.self) }
                // @Test("S3<UInt32,Int64,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_8() { prop_struct3_property_get(Int32.self, Int64.self, UInt64.self) }
            }

            @Suite("S3<Array<Int32>,T2,T3>") struct S3Int32sTests {
                // T2 = Int16
                // @Test("S3<Array<Int32>,Int16,Int8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_1() { prop_struct3_property_get(Array<Int32>.self, Int16.self, Int8.self) }
                // @Test("S3<Array<Int32>,Int16,Int16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_2() { prop_struct3_property_get(Array<Int32>.self, Int16.self, Int16.self) }
                // @Test("S3<Array<Int32>,Int16,Int32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_3() { prop_struct3_property_get(Array<Int32>.self, Int16.self, Int32.self) }
                // @Test("S3<Array<Int32>,Int16,Int64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_4() { prop_struct3_property_get(Array<Int32>.self, Int16.self, Int64.self) }
                // @Test("S3<Array<Int32>,Int16,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_5() { prop_struct3_property_get(Array<Int32>.self, Int16.self, UInt8.self) }
                // @Test("S3<Array<Int32>,Int16,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_6() { prop_struct3_property_get(Array<Int32>.self, Int16.self, UInt16.self) }
                // @Test("S3<Array<Int32>,Int16,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_7() { prop_struct3_property_get(Array<Int32>.self, Int16.self, UInt32.self) }
                // @Test("S3<Array<Int32>,Int16,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_8() { prop_struct3_property_get(Array<Int32>.self, Int16.self, UInt64.self) }

                // T2 = Int64
                // @Test("S3<Array<Int32>,Int64,Int8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_1() { prop_struct3_property_get(Array<Int32>.self, Int64.self, Int8.self) }
                // @Test("S3<Array<Int32>,Int64,Int16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_2() { prop_struct3_property_get(Array<Int32>.self, Int64.self, Int16.self) }
                // @Test("S3<Array<Int32>,Int64,Int32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_3() { prop_struct3_property_get(Array<Int32>.self, Int64.self, Int32.self) }
                // @Test("S3<Array<Int32>,Int64,Int64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_4() { prop_struct3_property_get(Array<Int32>.self, Int64.self, Int64.self) }
                // @Test("S3<Array<Int32>,Int64,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_5() { prop_struct3_property_get(Array<Int32>.self, Int64.self, UInt8.self) }
                // @Test("S3<Array<Int32>,Int64,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_6() { prop_struct3_property_get(Array<Int32>.self, Int64.self, UInt16.self) }
                // @Test("S3<Array<Int32>,Int64,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_7() { prop_struct3_property_get(Array<Int32>.self, Int64.self, UInt32.self) }
                // @Test("S3<Array<Int32>,Int64,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_8() { prop_struct3_property_get(Array<Int32>.self, Int64.self, UInt64.self) }
            }

            @Suite("S3<Array<Float32>,T2,T3>") struct S3Float32sTests {
                // T2 = Int16
                // @Test("S3<Array<Float32>,Int16,Int8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_1() { prop_struct3_property_get(Array<Float32>.self, Int16.self, Int8.self) }
                // @Test("S3<Array<Float32>,Int16,Int16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_2() { prop_struct3_property_get(Array<Float32>.self, Int16.self, Int16.self) }
                // @Test("S3<Array<Float32>,Int16,Int32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_3() { prop_struct3_property_get(Array<Float32>.self, Int16.self, Int32.self) }
                // @Test("S3<Array<Float32>,Int16,Int64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_4() { prop_struct3_property_get(Array<Float32>.self, Int16.self, Int64.self) }
                // @Test("S3<Array<Float32>,Int16,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_5() { prop_struct3_property_get(Array<Float32>.self, Int16.self, UInt8.self) }
                // @Test("S3<Array<Float32>,Int16,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_6() { prop_struct3_property_get(Array<Float32>.self, Int16.self, UInt16.self) }
                // @Test("S3<Array<Float32>,Int16,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_7() { prop_struct3_property_get(Array<Float32>.self, Int16.self, UInt32.self) }
                // @Test("S3<Array<Float32>,Int16,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i16_8() { prop_struct3_property_get(Array<Float32>.self, Int16.self, UInt64.self) }

                // T2 = Int64
                // @Test("S3<Array<Float32>,Int64,Int8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_1() { prop_struct3_property_get(Array<Float32>.self, Int64.self, Int8.self) }
                // @Test("S3<Array<Float32>,Int64,Int16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_2() { prop_struct3_property_get(Array<Float32>.self, Int64.self, Int16.self) }
                // @Test("S3<Array<Float32>,Int64,Int32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_3() { prop_struct3_property_get(Array<Float32>.self, Int64.self, Int32.self) }
                // @Test("S3<Array<Float32>,Int64,Int64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_4() { prop_struct3_property_get(Array<Float32>.self, Int64.self, Int64.self) }
                // @Test("S3<Array<Float32>,Int64,UInt8>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_5() { prop_struct3_property_get(Array<Float32>.self, Int64.self, UInt8.self) }
                // @Test("S3<Array<Float32>,Int64,UInt16>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_6() { prop_struct3_property_get(Array<Float32>.self, Int64.self, UInt16.self) }
                // @Test("S3<Array<Float32>,Int64,UInt32>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_7() { prop_struct3_property_get(Array<Float32>.self, Int64.self, UInt32.self) }
                // @Test("S3<Array<Float32>,Int64,UInt64>.get", .bug(id: "86b70m272")) func test_struct3_property_get_i64_8() { prop_struct3_property_get(Array<Float32>.self, Int64.self, UInt64.self) }
            }
        }
    }

    @Suite("PropertySetters") struct PropertySetters {
        // structs with 1 member variable
        @Suite("S1") struct S1Tests {
            @Test("S1<UInt>.set") func test_struct1_property_set_1() { prop_struct1_property_set(UInt.self) }
            @Test("S1<UInt8>.set") func test_struct1_property_set_2() { prop_struct1_property_set(UInt8.self) }
            @Test("S1<UInt16>.set") func test_struct1_property_set_3() { prop_struct1_property_set(UInt16.self) }
            @Test("S1<UInt32>.set") func test_struct1_property_set_4() { prop_struct1_property_set(UInt32.self) }
            // @Test("S1<UInt64>.set", .bug(id: "86b70m272")) func test_struct1_property_set5() { prop_struct1_property_set(UInt64.self) }

            // @Test("S1<Int>.set", .bug(id: "86b70m272")) func test_struct1_property_set6() { prop_struct1_property_set(Int.self) }
            // @Test("S1<Int8>.set", .bug(id: "86b70m272")) func test_struct1_property_set7() { prop_struct1_property_set(Int8.self) }
            // @Test("S1<Int16>.set", .bug(id: "86b70m272")) func test_struct1_property_set7() { prop_struct1_property_set(Int16.self) }
            // @Test("S1<Int32>.set", .bug(id: "86b70m272")) func test_struct1_property_set8() { prop_struct1_property_set(Int32.self) }
            // @Test("S1<Int64>.set", .bug(id: "86b70m272")) func test_struct1_property_set9() { prop_struct1_property_set(Int64.self) }

            @Test("S1<Float32>.set", .bug(id: "86b70m272")) func test_struct1_property_set10() { prop_struct1_property_set(Float32.self) }
            @Test("S1<Float64>.set", .bug(id: "86b70m272")) func test_struct1_property_set11() { prop_struct1_property_set(Float64.self) }

            // non-primitive members
            @Test("S1<S2<Int64,Int8>>") func test_struct1_property_set_12() { prop_struct1_property_get(S2<Int64, Int8>.self) }
            // @Test("S1<Array<Int32>>", .bug(id: "86b6vgh48")) func test_struct1_property_set_13() { prop_struct1_property_get(Array<Int32>.self) }
        }

        @Suite("S2") struct S2Tests {
            // T1 = Int8
            @Test("S2<Int8,Int8>.set") func test_struct2_property_set_i8_1() { prop_struct2_property_set(Int8.self, Int8.self) }
            @Test("S2<Int8,Int16>.set") func test_struct2_property_set_i8_2() { prop_struct2_property_set(Int8.self, Int16.self) }
            @Test("S2<Int8,Int32>.set") func test_struct2_property_set_i8_3() { prop_struct2_property_set(Int8.self, Int32.self) }
            @Test("S2<Int8,Int64>.set") func test_struct2_property_set_i8_4() { prop_struct2_property_set(Int8.self, Int64.self) }
            // @Test("S2<Int8,UInt8>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i8_5() { prop_struct2_property_set(Int8.self, UInt8.self) }
            // @Test("S2<Int8,UInt16>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i8_6() { prop_struct2_property_set(Int8.self, UInt16.self) }
            // @Test("S2<Int8,UInt32>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i8_7() { prop_struct2_property_set(Int8.self, UInt32.self) }
            // @Test("S2<Int8,UInt64>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i8_8() { prop_struct2_property_set(Int8.self, UInt64.self) }

            // T1 = Int32
            @Test("S2<Int32,Int8>.set") func test_struct2_property_set_i32_1() { prop_struct2_property_set(Int32.self, Int8.self) }
            @Test("S2<Int32,Int16>.set") func test_struct2_property_set_i32_2() { prop_struct2_property_set(Int32.self, Int16.self) }
            @Test("S2<Int32,Int32>.set") func test_struct2_property_set_i32_3() { prop_struct2_property_set(Int32.self, Int32.self) }
            @Test("S2<Int32,Int64>.set") func test_struct2_property_set_i32_4() { prop_struct2_property_set(Int32.self, Int64.self) }
            // @Test("S2<Int32,UInt8>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i32_5() { prop_struct2_property_set(Int32.self, UInt8.self) }
            // @Test("S2<Int32,UInt16>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i32_6() { prop_struct2_property_set(Int32.self, UInt16.self) }
            // @Test("S2<Int32,UInt32>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i32_7() { prop_struct2_property_set(Int32.self, UInt32.self) }
            // @Test("S2<Int32,UInt64>.set", .bug(id: "86b70m272")) func test_struct2_property_set_i32_8() { prop_struct2_property_set(Int32.self, UInt64.self) }

            // T1 = Float32
            @Test("S2<Float32,Int8>.set") func test_struct2_property_set_f32_1() { prop_struct2_property_set(Float32.self, Int8.self) }
            @Test("S2<Float32,Int16>.set") func test_struct2_property_set_f32_2() { prop_struct2_property_set(Float32.self, Int16.self) }
            @Test("S2<Float32,Int32>.set") func test_struct2_property_set_f32_3() { prop_struct2_property_set(Float32.self, Int32.self) }
            @Test("S2<Float32,Int64>.set") func test_struct2_property_set_f32_4() { prop_struct2_property_set(Float32.self, Int64.self) }
            // @Test("S2<Float32,UInt8>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f32_5() { prop_struct2_property_set(Float32.self, UInt8.self) }
            // @Test("S2<Float32,UInt16>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f32_6() { prop_struct2_property_set(Float32.self, UInt16.self) }
            // @Test("S2<Float32,UInt32>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f32_7() { prop_struct2_property_set(Float32.self, UInt32.self) }
            // @Test("S2<Float32,UInt64>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f32_8() { prop_struct2_property_set(Float32.self, UInt64.self) }

            // T1 = Float64
            @Test("S2<Float64,Int8>.set") func test_struct2_property_set_f64_1() { prop_struct2_property_set(Float64.self, Int8.self) }
            @Test("S2<Float64,Int16>.set") func test_struct2_property_set_f64_2() { prop_struct2_property_set(Float64.self, Int16.self) }
            @Test("S2<Float64,Int32>.set") func test_struct2_property_set_f64_3() { prop_struct2_property_set(Float64.self, Int32.self) }
            @Test("S2<Float64,Int64>.set") func test_struct2_property_set_f64_4() { prop_struct2_property_set(Float64.self, Int64.self) }
            // @Test("S2<Float64,UInt8>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64_5() { prop_struct2_property_set(Float64.self, UInt8.self) }
            // @Test("S2<Float64,UInt16>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64_6() { prop_struct2_property_set(Float64.self, UInt16.self) }
            // @Test("S2<Float64,UInt32>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64_7() { prop_struct2_property_set(Float64.self, UInt32.self) }
            // @Test("S2<Float64,UInt64>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64_8() { prop_struct2_property_set(Float64.self, UInt64.self) }

            // T1 = Array<Float64>
            // @Test("S2<Array<Float64>,Int8>.set", .bug(id: "86b6vgh48")) func test_struct2_property_set_f64s_1() { prop_struct2_property_set(Array<Float64>.self, Int8.self) }
            // @Test("S2<Array<Float64>,Int16>.set", .bug(id: "86b6vgh48")) func test_struct2_property_set_f64s_2() { prop_struct2_property_set(Array<Float64>.self, Int16.self) }
            // @Test("S2<Array<Float64>,Int32>.set", .bug(id: "86b6vgh48")) func test_struct2_property_set_f64s_3() { prop_struct2_property_set(Array<Float64>.self, Int32.self) }
            // @Test("S2<Array<Float64>,Int64>.set", .bug(id: "86b6vgh48")) func test_struct2_property_set_f64s_4() { prop_struct2_property_set(Array<Float64>.self, Int64.self) }
            // XXX: the below tests has two bugs, once the compile-time crash is fixed, most likely the runtime crash 86b6vgh48 will occur next
            // @Test("S2<Array<Float64>,UInt8>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64s_5() { prop_struct2_property_set(Array<Float64>.self, UInt8.self) }
            // @Test("S2<Array<Float64>,UInt16>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64s_6() { }
            // @Test("S2<Array<Float64>,UInt32>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64s_7() { }
            // @Test("S2<Array<Float64>,UInt64>.set", .bug(id: "86b70m272")) func test_struct2_property_set_f64s_8() { }
        }

        @Suite("S3") struct S3Tests {
            @Suite("S3<Int8,T2,T3>") struct S3Int8Tests {
                // T2 = Int64
                // @Test("S3<Int8,Int64,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_1() { prop_struct3_property_set(Int8.self, Int64.self, Int.self) }
                // @Test("S3<Int8,Int64,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_2() { prop_struct3_property_set(Int8.self, Int64.self, Int8.self) }
                @Test("S3<Int8,Int64,Int16>.set") func test_struct3_property_set_i64_3() { prop_struct3_property_set(Int8.self, Int64.self, Int16.self) }
                @Test("S3<Int8,Int64,Int32>.set") func test_struct3_property_set_i64_4() { prop_struct3_property_set(Int8.self, Int64.self, Int32.self) }
                @Test("S3<Int8,Int64,Int64>.set") func test_struct3_property_set_i64_5() { prop_struct3_property_set(Int8.self, Int64.self, Int64.self) }

                // T2 = Int32
                // @Test("S3<Int8,Int32,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_1() { prop_struct3_property_set(Int8.self, Int32.self, Int.self) }
                // @Test("S3<Int8,Int32,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_2() { prop_struct3_property_set(Int8.self, Int32.self, Int8.self) }
                @Test("S3<Int8,Int32,Int16>.set") func test_struct3_property_set_i32_3() { prop_struct3_property_set(Int8.self, Int32.self, Int16.self) }
                @Test("S3<Int8,Int32,Int32>.set") func test_struct3_property_set_i32_4() { prop_struct3_property_set(Int8.self, Int32.self, Int32.self) }
                @Test("S3<Int8,Int32,Int64>.set") func test_struct3_property_set_i32_5() { prop_struct3_property_set(Int8.self, Int32.self, Int64.self) }
            }

            @Suite("S3<Int32,T2,T3>") struct S3Int32Tests {
                // T2 = Int64
                // @Test("S3<Int32,Int64,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_1() { prop_struct3_property_set(Int32.self, Int64.self, Int.self) }
                // @Test("S3<Int32,Int64,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_2() { prop_struct3_property_set(Int32.self, Int64.self, Int8.self) }
                @Test("S3<Int32,Int64,Int16>.set") func test_struct3_property_set_i64_3() { prop_struct3_property_set(Int32.self, Int64.self, Int16.self) }
                @Test("S3<Int32,Int64,Int32>.set") func test_struct3_property_set_i64_4() { prop_struct3_property_set(Int32.self, Int64.self, Int32.self) }
                @Test("S3<Int32,Int64,Int64>.set") func test_struct3_property_set_i64_5() { prop_struct3_property_set(Int32.self, Int64.self, Int64.self) }

                // T2 = Int32
                // @Test("S3<Int32,Int32,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_1() { prop_struct3_property_set(Int32.self, Int32.self, Int.self) }
                // @Test("S3<Int32,Int32,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_2() { prop_struct3_property_set(Int32.self, Int32.self, Int8.self) }
                @Test("S3<Int32,Int32,Int16>.set") func test_struct3_property_set_i32_3() { prop_struct3_property_set(Int32.self, Int32.self, Int16.self) }
                @Test("S3<Int32,Int32,Int32>.set") func test_struct3_property_set_i32_4() { prop_struct3_property_set(Int32.self, Int32.self, Int32.self) }
                @Test("S3<Int32,Int32,Int64>.set") func test_struct3_property_set_i32_5() { prop_struct3_property_set(Int32.self, Int32.self, Int64.self) }
            }

            @Suite("S3<Float32,T2,T3>") struct S3Float32Tests {
                // T2 = Int64
                // @Test("S3<Float32,Int64,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_1() { prop_struct3_property_set(Float32.self, Int64.self, Int.self) }
                // @Test("S3<Float32,Int64,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_2() { prop_struct3_property_set(Float32.self, Int64.self, Int8.self) }
                @Test("S3<Float32,Int64,Int16>.set") func test_struct3_property_set_i64_3() { prop_struct3_property_set(Float32.self, Int64.self, Int16.self) }
                @Test("S3<Float32,Int64,Int32>.set") func test_struct3_property_set_i64_4() { prop_struct3_property_set(Float32.self, Int64.self, Int32.self) }
                @Test("S3<Float32,Int64,Int64>.set") func test_struct3_property_set_i64_5() { prop_struct3_property_set(Float32.self, Int64.self, Int64.self) }

                // T2 = Int32
                // @Test("S3<Float32,Int32,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_1() { prop_struct3_property_set(Float32.self, Int32.self, Int.self) }
                // @Test("S3<Float32,Int32,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_2() { prop_struct3_property_set(Float32.self, Int32.self, Int8.self) }
                @Test("S3<Float32,Int32,Int16>.set") func test_struct3_property_set_i32_3() { prop_struct3_property_set(Float32.self, Int32.self, Int16.self) }
                @Test("S3<Float32,Int32,Int32>.set") func test_struct3_property_set_i32_4() { prop_struct3_property_set(Float32.self, Int32.self, Int32.self) }
                @Test("S3<Float32,Int32,Int64>.set") func test_struct3_property_set_i32_5() { prop_struct3_property_set(Float32.self, Int32.self, Int64.self) }
            }

            @Suite("S3<Float64,T2,T3>") struct S3Float64Tests {
                // T2 = Int64
                // @Test("S3<Float64,Int64,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_1() { prop_struct3_property_set(Float64.self, Int64.self, Int.self) }
                // @Test("S3<Float64,Int64,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i64_2() { prop_struct3_property_set(Float64.self, Int64.self, Int8.self) }
                @Test("S3<Float64,Int64,Int16>.set") func test_struct3_property_set_i64_3() { prop_struct3_property_set(Float64.self, Int64.self, Int16.self) }
                @Test("S3<Float64,Int64,Int32>.set") func test_struct3_property_set_i64_4() { prop_struct3_property_set(Float64.self, Int64.self, Int32.self) }
                @Test("S3<Float64,Int64,Int64>.set") func test_struct3_property_set_i64_5() { prop_struct3_property_set(Float64.self, Int64.self, Int64.self) }

                // T2 = Int32
                // @Test("S3<Float64,Int32,Int>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_1() { prop_struct3_property_set(Float64.self, Int32.self, Int.self) }
                // @Test("S3<Float64,Int32,Int8>.set", .bug(id: "86b70m272")) func test_struct3_property_set_i32_2() { prop_struct3_property_set(Float64.self, Int32.self, Int8.self) }
                @Test("S3<Float64,Int32,Int16>.set") func test_struct3_property_set_i32_3() { prop_struct3_property_set(Float64.self, Int32.self, Int16.self) }
                @Test("S3<Float64,Int32,Int32>.set") func test_struct3_property_set_i32_4() { prop_struct3_property_set(Float64.self, Int32.self, Int32.self) }
                @Test("S3<Float64,Int32,Int64>.set") func test_struct3_property_set_i32_5() { prop_struct3_property_set(Float64.self, Int32.self, Int64.self) }
            }
        }
    }

    // Some crashers were encountered
    @Suite("DefaultParameterValues") struct DefaultParameterValues {
        @Suite("S1d") struct S1dTests {
            @Test("S1d<Int>.default_init") func test_struct1_default_init_1() { prop_struct1_default_init(Int.self) }
            @Test("S1d<Int8>.default_init") func test_struct1_default_init_2() { prop_struct1_default_init(Int8.self) }
            @Test("S1d<Int16>.default_init") func test_struct1_default_init_3() { prop_struct1_default_init(Int16.self) }
            @Test("S1d<Int32>.default_init") func test_struct1_default_init_4() { prop_struct1_default_init(Int32.self) }
            // @Test("S1d<Int64>.default_init", .bug(id: "86b70m272")) func test_struct1_default_init_5() { prop_struct1_default_init(Int64.self) }
            // @Test("S1d<UInt>.default_init", .bug(id: "86b70m272")) func test_struct1_default_init_6() { prop_struct1_default_init(UInt.self) }
            // @Test("S1d<UInt8>.default_init", .bug(id: "86b70m272")) func test_struct1_default_init_7() { prop_struct1_default_init(UInt8.self) }
            // @Test("S1d<UInt16>.default_init", .bug(id: "86b70m272")) func test_struct1_default_init_8() { prop_struct1_default_init(UInt16.self) }
            // @Test("S1d<UInt32>.default_init", .bug(id: "86b70m272")) func test_struct1_default_init_9() { prop_struct1_default_init(UInt32.self) }
            // @Test("S1d<UInt64>.default_init", .bug(id: "86b70m272")) func test_struct1_default_init_10() { prop_struct1_default_init(UInt64.self) }
            @Test("S1d<Float64>.default_init") func test_struct1_default_init_11() { prop_struct1_default_init(Float64.self) }
            @Test("S1d<Float32>.default_init") func test_struct1_default_init_12() { prop_struct1_default_init(Float32.self) }
        }

        @Suite("S2d") struct S2dTests {
            // T1 = Int8
            @Test("S2d<Int8,Int8>.default_init") func test_struct2_default_init_i8_1() { prop_struct2_default_init(Int8.self, Int8.self) }
            @Test("S2d<Int8,Int16>.default_init") func test_struct2_default_init_i8_2() { prop_struct2_default_init(Int8.self, Int16.self) }
            @Test("S2d<Int8,Int32>.default_init") func test_struct2_default_init_i8_3() { prop_struct2_default_init(Int8.self, Int32.self) }
            @Test("S2d<Int8,Int64>.default_init") func test_struct2_default_init_i8_4() { prop_struct2_default_init(Int8.self, Int64.self) }
            // @Test("S2d<Int8,Int>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i8_5() { prop_struct2_default_init(Int8.self, Int.self) }
            // @Test("S2d<Int8,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i8_6() { prop_struct2_default_init(Int8.self, UInt8.self) }
            // @Test("S2d<Int8,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i8_7() { prop_struct2_default_init(Int8.self, UInt16.self) }
            // @Test("S2d<Int8,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i8_8() { prop_struct2_default_init(Int8.self, UInt32.self) }
            // @Test("S2d<Int8,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i8_9() { prop_struct2_default_init(Int8.self, UInt64.self) }
            // @Test("S2d<Int8,UInt>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i8_10() { prop_struct2_default_init(Int8.self, UInt.self) }
            @Test("S2d<Int8,Float32>.default_init") func test_struct2_default_init_i8_11() { prop_struct2_default_init(Int8.self, Float32.self) }
            @Test("S2d<Int8,Float64>.default_init") func test_struct2_default_init_i8_12() { prop_struct2_default_init(Int8.self, Float64.self) }

            // T1 = Int16
            @Test("S2d<Int16,Int8>.default_init") func test_struct2_default_init_i16_1() { prop_struct2_default_init(Int16.self, Int8.self) }
            @Test("S2d<Int16,Int16>.default_init") func test_struct2_default_init_i16_2() { prop_struct2_default_init(Int16.self, Int16.self) }
            @Test("S2d<Int16,Int32>.default_init") func test_struct2_default_init_i16_3() { prop_struct2_default_init(Int16.self, Int32.self) }
            @Test("S2d<Int16,Int64>.default_init") func test_struct2_default_init_i16_4() { prop_struct2_default_init(Int16.self, Int64.self) }
            // @Test("S2d<Int16,Int>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i16_5() { prop_struct2_default_init(Int16.self, Int.self) }
            // @Test("S2d<Int16,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i16_6() { prop_struct2_default_init(Int16.self, UInt8.self) }
            // @Test("S2d<Int16,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i16_7() { prop_struct2_default_init(Int16.self, UInt16.self) }
            // @Test("S2d<Int16,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i16_8() { prop_struct2_default_init(Int16.self, UInt32.self) }
            // @Test("S2d<Int16,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i16_9() { prop_struct2_default_init(Int16.self, UInt64.self) }
            // @Test("S2d<Int16,UInt>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i16_10() { prop_struct2_default_init(Int16.self, UInt.self) }

            // T1 = Int
            // @Test("S2d<Int,Int8>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i_1() { prop_struct2_default_init(Int.self, Int8.self) }
            // @Test("S2d<Int,Int16>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i_2() { prop_struct2_default_init(Int.self, Int16.self) }
            // @Test("S2d<Int,Int32>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i_3() { prop_struct2_default_init(Int.self, Int32.self) }
            // @Test("S2d<Int,Int64>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_i_4() { prop_struct2_default_init(Int.self, Int64.self) }

            // T1 = UInt
            // XXX: why does this not crash with unsigned ints?
            @Test("S2d<UInt,Int8>.default_init") func test_struct2_default_init_u_1() { prop_struct2_default_init(UInt.self, Int8.self) }
            @Test("S2d<UInt,Int16>.default_init") func test_struct2_default_init_u_2() { prop_struct2_default_init(UInt.self, Int16.self) }
            @Test("S2d<UInt,Int32>.default_init") func test_struct2_default_init_u_3() { prop_struct2_default_init(UInt.self, Int32.self) }
            @Test("S2d<UInt,Int64>.default_init") func test_struct2_default_init_u_4() { prop_struct2_default_init(UInt.self, Int64.self) }
            // @Test("S2d<UInt,Int>.default_init") func test_struct2_default_init_u_5() { prop_struct2_default_init(UInt.self, Int.self) }
            // @Test("S2d<UInt,UInt8>.default_init") func test_struct2_default_init_u_6() { prop_struct2_default_init(UInt.self, UInt8.self) }
            // @Test("S2d<UInt,UInt16>.default_init") func test_struct2_default_init_u_7() { prop_struct2_default_init(UInt.self, UInt16.self) }
            // @Test("S2d<UInt,UInt32>.default_init") func test_struct2_default_init_u_8() { prop_struct2_default_init(UInt.self, UInt32.self) }
            // @Test("S2d<UInt,UInt64>.default_init") func test_struct2_default_init_u_9() { prop_struct2_default_init(UInt.self, UInt64.self) }
            // @Test("S2d<UInt,UInt>.default_init") func test_struct2_default_init_u_10() { prop_struct2_default_init(UInt.self, UInt.self) }

            // T1 = UInt8
            // @Test("S2d<UInt8,Int8>.default_init") func test_struct2_default_init_u8_1() { prop_struct2_default_init(UInt8.self, Int8.self) }
            // @Test("S2d<UInt8,Int16>.default_init") func test_struct2_default_init_u8_2() { prop_struct2_default_init(UInt8.self, Int16.self) }
            // @Test("S2d<UInt8,Int32>.default_init") func test_struct2_default_init_u8_3() { prop_struct2_default_init(UInt8.self, Int32.self) }
            // @Test("S2d<UInt8,Int64>.default_init") func test_struct2_default_init_u8_4() { prop_struct2_default_init(UInt8.self, Int64.self) }

            // T1 = Float32
            @Test("S2d<Float32,Int8>.default_init") func test_struct2_default_init_f32_1() { prop_struct2_default_init(Float32.self, Int8.self) }
            @Test("S2d<Float32,Int16>.default_init") func test_struct2_default_init_f32_2() { prop_struct2_default_init(Float32.self, Int16.self) }
            @Test("S2d<Float32,Int32>.default_init") func test_struct2_default_init_f32_3() { prop_struct2_default_init(Float32.self, Int32.self) }
            @Test("S2d<Float32,Int64>.default_init") func test_struct2_default_init_f32_4() { prop_struct2_default_init(Float32.self, Int64.self) }
            // @Test("S2d<Float32,Int>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_f32_5() { prop_struct2_default_init(Float32.self, Int.self) }
            // @Test("S2d<Float32,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_f32_6() { prop_struct2_default_init(Float32.self, UInt8.self) }
            // @Test("S2d<Float32,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_f32_7() { prop_struct2_default_init(Float32.self, UInt16.self) }
            // @Test("S2d<Float32,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_f32_8() { prop_struct2_default_init(Float32.self, UInt32.self) }
            // @Test("S2d<Float32,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_f32_9() { prop_struct2_default_init(Float32.self, UInt64.self) }
            // @Test("S2d<Float32,UInt>.default_init", .bug(id: "86b70m272")) func test_struct2_default_init_f32_10() { prop_struct2_default_init(Float32.self, UInt.self) }
        }

        @Suite("S3d") struct S3dTests {
            @Suite("S3d<UInt8,T2,T3>") struct S3dUInt8Tests {
                // T2 = Int32
                // @Test("S3d<UInt8,Int32,Int8>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_1() { prop_struct3_default_init(UInt8.self, Int32.self, Int8.self) }
                // @Test("S3d<UInt8,Int32,Int16>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_2() { prop_struct3_default_init(UInt8.self, Int32.self, Int16.self) }
                // @Test("S3d<UInt8,Int32,Int32>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_3() { prop_struct3_default_init(UInt8.self, Int32.self, Int32.self) }
                // @Test("S3d<UInt8,Int32,Int64>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_4() { prop_struct3_default_init(UInt8.self, Int32.self, Int64.self) }
                // @Test("S3d<UInt8,Int32,Int>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_5() { prop_struct3_default_init(UInt8.self, Int32.self, Int.self) }
                // @Test("S3d<UInt8,Int32,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_6() { prop_struct3_default_init(UInt8.self, Int32.self, UInt8.self) }
                // @Test("S3d<UInt8,Int32,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_7() { prop_struct3_default_init(UInt8.self, Int32.self, UInt16.self) }
                // @Test("S3d<UInt8,Int32,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_8() { prop_struct3_default_init(UInt8.self, Int32.self, UInt32.self) }
                // @Test("S3d<UInt8,Int32,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_9() { prop_struct3_default_init(UInt8.self, Int32.self, UInt64.self) }
                // @Test("S3d<UInt8,Int32,UInt>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_10() { prop_struct3_default_init(UInt8.self, Int32.self, UInt.self) }
                // @Test("S3d<UInt8,Int32,Float32>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i32_11() { prop_struct3_default_init(UInt8.self, Int32.self, Float32.self) }
                // @Test("S3d<UInt8,Int32,Float64>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i32_12() { prop_struct3_default_init(UInt8.self, Int32.self, Float32.self) }

                // T2 = Int64
                // @Test("S3d<UInt8,Int64,Int8>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i64_1() { prop_struct3_default_init(UInt8.self, Int64.self, Int8.self) }
                // @Test("S3d<UInt8,Int64,Int16>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i64_2() { prop_struct3_default_init(UInt8.self, Int64.self, Int16.self) }
                // @Test("S3d<UInt8,Int64,Int32>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i64_3() { prop_struct3_default_init(UInt8.self, Int64.self, Int32.self) }
                // @Test("S3d<UInt8,Int64,Int64>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i64_4() { prop_struct3_default_init(UInt8.self, Int64.self, Int64.self) }
                // @Test("S3d<UInt8,Int64,Int>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_5() { prop_struct3_default_init(UInt8.self, Int64.self, Int.self) }
                // @Test("S3d<UInt8,Int64,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_6() { prop_struct3_default_init(UInt8.self, Int64.self, UInt8.self) }
                // @Test("S3d<UInt8,Int64,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_7() { prop_struct3_default_init(UInt8.self, Int64.self, UInt16.self) }
                // @Test("S3d<UInt8,Int64,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_8() { prop_struct3_default_init(UInt8.self, Int64.self, UInt32.self) }
                // @Test("S3d<UInt8,Int64,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_9() { prop_struct3_default_init(UInt8.self, Int64.self, UInt64.self) }
                // @Test("S3d<UInt8,Int64,UInt>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_10() { prop_struct3_default_init(UInt8.self, Int64.self, UInt.self) }
                // @Test("S3d<UInt8,Int64,Float32>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i64_11() { prop_struct3_default_init(UInt8.self, Int64.self, Float32.self) }
                // @Test("S3d<UInt8,Int64,Float64>.default_init", .bug(id: "86b70m272") func test_struct3_default_init_i64_12() { prop_struct3_default_init(UInt8.self, Int64.self, Float32.self) }
            }

            @Suite("S3d<UInt,T2,T3>") struct S3dUIntTests {
                // T2 = Int32
                @Test("S3d<UInt,Int32,Int8>.default_init") func test_struct3_default_init_i32_1() { prop_struct3_default_init(UInt.self, Int32.self, Int8.self) }
                @Test("S3d<UInt,Int32,Int16>.default_init") func test_struct3_default_init_i32_2() { prop_struct3_default_init(UInt.self, Int32.self, Int16.self) }
                @Test("S3d<UInt,Int32,Int32>.default_init") func test_struct3_default_init_i32_3() { prop_struct3_default_init(UInt.self, Int32.self, Int32.self) }
                @Test("S3d<UInt,Int32,Int64>.default_init") func test_struct3_default_init_i32_4() { prop_struct3_default_init(UInt.self, Int32.self, Int64.self) }
                // @Test("S3d<UInt,Int32,Int>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_5() { prop_struct3_default_init(UInt.self, Int32.self, Int.self) }
                // @Test("S3d<UInt,Int32,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_6() { prop_struct3_default_init(UInt.self, Int32.self, UInt8.self) }
                // @Test("S3d<UInt,Int32,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_7() { prop_struct3_default_init(UInt.self, Int32.self, UInt16.self) }
                // @Test("S3d<UInt,Int32,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_8() { prop_struct3_default_init(UInt.self, Int32.self, UInt32.self) }
                // @Test("S3d<UInt,Int32,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_9() { prop_struct3_default_init(UInt.self, Int32.self, UInt64.self) }
                // @Test("S3d<UInt,Int32,UInt>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_10() { prop_struct3_default_init(UInt.self, Int32.self, UInt.self) }
                @Test("S3d<UInt,Int32,Float32>.default_init") func test_struct3_default_init_i32_11() { prop_struct3_default_init(UInt.self, Int32.self, Float32.self) }
                @Test("S3d<UInt,Int32,Float64>.default_init") func test_struct3_default_init_i32_12() { prop_struct3_default_init(UInt.self, Int32.self, Float32.self) }

                // T2 = Int64
                @Test("S3d<UInt,Int64,Int8>.default_init") func test_struct3_default_init_i64_1() { prop_struct3_default_init(UInt.self, Int64.self, Int8.self) }
                @Test("S3d<UInt,Int64,Int16>.default_init") func test_struct3_default_init_i64_2() { prop_struct3_default_init(UInt.self, Int64.self, Int16.self) }
                @Test("S3d<UInt,Int64,Int32>.default_init") func test_struct3_default_init_i64_3() { prop_struct3_default_init(UInt.self, Int64.self, Int32.self) }
                @Test("S3d<UInt,Int64,Int64>.default_init") func test_struct3_default_init_i64_4() { prop_struct3_default_init(UInt.self, Int64.self, Int64.self) }
                // @Test("S3d<UInt,Int64,Int>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_5() { prop_struct3_default_init(UInt.self, Int64.self, Int.self) }
                // @Test("S3d<UInt,Int64,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_6() { prop_struct3_default_init(UInt.self, Int64.self, UInt8.self) }
                // @Test("S3d<UInt,Int64,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_7() { prop_struct3_default_init(UInt.self, Int64.self, UInt16.self) }
                // @Test("S3d<UInt,Int64,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_8() { prop_struct3_default_init(UInt.self, Int64.self, UInt32.self) }
                // @Test("S3d<UInt,Int64,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_9() { prop_struct3_default_init(UInt.self, Int64.self, UInt64.self) }
                // @Test("S3d<UInt,Int64,UInt>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_10() { prop_struct3_default_init(UInt.self, Int64.self, UInt.self) }
                @Test("S3d<UInt,Int64,Float32>.default_init") func test_struct3_default_init_i64_11() { prop_struct3_default_init(UInt.self, Int64.self, Float32.self) }
                @Test("S3d<UInt,Int64,Float64>.default_init") func test_struct3_default_init_i64_12() { prop_struct3_default_init(UInt.self, Int64.self, Float32.self) }
            }

            @Suite("S3d<Int8,T2,T3>") struct S3dInt8Tests {
                // T2 = Int32
                @Test("S3d<Int8,Int32,Int8>.default_init") func test_struct3_default_init_i32_1() { prop_struct3_default_init(Int8.self, Int32.self, Int8.self) }
                @Test("S3d<Int8,Int32,Int16>.default_init") func test_struct3_default_init_i32_2() { prop_struct3_default_init(Int8.self, Int32.self, Int16.self) }
                @Test("S3d<Int8,Int32,Int32>.default_init") func test_struct3_default_init_i32_3() { prop_struct3_default_init(Int8.self, Int32.self, Int32.self) }
                @Test("S3d<Int8,Int32,Int64>.default_init") func test_struct3_default_init_i32_4() { prop_struct3_default_init(Int8.self, Int32.self, Int64.self) }
                // @Test("S3d<Int8,Int32,Int>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_5() { prop_struct3_default_init(Int8.self, Int32.self, Int.self) }
                // @Test("S3d<Int8,Int32,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_6() { prop_struct3_default_init(Int8.self, Int32.self, UInt8.self) }
                // @Test("S3d<Int8,Int32,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_7() { prop_struct3_default_init(Int8.self, Int32.self, UInt16.self) }
                // @Test("S3d<Int8,Int32,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_8() { prop_struct3_default_init(Int8.self, Int32.self, UInt32.self) }
                // @Test("S3d<Int8,Int32,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_9() { prop_struct3_default_init(Int8.self, Int32.self, UInt64.self) }
                // @Test("S3d<Int8,Int32,UInt>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i32_10() { prop_struct3_default_init(Int8.self, Int32.self, UInt.self) }
                @Test("S3d<Int8,Int32,Float32>.default_init") func test_struct3_default_init_i32_11() { prop_struct3_default_init(Int8.self, Int32.self, Float32.self) }
                @Test("S3d<Int8,Int32,Float64>.default_init") func test_struct3_default_init_i32_12() { prop_struct3_default_init(Int8.self, Int32.self, Float32.self) }

                // T2 = Int64
                @Test("S3d<Int8,Int64,Int8>.default_init") func test_struct3_default_init_i64_1() { prop_struct3_default_init(Int8.self, Int64.self, Int8.self) }
                @Test("S3d<Int8,Int64,Int16>.default_init") func test_struct3_default_init_i64_2() { prop_struct3_default_init(Int8.self, Int64.self, Int16.self) }
                @Test("S3d<Int8,Int64,Int32>.default_init") func test_struct3_default_init_i64_3() { prop_struct3_default_init(Int8.self, Int64.self, Int32.self) }
                @Test("S3d<Int8,Int64,Int64>.default_init") func test_struct3_default_init_i64_4() { prop_struct3_default_init(Int8.self, Int64.self, Int64.self) }
                // @Test("S3d<Int8,Int64,Int>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_5() { prop_struct3_default_init(Int8.self, Int64.self, Int.self) }
                // @Test("S3d<Int8,Int64,UInt8>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_6() { prop_struct3_default_init(Int8.self, Int64.self, UInt8.self) }
                // @Test("S3d<Int8,Int64,UInt16>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_7() { prop_struct3_default_init(Int8.self, Int64.self, UInt16.self) }
                // @Test("S3d<Int8,Int64,UInt32>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_8() { prop_struct3_default_init(Int8.self, Int64.self, UInt32.self) }
                // @Test("S3d<Int8,Int64,UInt64>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_9() { prop_struct3_default_init(Int8.self, Int64.self, UInt64.self) }
                // @Test("S3d<Int8,Int64,UInt>.default_init", .bug(id: "86b70m272")) func test_struct3_default_init_i64_10() { prop_struct3_default_init(Int8.self, Int64.self, UInt.self) }
                @Test("S3d<Int8,Int64,Float32>.default_init") func test_struct3_default_init_i64_11() { prop_struct3_default_init(Int8.self, Int64.self, Float32.self) }
                @Test("S3d<Int8,Int64,Float64>.default_init") func test_struct3_default_init_i64_12() { prop_struct3_default_init(Int8.self, Int64.self, Float32.self) }
            }
        }
    }
}

// swiftlint:enable type_body_length

struct S1<T: Arbitrary & Equatable>: Arbitrary & Equatable {
    var member: T

    static var arbitrary: Gen<Self> {
        T.arbitrary.map { Self(member: $0) }
    }
}

private func prop_struct1_property_get<T: Arbitrary & Equatable>(_: T.Type) {
    func s1_property_get(_ x: S1<T>) -> T {
        x.member
    }
    property(String(describing: S1<T>.self) + ".property_get") <-
      forAllNoShrink([S1].arbitrary) { (xs: [S1]) in
        let expected = xs.map(s1_property_get)
        let actual = map(xs, s1_property_get)
        return try? #require(expected == actual)
      }
}

private func prop_struct1_property_set<T: Arbitrary & Equatable>(_: T.Type) {
    func s1_property_set(_ x: S1<T>, _ member: T) -> S1<T> {
        var y = x
        y.member = member
        return y
    }
    property(String(describing: S1<T>.self) + ".property_set") <-
      forAllNoShrink([S1<T>].arbitrary, [T].arbitrary) { (xs: [S1<T>], vs: [T]) in
        let expected = zip(xs, vs).map { x, member in s1_property_set(x, member) }
        let actual = zipWith(xs, vs, s1_property_set)
        return try? #require(expected == actual)
      }
}

private func prop_struct1_property_set_inout<T: Arbitrary & Equatable>(_: T.Type) {
    func s1_property_set_inout(_ x: inout S1<T>, _ member: T) {
        x.member = member
    }
    func s1_property_set(_ x: S1<T>, _ member: T) -> S1<T> {
        var x = x
        s1_property_set_inout(&x, member)
        return x
    }
    property(String(describing: S1<T>.self) + ".property_set_inout") <-
      forAllNoShrink([S1<T>].arbitrary, [T].arbitrary) { (xs: [S1<T>], vs: [T]) in
        let expected = zip(xs, vs).map { x, member in s1_property_set(x, member) }
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        try parallel_for(iterations: min(xs.count, vs.count)) { i in
          s1_property_set_inout(&actual[i], vs[i])
        }.sync()
        return try? #require(expected == actual)
      }
}

struct S2<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>: Arbitrary, Equatable {
    var member1: T1
    var member2: T2

    static var arbitrary: Gen<Self> {
        Gen<Self>.compose { composer in
            Self(
                member1: composer.generate(),
                member2: composer.generate()
            )
        }
    }
}

private func prop_struct2_property_get<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_: T1.Type, _: T2.Type) {
    func s2_property_get1(_ x: S2<T1, T2>) -> T1 {
        x.member1
    }
    func s2_property_get2(_ x: S2<T1, T2>) -> T2 {
        x.member2
    }
    property(String(describing: S2<T1, T2>.self) + ".property_get1") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in
        let expected = xs.map(s2_property_get1)
        let actual = map(xs, s2_property_get1)
        return try? #require(expected == actual)
      }

    property(String(describing: S2<T1, T2>.self) + ".property_get2") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in
        let expected = xs.map(s2_property_get2)
        let actual = map(xs, s2_property_get2)
        return try? #require(expected == actual)
      }
}

private func prop_struct2_property_set<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_: T1.Type, _: T2.Type) {
    func s2_property_set(_ x: S2<T1, T2>, _ member1: T1, _ member2: T2) -> S2<T1, T2> {
        var x = x
        x.member1 = member1
        x.member2 = member2
        return x
    }

    property(String(describing: S2<T1, T2>.self) + "property_get") <-
      forAllNoShrink([S2<T1, T2>].arbitrary, T1.arbitrary, T2.arbitrary) { (xs: [S2<T1, T2>], member1: T1, member2: T2) in
        let expected = xs.map { s2_property_set($0, member1, member2) }
        let actual = map(xs) { s2_property_set($0, member1, member2) }
        return try? #require(expected == actual)
      }
}

private func prop_struct2_property_set_inout<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_: T1.Type, _: T2.Type) {
    func s2_property_set_inout(_ x: inout S2<T1, T2>, _ member1: T1, _ member2: T2) {
        x.member1 = member1
        x.member2 = member2
    }

    func s2_property_set(_ x: S2<T1, T2>, _ member1: T1, _ member2: T2) -> S2<T1, T2> {
        var x = x
        s2_property_set_inout(&x, member1, member2)
        return x
    }

    property(String(describing: S2<T1, T2>.self) + ".property_set_inout") <-
      forAllNoShrink([S2<T1, T2>].arbitrary, T1.arbitrary, T2.arbitrary) { (xs: [S2<T1, T2>], member1: T1, member2: T2) in
        let expected = xs.map { s2_property_set($0, member1, member2) }
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        try parallel_for(iterations: xs.count) { i in
            s2_property_set_inout(&actual[i], member1, member2)
        }.sync()
        return try? #require(expected == actual)
      }
}

struct S3<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>: Arbitrary, Equatable {
    var member1: T1
    var member2: T2
    var member3: T3

    static var arbitrary: Gen<Self> {
        Gen<Self>.compose { composer in
            Self(
                member1: composer.generate(),
                member2: composer.generate(),
                member3: composer.generate(),
            )
        }
    }
}

private struct Pair<A1: Equatable, A2: Equatable>: Equatable {
    var member1: A1
    var member2: A2
}

private func prop_struct3_property_get<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(
    _: T1.Type,
    _: T2.Type,
    _: T3.Type,
) {
    func s3_property_get1(_ x: S3<T1, T2, T3>) -> T1 {
        x.member1
    }
    func s3_property_get2(_ x: S3<T1, T2, T3>) -> T2 {
        x.member2
    }
    func s3_property_get3(_ x: S3<T1, T2, T3>) -> T3 {
        x.member3
    }
    func s3_property_get13(_ x: S3<T1, T2, T3>) -> Pair<T1, T3> {
        Pair(member1: x.member1, member2: x.member3)
    }
    property(String(describing: S3<T1, T2, T3>.self) + ".property_get1") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in
        let expected = xs.map(s3_property_get1)
        let actual = map(xs, s3_property_get1)
        return try? #require(expected == actual)
      }

    property(String(describing: S3<T1, T2, T3>.self) + ".property_get2") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in
        let expected = xs.map(s3_property_get2)
        let actual = map(xs, s3_property_get2)
        return try? #require(expected == actual)
      }

    property(String(describing: S3<T1, T2, T3>.self) + ".property_get3") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in
        let expected = xs.map(s3_property_get3)
        let actual = map(xs, s3_property_get3)
        return try? #require(expected == actual)
      }

    property(String(describing: S3<T1, T2, T3>.self) + ".property_get13") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in
        let expected = xs.map(s3_property_get13)
        let actual = map(xs, s3_property_get13)
        return try? #require(expected == actual)
      }
}

private func prop_struct3_property_set<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(
    _: T1.Type,
    _: T2.Type,
    _: T3.Type,
) {
    func s3_property_set(_ x: S3<T1, T2, T3>, _ member1: T1, _ member2: T2, _ member3: T3) -> S3<T1, T2, T3> {
        var x = x
        x.member1 = member1
        x.member2 = member2
        x.member3 = member3
        return x
    }

    property(String(describing: S3<T1, T2, T3>.self) + ".property_set") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary, T1.arbitrary, T2.arbitrary, T3.arbitrary) { (xs: [S3<T1, T2, T3>], member1: T1, member2: T2, member3: T3) in
        let expected = xs.map { s3_property_set($0, member1, member2, member3) }
        let actual = map(xs) { s3_property_set($0, member1, member2, member3) }
        return try? #require(expected == actual)
      }
}

private func prop_struct3_property_set_inout<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(
    _: T1.Type,
    _: T2.Type,
    _: T3.Type,
) {
    func s3_property_set_inout(_ x: inout S3<T1, T2, T3>, _ member1: T1, _ member2: T2, _ member3: T3) {
        x.member1 = member1
        x.member2 = member2
        x.member3 = member3
    }

    func s3_property_set(_ x: S3<T1, T2, T3>, _ member1: T1, _ member2: T2, _ member3: T3) -> S3<T1, T2, T3> {
        var x = x
        s3_property_set_inout(&x, member1, member2, member3)
        return x
    }

    property(String(describing: S3<T1, T2, T3>.self) + ".property_set_inout") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary, T1.arbitrary, T2.arbitrary, T3.arbitrary) { (xs: [S3<T1, T2, T3>], member1: T1, member2: T2, member3: T3) in
        let expected = xs.map { s3_property_set($0, member1, member2, member3) }
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        try parallel_for(iterations: xs.count) { i in
          s3_property_set_inout(&actual[i], member1, member2, member3)
        }.sync()
        return try? #require(expected == actual)
      }
}

// MARK: structs with default initializers

struct S1d<T1: ExpressibleByIntegerLiteral & Equatable>: Equatable {
    var vd1: T1 = 42
}

private func prop_struct1_default_init<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_: T.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(String(describing: S1d<T>.self) + ".defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in
        let expected = [S1d<T>](repeating: S1d<T>(), count: n)
        let actual = generate(count: n) { _ in S1d<T>() }
        return try? #require(expected == actual)
      }
}

struct S2d<T1: Equatable & ExpressibleByIntegerLiteral, T2: Equatable & ExpressibleByIntegerLiteral>: Equatable {
    var v1d: T1 = 42
    var v2d: T2 = 7
}

private func prop_struct2_default_init<
    T1: Arbitrary & Equatable & ExpressibleByIntegerLiteral,
    T2: Arbitrary & Equatable & ExpressibleByIntegerLiteral
>(_: T1.Type, _: T2.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(String(describing: S2d<T1, T2>.self) + ".defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in
        let expected = [S2d<T1, T2>](repeating: .init(), count: n)
        let actual = fill(count: n, with: S2d<T1, T2>())
        return try? #require(expected == actual)
      }
}

struct S3d<
    T1: ExpressibleByIntegerLiteral & Equatable,
    T2: ExpressibleByIntegerLiteral & Equatable,
    T3: ExpressibleByIntegerLiteral & Equatable
>: Equatable {
    var member1: T1 = 42
    var member2: T2 = 7
    var member3: T3 = 13
}

private func prop_struct3_default_init<
    T1: ExpressibleByIntegerLiteral & Equatable,
    T2: ExpressibleByIntegerLiteral & Equatable,
    T3: ExpressibleByIntegerLiteral & Equatable
>(_: T1.Type, _: T2.Type, _: T3.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(String(describing: S3d<T1, T2, T3>.self) + ".defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in
        let expected = [S3d<T1, T2, T3>](repeating: .init(), count: n)
        let actual = fill(count: n, with: S3d<T1, T2, T3>())
        return try? #require(expected == actual)
      }
}
