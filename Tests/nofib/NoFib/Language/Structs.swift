import SwiftCheck
import SwiftToPTX
import Testing

@Suite("structs") struct StructsSuite {
    @Suite("Struct Property Getters") struct StructPropertyGettersSuite {
        @Test func test_struct1_property_get() { prop_struct1_property_get(Int32.self) }
        @Test func test_struct2_property_get() { prop_struct2_property_get(Int32.self, Int64.self) }
        @Test func test_struct3_property_get() { prop_struct3_property_get(Int32.self, Int64.self, Bool.self) }
         
    }

    @Suite("Struct Property Setters") struct StructPropertySettersSuite {
        @Test func test_struct1_property_set() { prop_struct1_property_set(Int32.self) }
        // @Test("S2.set", .bug(id: "86b6vg9th")) func test_struct2_property_set() { prop_struct2_property_set(Int32.self, Int64.self) }
        @Test func test_struct3_property_set() { prop_struct3_property_set(Int32.self, Int64.self, Int8.self) }
    }

    @Suite("Struct Property Setters Inout") struct StructPropertySettersInoutSuite {
        // @Test("S1.set_inout", .bug(id: "86b6vgh48")) func test_struct1_property_set_inout() { prop_struct1_property_set_inout(Int32.self) }
        @Test func test_struct2_property_set_inout() { prop_struct2_property_set_inout(Int32.self, Int64.self) }
        @Test func test_struct3_property_set_inout() { prop_struct3_property_set_inout(Int32.self, Int64.self, Int8.self) }
    }

    @Suite("Struct Default Parameter Values") struct StructDefaultParameterValuesSuite {
        @Test func test_struct1_default_init() { prop_struct1_default_init(Int32.self) }
        @Test func test_struct2_default_init() { prop_struct2_default_init(Int32.self, Int64.self) }
        @Test func test_struct3_default_init() { prop_struct3_default_init(Int32.self, Int64.self, Int8.self) }
    }
}

struct S1<T: Arbitrary & Equatable>: Arbitrary & Equatable {
    public var v: T

    public static var arbitrary: Gen<Self> {
        T.arbitrary.map { Self(v: $0) }
    }
}

private func prop_struct1_property_get<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func fn(_ s: S1<T>) -> T {
        return s.v
    }
    property("struct1_property_get") <-
      forAllNoShrink([S1].arbitrary) { (xs: [S1]) in 
        let expected = xs.map(fn)
        let actual = map(xs, fn)
        return try? #require( expected == actual )
      }
}

private func prop_struct1_property_set<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func fn(_ s: S1<T>, _ v: T) -> S1<T> {
        var t = s
        t.v = v
        return t
    }
    property("struct1_property_set") <-
      forAllNoShrink([S1<T>].arbitrary) { (xs: [S1<T>]) in
      forAllNoShrink([T].arbitrary) { (vs: [T]) in
        let expected = zip(xs, vs).map { (s, v) in fn(s, v) }
        let actual = zipWith(xs, vs, fn)
        return try? #require( expected == actual )
      }}
}

private func prop_struct1_property_set_inout<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func fnMut(_ s: inout S1<T>, _ v: T) {
        s.v = v
    }
    func fn(_ s: S1<T>, _ v : T) -> S1<T> {
        var s = s
        fnMut(&s, v) 
        return s
    }
    property("struct1_property_set_inout") <-
      forAllNoShrink([S1<T>].arbitrary) { (xs: [S1<T>]) in
      forAllNoShrink([T].arbitrary) { (vs: [T]) in
        let expected = zip(xs, vs).map { (s, v) in fn(s, v) }
        var actual = xs
        parallel_for(iterations: min(xs.count, vs.count)) { i in
            fnMut(&actual[i], vs[i])
        }
        return try? #require( expected == actual )
      }}
}

struct S2<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>: Arbitrary, Equatable {
    public var v1: T1
    public var v2: T2

    public static var arbitrary: Gen<Self> {
        Gen<Self>.compose { c in
            return Self(
                v1: c.generate(),
                v2: c.generate()
            )
        }
    }
}

private func prop_struct2_property_get<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type) {
    func fn1(_ s: S2<T1, T2>) -> T1 {
        return s.v1
    }
    func fn2(_ s: S2<T1, T2>) -> T2 {
        return s.v2
    }
    property("struct2_property_get1") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
        let expected = xs.map(fn1)
        let actual = map(xs, fn1)
        return try? #require( expected == actual )
      }

    property("struct2_property_get2") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
        let expected = xs.map(fn2)
        let actual = map(xs, fn2)
        return try? #require( expected == actual )
      }
}

private func prop_struct2_property_set<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type) {
    func fn(_ s: S2<T1, T2>, _ v1: T1, _ v2: T2) -> S2<T1, T2> {
        var s = s
        s.v1 = v1
        s.v2 = v2
        return s
    }

    property("struct2_property_get") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
        let expected = xs.map { fn($0, v1, v2) }
        let actual = map(xs) { fn($0, v1, v2) }
        return try? #require( expected == actual )
      }}}
}

