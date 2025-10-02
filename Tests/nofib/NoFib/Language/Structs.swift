import SwiftCheck
import SwiftToPTX
import Testing

@Suite("structs") struct Structs {
    // The types of the members of the struct determine the layout (size and alignment)
    // its overall size and alignmnt. The purpose of these tests is to check property access
    // for varying layouts 

    @Suite("Int32") struct Int32Tests {
        @Test func test_struct1_property_get() { prop_struct1_property_get(Int32.self) }
        @Test func test_struct1_property_set() { prop_struct1_property_set(Int32.self) }
        // @Test("S1.set_inout", .bug(id: "86b6vgh48")) func test_struct1_property_set_inout() { prop_struct1_property_set_inout(Int32.self) }
        @Test func test_struct1_default_init() { prop_struct1_default_init(Int32.self) }
    }

    @Suite("Int32Int64") struct Int32Int64Tests {
        @Test func test_struct2_property_get() { prop_struct2_property_get(Int32.self, Int64.self) }
        // @Test("S2.set", .bug(id: "86b6vg9th")) func test_struct2_property_set() { prop_struct2_property_set(Int32.self, Int64.self) }
        // @Test("S2.set_inout", .bug(id: "86b6vgh48")) func test_struct2_property_set_inout() { prop_struct2_property_set_inout(Int32.self, Int64.self) }
        @Test func test_struct2_default_init() { prop_struct2_default_init(Int32.self, Int64.self) }
    }

    @Suite("Int32Int64Bool") struct Int32Int64BoolTests {
        @Test func test_struct3_property_get() { prop_struct3_property_get(Int32.self, Int64.self, Bool.self) }
        // @Test("S3.set", .bug(id: "86b6vg9th")) func test_struct3_property_set() { prop_struct3_property_set(Int32.self, Int64.self, Int8.self) }
        // @Test("S3.set_inout", .bug(id: "86b6vgh48")") func test_struct3_property_set_inout() { prop_struct3_property_set_inout(Int32.self, Int64.self, Int8.self) }
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
    func s1_property_get(_ s: S1<T>) -> T {
        return s.v
    }
    property(String(describing: S1<T>.self)+".property_get") <-
      forAllNoShrink([S1].arbitrary) { (xs: [S1]) in 
        let expected = xs.map(s1_property_get)
        let actual = map(xs, s1_property_get)
        return try? #require( expected == actual )
      }
}

private func prop_struct1_property_set<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func s1_property_set(_ s: S1<T>, _ v: T) -> S1<T> {
        var t = s
        t.v = v
        return t
    }
    property(String(describing: S1<T>.self)+".property_set") <-
      forAllNoShrink([S1<T>].arbitrary) { (xs: [S1<T>]) in
      forAllNoShrink([T].arbitrary) { (vs: [T]) in
        let expected = zip(xs, vs).map { (s, v) in s1_property_set(s, v) }
        let actual = zipWith(xs, vs, s1_property_set)
        return try? #require( expected == actual )
      }}
}

private func prop_struct1_property_set_inout<T: Arbitrary & Equatable>(_ proxy: T.Type) {
    func s1_property_set_inout(_ s: inout S1<T>, _ v: T) {
        s.v = v
    }
    func s1_property_set(_ s: S1<T>, _ v : T) -> S1<T> {
        var s = s
        s1_property_set_inout(&s, v) 
        return s
    }
    property(String(describing: S1<T>.self)+".property_set_inout") <-
      forAllNoShrink([S1<T>].arbitrary) { (xs: [S1<T>]) in
      forAllNoShrink([T].arbitrary) { (vs: [T]) in
        let expected = zip(xs, vs).map { (s, v) in s1_property_set(s, v) }
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        parallel_for(iterations: min(xs.count, vs.count)) { i in
          s1_property_set_inout(&actual[i], vs[i])
        }.sync()
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
    func s2_property_get1(_ s: S2<T1, T2>) -> T1 {
        return s.v1
    }
    func s2_property_get2(_ s: S2<T1, T2>) -> T2 {
        return s.v2
    }
    property(String(describing: S2<T1, T2>.self)+".property_get1") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
        let expected = xs.map(s2_property_get1)
        let actual = map(xs, s2_property_get1)
        return try? #require( expected == actual )
      }

    property(String(describing: S2<T1, T2>.self)+".property_get2") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
        let expected = xs.map(s2_property_get2)
        let actual = map(xs, s2_property_get2)
        return try? #require( expected == actual )
      }
}

private func prop_struct2_property_set<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type) {
    func s2_property_set(_ s: S2<T1, T2>, _ v1: T1, _ v2: T2) -> S2<T1, T2> {
        var s = s
        s.v1 = v1
        s.v2 = v2
        return s
    }

    property(String(describing: S2<T1, T2>.self)+"property_get") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
        let expected = xs.map { s2_property_set($0, v1, v2) }
        let actual = map(xs) { s2_property_set($0, v1, v2) }
        return try? #require( expected == actual )
      }}}
}

