@inline(never)
func copy<T>(_ xs: [T]) -> [T] {
    // NOTE: [Array literals on the GPU]
    // There is an optimization pass/a combination of passes that lifts array literals
    // into one of the constant data section. On Linux, they end up in the .data section, which
    // is inaccessible to the GPU runtime. We rely on the compiler being unable to const-fold
    // `map` to work around this and create a new heap-allocated array from a static array.
    xs.map(\.self)
}
