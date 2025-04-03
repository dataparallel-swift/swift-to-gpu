import SwiftToPTX
import XCTest

public typealias DataType = Float
public typealias SimdScalarType = DataType
public typealias Simd = SIMD8<SimdScalarType>
public typealias ArrayType = Array

public struct BuildingHeatTransferModel {

    @noDerivative
    public var numSurfaceSimdsPerZone = ArrayType<Int>()
    @noDerivative
    public var flattendSimdX = ArrayType<Int>()
    @noDerivative
    public var flattendSimdY = ArrayType<Int>()

    // @inline(never)
    mutating func setupFlattenedSIMDTable() {
        // let __zone = #Zone
        // defer { __zone.end() }

        if let maxSurfaceSimds = self.numSurfaceSimdsPerZone.max() {
            let count = maxSurfaceSimds * Simd.scalarCount

            var flattendSimdX = ArrayType<Int>.init(unsafeUninitializedCapacity: count)
            var flattendSimdY = ArrayType<Int>.init(unsafeUninitializedCapacity: count)

            flattendSimdX.withUnsafeMutableBufferPointer { simdx in
            flattendSimdY.withUnsafeMutableBufferPointer { simdy in
                parallel_for(iterations: count) { i in
                    let (q,r) = flatIndex(i)
                    simdx[i] = q
                    simdy[i] = r
                }.sync()
            }}

            self.flattendSimdX = flattendSimdX
            self.flattendSimdY = flattendSimdY
        }
    }

    // @inline(never)
    func flatIndex(_ index: Int) -> (Int,Int) {
        // let __zone = #Zone
        // defer { __zone.end() }

        // Explicitly convert to unsigned so that the compiler will convert
        // these into shifts and masks
        let q = UInt(index) / UInt(Simd.scalarCount)
        let r = UInt(index) % UInt(Simd.scalarCount)
        return (Int(q), Int(r))
    }
}

class BuildingSimulator : XCTestCase {
    var htm = BuildingHeatTransferModel.init()

    func test_setupFlattenedSIMDTable() {
        htm.numSurfaceSimdsPerZone.append(2)
        htm.setupFlattenedSIMDTable()

        XCTAssertEqual(htm.flattendSimdX, [0,0,0,0,0,0,0,0, 1,1,1,1,1,1,1,1])
        XCTAssertEqual(htm.flattendSimdY, [0,1,2,3,4,5,6,7, 0,1,2,3,4,5,6,7])
    }
}

fileprivate extension Array {
    init(unsafeUninitializedCapacity count: Int) {
        precondition(count >= 0, "arrays must have non-negative sizes")
        self.init(
            unsafeUninitializedCapacity: count,
            initializingWith: { _, initializedCount in
                initializedCount = count
            })
    }
}