private func prop_struct2_property_set_inout<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type) {
    func s2_property_set_inout(_ s: inout S2<T1, T2>, _ v1: T1, _ v2: T2) {
        s.v1 = v1
        s.v2 = v2
    }

    func s2_property_set(_ s: S2<T1, T2>, _ v1: T1, _ v2: T2) -> S2<T1, T2> {
        var s = s
        s2_property_set_inout(&s, v1, v2)
        return s
    }

    property(String(describing: S2<T1, T2>.self)+".property_set_inout") <-
      forAllNoShrink([S2<T1, T2>].arbitrary) { (xs: [S2<T1, T2>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
        let expected = xs.map { s2_property_set($0, v1, v2) }
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        parallel_for(iterations: xs.count) { i in
            s2_property_set_inout(&actual[i], v1, v2)
        }.sync()
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
fileprivate struct Pair<A1: Equatable, A2: Equatable>: Equatable {
    public var v1: A1
    public var v2: A2
}

private func prop_struct3_property_get<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    func s3_property_get1(_ s: S3<T1, T2, T3>) -> T1 {
        return s.v1
    }
    func s3_property_get2(_ s: S3<T1, T2, T3>) -> T2 {
        return s.v2
    }
    func s3_property_get3(_ s: S3<T1, T2, T3>) -> T3 {
        return s.v3
    }
    func s3_property_get13(_ s: S3<T1, T2, T3>) -> Pair<T1, T3> {
        return Pair(v1: s.v1, v2: s.v3)
    }
    property(String(describing: S3<T1, T2, T3>.self)+".property_get1") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(s3_property_get1)
        let actual = map(xs, s3_property_get1)
        return try? #require( expected == actual )
      }

    property(String(describing: S3<T1, T2, T3>.self)+".property_get2") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(s3_property_get2)
        let actual = map(xs, s3_property_get2)
        return try? #require( expected == actual )
      }

    property(String(describing: S3<T1, T2, T3>.self)+".property_get3") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(s3_property_get3)
        let actual = map(xs, s3_property_get3)
        return try? #require( expected == actual )
      }

    property(String(describing: S3<T1, T2, T3>.self)+".property_get13") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
        let expected = xs.map(s3_property_get13)
        let actual = map(xs, s3_property_get13)
        return try? #require( expected == actual )
      }
}

private func prop_struct3_property_set<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    func s3_property_set(_ s: S3<T1, T2, T3>, _ v1: T1, _ v2: T2, _ v3: T3) -> S3<T1, T2, T3> {
        var s = s
        s.v1 = v1
        s.v2 = v2
        s.v3 = v3
        return s
    }

    property(String(describing: S3<T1, T2, T3>.self)+".property_set") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
      forAllNoShrink(T3.arbitrary) { (v3: T3) in 
        let expected = xs.map { s3_property_set($0, v1, v2, v3) }
        let actual = map(xs) { s3_property_set($0, v1, v2, v3) }
        return try? #require( expected == actual )
      }}}}
}

private func prop_struct3_property_set_inout<T1: Arbitrary & Equatable, T2: Arbitrary & Equatable, T3: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    func s3_property_set_inout(_ s: inout S3<T1, T2, T3>, _ v1: T1, _ v2: T2, _ v3: T3) {
        s.v1 = v1
        s.v2 = v2
        s.v3 = v3
    }

    func s3_property_set(_ s: S3<T1, T2, T3>, _ v1: T1, _ v2: T2, _ v3: T3) -> S3<T1, T2, T3> {
        var s = s
        s3_property_set_inout(&s, v1, v2, v3)
        return s
    }

    property(String(describing: S3<T1, T2, T3>.self)+".property_set_inout") <-
      forAllNoShrink([S3<T1, T2, T3>].arbitrary) { (xs: [S3<T1, T2, T3>]) in 
      forAllNoShrink(T1.arbitrary) { (v1: T1) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
      forAllNoShrink(T3.arbitrary) { (v3: T3) in 
        let expected = xs.map { s3_property_set($0, v1, v2, v3) }
        var actual = xs
        // NOTE: `parallel_for` required here because of in-place mutation,
        // i.e. modify accessor instead of subscript set
        parallel_for(iterations: xs.count) { i in
          s3_property_set_inout(&actual[i], v1, v2, v3)
        }.sync()
        return try? #require( expected == actual )
      }}}}
}

// MARK: structs with default initializers 
struct S1d<T1: ExpressibleByIntegerLiteral & Equatable>: Equatable {
    public var v1: T1 = 42
}

private func prop_struct1_default_init<T: Arbitrary & Equatable & ExpressibleByIntegerLiteral>(_ proxy: T.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(String(describing: S1d<T>.self)+".defuault_init") <-
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
    property(String(describing: S2d<T1, T2>.self)+".defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in 
      forAllNoShrink(T2.arbitrary) { (v2: T2) in 
        let expected = [S2d<T1, T2>](repeating: .init(v2: v2), count: n)
        let actual = fill(count: n, with: S2d<T1, T2>(v2: v2))
        return try? #require( expected == actual )
      }}
}

struct S3d<T1: ExpressibleByIntegerLiteral & Equatable, T2: ExpressibleByIntegerLiteral & Equatable, T3: Equatable>: Equatable {
    public var v1: T1 = 42
    var v2: T2 = 13
    private var v3: T3

    public init(v3: T3) {
        self.v3 = v3
    }
}

private func prop_struct3_default_init<T1: ExpressibleByIntegerLiteral & Equatable, T2: ExpressibleByIntegerLiteral & Equatable, T3: Arbitrary & Equatable>(_ proxy1: T1.Type, _ proxy2: T2.Type, _ proxy3: T3.Type) {
    let gen = Int.arbitrary.suchThat { $0 >= 0 }
    property(String(describing: S3d<T1, T2, T3>.self)+".defuault_init") <-
      forAllNoShrink(gen) { (n: Int) in 
      forAllNoShrink(T3.arbitrary) { (v3: T3) in 
        let expected = [S3d<T1, T2, T3>](repeating: .init(v3: v3), count: n)
        let actual = fill(count: n, with: S3d<T1, T2, T3>(v3: v3))
        return try? #require( expected == actual )
      }}
}
