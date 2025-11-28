// Copyright (c) 2025 The swift-to-gpu authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#if PTX
import BenchmarkFunctionsC
#endif
import SwiftToGPU

// swiftlint:disable missing_docs

// MARK: CPU

// --------------------------------------------------------------------------------

#if arch(arm64)
public func saxpy_cpu_f16(_ alpha: Float16, _ xs: [Float16], _ ys: [Float16]) -> [Float16] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0 ..< n {
                buffer[i] = alpha * xs[i] + ys[i]
            }
            initializedCount = n
        }
    )
}
#endif

public func saxpy_cpu_f32(_ alpha: Float32, _ xs: [Float32], _ ys: [Float32]) -> [Float32] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0 ..< n {
                buffer[i] = alpha * xs[i] + ys[i]
            }
            initializedCount = n
        }
    )
}

public func saxpy_cpu_f64(_ alpha: Float64, _ xs: [Float64], _ ys: [Float64]) -> [Float64] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0 ..< n {
                buffer[i] = alpha * xs[i] + ys[i]
            }
            initializedCount = n
        }
    )
}

public func saxpy_cpu_generic<A: Numeric>(_ alpha: A, _ xs: [A], _ ys: [A]) -> [A] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array<A>(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0 ..< n {
                buffer[i] = alpha * xs[i] + ys[i]
            }
            initializedCount = n
        }
    )
}

public func saxpy_cpu_generic_safe<A: Numeric>(_ alpha: A, _ xs: [A], _ ys: [A]) -> [A] {
    assert(xs.count == ys.count)
    let n = xs.count
    var result = Array<A>()
    result.reserveCapacity(n)

    for i in 0 ..< n {
        result.append(alpha * xs[i] + ys[i])
    }

    return result
}

#if arch(arm64)
@_specialize(exported: true, where A == Float16)
#endif
@_specialize(exported: true, where A == Float32)
@_specialize(exported: true, where A == Float64)
public func saxpy_cpu_specialised<A: Numeric>(_ alpha: A, _ xs: [A], _ ys: [A]) -> [A] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array<A>(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            for i in 0 ..< n {
                buffer[i] = alpha * xs[i] + ys[i]
            }
            initializedCount = n
        }
    )
}

// MARK: PTX

// --------------------------------------------------------------------------------

#if arch(arm64)
public func saxpy_ptx_f16(_ alpha: Float16, _ xs: [Float16], _ ys: [Float16]) -> [Float16] {
    assert(xs.count == ys.count)
    return zipWith(xs, ys) { x, y in alpha * x + y }
}
#endif

public func saxpy_ptx_f32(_ alpha: Float32, _ xs: [Float32], _ ys: [Float32]) -> [Float32] {
    assert(xs.count == ys.count)
    return zipWith(xs, ys) { x, y in alpha * x + y }
}

public func saxpy_ptx_f64(_ alpha: Float64, _ xs: [Float64], _ ys: [Float64]) -> [Float64] {
    assert(xs.count == ys.count)
    return zipWith(xs, ys) { x, y in alpha * x + y }
}

// RIP
// saxpy_ptx_generic
// saxpy_ptx_specialised

// MARK: CUDA

// --------------------------------------------------------------------------------

#if PTX
#if arch(arm64)
public func saxpy_cuda_f16(_ alpha: Float16, _ xs: [Float16], _ ys: [Float16]) -> [Float16] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            BenchmarkFunctionsC.saxpy_cuda_f16(alpha, xs, ys, buffer.baseAddress, n)
            initializedCount = n
        }
    )
}
#endif

public func saxpy_cuda_f32(_ alpha: Float32, _ xs: [Float32], _ ys: [Float32]) -> [Float32] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            BenchmarkFunctionsC.saxpy_cuda_f32(alpha, xs, ys, buffer.baseAddress, n)
            initializedCount = n
        }
    )
}

public func saxpy_cuda_f64(_ alpha: Float64, _ xs: [Float64], _ ys: [Float64]) -> [Float64] {
    assert(xs.count == ys.count)
    let n = xs.count
    return Array(
        unsafeUninitializedCapacity: n,
        initializingWith: { buffer, initializedCount in
            BenchmarkFunctionsC.saxpy_cuda_f64(alpha, xs, ys, buffer.baseAddress, n)
            initializedCount = n
        }
    )
}
#endif
