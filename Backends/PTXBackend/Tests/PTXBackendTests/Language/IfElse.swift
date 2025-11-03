// Copyright (c) 2025 PassiveLogic, Inc.

import Foundation
import PTXBackend
import SwiftCheck
import Testing

// swiftformat:disable trailingCommas

@Suite("if-else") struct IfElseTests {
     @Test func test_if_true() {
         func if_true(_ i: Int) -> Int {
             if true { return i }
             return 0
         }
         property("if_true") <-
           forAllNoShrink([Int].arbitrary) { (xs: [Int]) in
             let expected = xs.map(if_true)
             let actual = map(xs, if_true)
             return try? #require(actual == expected)
           }
     }

     @Test func test_if_false() {
         func if_false(_ i: Int) -> Int {
             if false { return i }
             return 0
         }
         property("if_false") <-
           forAllNoShrink([Int].arbitrary) { (xs: [Int]) in
             let expected = xs.map(if_false)
             let actual = map(xs, if_false)
             return try? #require(actual == expected)
           }
     }

     @Test func test_if() {
         func if_(_ x: Bool, _ y: Int) -> Int {
             if x {
                 return y
             }
             return 0
         }
         property("if") <-
           forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { (xs: [Bool], ys: [Int]) in
             let expected = zip(xs, ys).map { x, y in if_(x, y) }
             let actual = zipWith(xs, ys) { x, y in if_(x, y) }
             return try? #require(actual == expected)
           }
     }

     @Test func test_ternary_operator() {
         func ternary(_ x: Bool, _ y: Int) -> Int {
             x ? y : 0
         }
         property("ternary") <-
           forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { (xs: [Bool], ys: [Int]) in
             let expected = zip(xs, ys).map { x, y in ternary(x, y) }
             let actual = zipWith(xs, ys) { x, y in ternary(x, y) }
             return try? #require(actual == expected)
           }
     }

     @Test func test_if_else1() {
         func if_else(_ x: Bool, _ y: Int) -> Int {
             if x {
                 return y
             }
             else {
                 return 0
             }
         }
         property("if_else") <-
           forAllNoShrink([Bool].arbitrary, [Int].arbitrary) { (xs: [Bool], ys: [Int]) in
             let expected = zip(xs, ys).map { x, y in if_else(x, y) }
             let actual = zipWith(xs, ys, if_else)
             return try? #require(actual == expected)
           }
     }

     @Test func test_if_else2() {
         func if_else2(_ b1: Bool, _ b2: Bool, _ x: Int) -> Int {
             if b1 {
                 return x
             }
             else if b2 {
                 return 0
             }
             else {
                 return 1
             }
         }
         property("if_else2") <-
           forAllNoShrink([Bool].arbitrary, [Bool].arbitrary, Int.arbitrary) { (b1s: [Bool], b2s: [Bool], x: Int) in
             let expected = zip(b1s, b2s).map { b1, b2 in if_else2(b1, b2, x) }
             let actual = zipWith(b1s, b2s) { b1, b2 in if_else2(b1, b2, x) }
             return try? #require(actual == expected)
           }
     }

     @Test func test_if_else3() {
         func if_else3(_ b1: Bool, _ b2: Bool, _ b3: Bool, _ x: Int) -> Int {
             if b1 {
                 return x
             }
             else if b2 {
                 return 0
             }
             else if b3 {
                 return 1
             }
             else {
                 return 2
             }
         }
         property("if_else3") <-
           forAllNoShrink([Bool].arbitrary, [Bool].arbitrary, Bool.arbitrary, Int.arbitrary) { (
               b1s: [Bool],
               b2s: [Bool],
               b3: Bool,
               x: Int,
           ) in
             let expected = zip(b1s, b2s).map { b1, b2 in if_else3(b1, b2, b3, x) }
             let actual = zipWith(b1s, b2s) { b1, b2 in if_else3(b1, b2, b3, x) }
             return try? #require(actual == expected)
           }
     }

     @Test func test_nested_if() {
         func nested_if(_ b1: Bool, _ b2: Bool, _ x: Int) -> Int {
             if b1 {
                 if b2 {
                     return x
                 }
                 return 0
             }
             return 1
         }
         property("nested_if") <-
           forAllNoShrink([Bool].arbitrary, [Bool].arbitrary, Int.arbitrary) { (b1s: [Bool], b2s: [Bool], x: Int) in
             let expected = zip(b1s, b2s).map { b1, b2 in nested_if(b1, b2, x) }
             let actual = zipWith(b1s, b2s) { b1, b2 in nested_if(b1, b2, x) }
             return try? #require(actual == expected)
           }
     }
 }
