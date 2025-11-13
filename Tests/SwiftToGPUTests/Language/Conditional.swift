// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import SwiftCheck
import SwiftToGPU
import Testing

@Suite("Conditional") struct ConditionalTests {
     @Test func ifTrue() {
         func ifTrue(_ i: Int) -> Int {
             if true { return i }
             return 0
         }
         property(#function) <-
           forAllNoShrink([Int].arbitrary) { xs in
             let expected = xs.map(ifTrue)
             let actual = map(xs, ifTrue)
             return try? #require(actual == expected)
           }
     }

     @Test func ifFalse() {
         func ifFalse(_ i: Int) -> Int {
             if false { return i }
             return 0
         }
         property(#function) <-
           forAllNoShrink([Int].arbitrary) { xs in
             let expected = xs.map(ifFalse)
             let actual = map(xs, ifFalse)
             return try? #require(actual == expected)
           }
     }

     @Test func ifThen() {
         func ifThen(_ x: Bool, _ y: Int) -> Int {
             if x {
                 return y
             }
             return 0
         }
         property(#function) <-
           forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { xs, ys in
             let expected = zip(xs, ys).map { x, y in ifThen(x, y) }
             let actual = zipWith(xs, ys) { x, y in ifThen(x, y) }
             return try? #require(actual == expected)
           }
     }

     @Test func ifThenElse1() {
         func ifThenElse1(_ x: Bool, _ y: Int) -> Int {
             if x {
                 return y
             }
             else {
                 return 0
             }
         }
         property(#function) <-
           forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { xs, ys in
             let expected = zip(xs, ys).map { x, y in ifThenElse1(x, y) }
             let actual = zipWith(xs, ys, ifThenElse1)
             return try? #require(actual == expected)
           }
     }

     @Test func ifThenElse2() {
         func ifThenElse2(_ x: Bool, _ y: Bool, _ z: Int) -> Int {
             if x {
                 return z
             }
             else if y {
                 return 0
             }
             else {
                 return 1
             }
         }
         property(#function) <-
           forAllNoShrink([Bool].arbitrary, [Bool].arbitrary, Int.arbitrary) { xs, ys, z in
             let expected = zip(xs, ys).map { x, y in ifThenElse2(x, y, z) }
             let actual = zipWith(xs, ys) { x, y in ifThenElse2(x, y, z) }
             return try? #require(actual == expected)
           }
     }

     @Test func ifThenElse3() {
         // swiftlint:disable identifier_name
         func ifThenElse3(_ x: Bool, _ y: Bool, _ z: Bool, _ w: Int) -> Int {
             if x {
                 return w
             }
             else if y {
                 return 0
             }
             else if z {
                 return 1
             }
             else {
                 return 2
             }
         }
         property(#function) <-
           forAllNoShrink([Bool].arbitrary, [Bool].arbitrary, Bool.arbitrary, Int.arbitrary) { xs, ys, z, w in
             let expected = zip(xs, ys).map { x, y in ifThenElse3(x, y, z, w) }
             let actual = zipWith(xs, ys) { x, y in ifThenElse3(x, y, z, w) }
             return try? #require(actual == expected)
           }
         // swiftlint:enable identifier_name
     }

     @Test func ifThenElse4() {
         func ifThenElse4(_ x: Bool, _ y: Bool, _ z: Int) -> Int {
             if x {
                 if y {
                     return z
                 }
                 return 0
             }
             return 1
         }
         property(#function) <-
           forAllNoShrink([Bool].arbitrary, [Bool].arbitrary, Int.arbitrary) { xs, ys, z in
             let expected = zip(xs, ys).map { x, y in ifThenElse4(x, y, z) }
             let actual = zipWith(xs, ys) { x, y in ifThenElse4(x, y, z) }
             return try? #require(actual == expected)
           }
     }

     @Test func infixIfThenElse() {
         property(#function) <-
           forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { xs, ys in
             let expected = zip(xs, ys).map { x, y in x ? y : 0 }
             let actual = zipWith(xs, ys) { x, y in x ? y : 0 }
             return try? #require(actual == expected)
           }
     }
 }
