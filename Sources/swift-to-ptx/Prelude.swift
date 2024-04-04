
@inline(never)
@usableFromInline
// ^ So we can extract the loop body. But we should do the extraction early in
// the llvm pipeline and then remove this annotation, so that anything that
// wasn't hoisted to the GPU can at least be optimised normally. ---TLM 2024-01-30
internal func parallel_for(iterations: Int, _ body: (Int) -> ()) {
    for i in 0..<iterations {
        body(i)
    }
}

