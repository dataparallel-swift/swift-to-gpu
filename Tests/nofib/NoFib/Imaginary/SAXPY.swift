import Testing
import SwiftCheck
import SwiftToPTX

@Suite("SAXPY") struct SAXPY {
    @Test("Float16") func test_float16() { prop_saxpy(Float16.self) }
    @Test("Float32") func test_float32() { prop_saxpy(Float32.self) }
    @Test("Float64") func test_float64() { prop_saxpy(Float64.self) }
}

private func prop_saxpy<T: Arbitrary & Similar & Numeric>(_ proxy: T.Type) {
    property(String(describing: T.self)+".saxpy") <-
      forAllNoShrink(Gen<Int>.choose((0, 8192))) { n in
      forAllNoShrink(T.arbitrary) { alpha in
      forAllNoShrink(T.arbitrary.proliferate(withSize: n)) { (xs: [T]) in
      forAllNoShrink(T.arbitrary.proliferate(withSize: n)) { (ys: [T]) in
        let expected = zip(xs, ys).map { (x, y) in alpha * x + y }
        let actual   = zipWith(xs, ys) { x, y in alpha * x + y }
        return try? #require( expected ~~~ actual )
      }}}}
}