private func prop_struct2_property_set_inout<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type) {
    func fnMut(_ s: inout S2<T1, T2>, _ v1: T1, _ v2: T2) {
        s.v1 = v1
        s.v2 = v2
    }

    func fn(_ s: S2<T1, T2>, _ v1: T1, _ v2: T2) -> S2<T1, T2> {
        var s = s
        fnMut(&s, v1, v2)
        return s
    }

    property("struct2_property_set_inout") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
        let expected = xs.map { fn($0, v1, v2) }
        var actual = xs
        parallel_for(iterations: xs.count) { i in
            fnMut(&actual[i], v1, v2)
        }
        return try? #require( expected == actual )
      }}}
}

struct S3<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>: Arbitrary, Equatable {
    public var v1: T1
    public var v2: T2
    public var v3: T3

    public static var arbitrary: Gen<Self> {
        Gen<Self>.compose { c in
            return Self(
                v1: c.generate(),
                v2: c.generate(),
                v3: c.generate()
            )
        }
    }
}

private func prop_struct3_property_get<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    func fn1(_ s: S3<T1, T2, T3>) -> T1 {
        return s.v1
    }
    func fn2(_ s: S3<T1, T2, T3>) -> T2 {
        return s.v2
    }
    func fn3(_ s: S3<T1, T2, T3>) -> T3 {
        return s.v3
    }
    // would have made the return type a tuple, but `Equatable` is not automatically satisfied for [(T1, T2)] where both type parameters are `Equatable`.
    // Also tuples cannot be extended like all other types in Swift. RIP.
    func fn4(_ s: S3<T1, T2, T3>) -> S2<T1, T3> {
        return S2(v1: s.v1, v2: s.v3)
    }
    property("struct3_property_get1") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(fn1)
        let actual = map(xs, fn1)
        return try? #require( expected == actual )
      }

    property("struct3_property_get2") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(fn2)
        let actual = map(xs, fn2)
        return try? #require( expected == actual )
      }

    property("struct3_property_get3") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(fn3)
        let actual = map(xs, fn3)
        return try? #require( expected == actual )
      }

    property("struct3_property_get4") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(fn4)
        let actual = map(xs, fn4)
        return try? #require( expected == actual )
      }
}

private func prop_struct3_property_set<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    func fn(_ s: S3<T1, T2, T3>, _ v1: T1, _ v2: T2, _ v3: T3) -> S3<T1, T2, T3> {
        var s = s
        s.v1 = v1
        s.v2 = v2
        s.v3 = v3
        return s
    }

    property("struct3_property_set") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
      forAllNoShrink(T3.arbitrary) { (v3: T3) in 
        let expected = xs.map { fn($0, v1, v2, v3) }
        let actual = map(xs) { fn($0, v1, v2, v3) }
        return try? #require( expected == actual )
      }}}}
}

private func prop_struct3_property_set_inout<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    func fnMut(_ s: inout S3<T1, T2, T3>, _ v1: T1, _ v2: T2, _ v3: T3) {
        s.v1 = v1
        s.v2 = v2
        s.v3 = v3
    }

    func fn(_ s: S3<T1, T2, T3>, _ v1: T1, _ v2: T2, _ v3: T3) -> S3<T1, T2, T3> {
        var s = s
        fnMut(&s, v1, v2, v3)
        return s
    }

    property("struct3_property_set_inout") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
      forAllNoShrink(T3.arbitrary) { (v3: T3) in 
        let expected = xs.map { fn($0, v1, v2, v3) }
        var actual = xs
        parallel_for(iterations: xs.count) { i in
            fnMut(&actual[i], v1, v2, v3)
        }
        return try? #require( expected == actual )
      }}}}
}

// MARK: structs with default initializers 
struct S1d<T1: ExpressibleByIntegerLiteral & Equatable>: Equatable {
    public var v1: T1 = 42
}

private func prop_struct1_default_init<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_ proxy: T.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property("struct1_defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in 
        let expected = [S1d<T>](repeating: S1d<T>(), count: n)
        let actual = generate(count: n) { _ in S1d<T>() }
        return try? #require( expected == actual )
      }
}

struct S2d<T1: Equatable & ExpressibleByIntegerLiteral, T2: Equatable & ExpressibleByIntegerLiteral & Arbitrary>: Equatable {
    public var v1: T1 = 42
    var v2: T2

    public init(v2: T2) {
        self.v2 = v2
    }
}

private func prop_struct2_default_init<T1: Arbitrary & Equatable & ExpressibleByIntegerLiteral, T2: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_ proxy1: T1.Type, _ proxy2: T2.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property("struct1_defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
        let expected = [S2d<T1, T2>](repeating: .init(v2: v2), count: n)
        let actual = fill(count: n, with: S2d<T1, T2>(v2: v2))
        return try? #require( expected == actual )
      }}
}

struct S3d<T1: ExpressibleByIntegerLiteral & Equatable, T2: ExpressibleByIntegerLiteral & Equatable, T3: Equatable>: Equatable {
    public var v1: T1 = 42
    var v2: T2 = 1337
    private var v3: T3

    public init(v3: T3) {
        self.v3 = v3
    }
}

private func prop_struct3_default_init<T1: ExpressibleByIntegerLiteral & Equatable, T2: ExpressibleByIntegerLiteral & Equatable, T3: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property("struct1_defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in 
      forAllNoShrink(T3.arbitrary) { (v3: T3) in 
        let expected = [S3d<T1, T2, T3>](repeating: .init(v3: v3), count: n)
        let actual = fill(count: n, with: S3d<T1, T2, T3>(v3: v3))
        return try? #require( expected == actual )
      }}
}
