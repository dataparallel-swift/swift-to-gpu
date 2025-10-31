# Language

Tests for Swift language features that work in GPU kernels (or not).

## Conditional Control Flow
- [x] `if`-expressions
- [x] `guard`-expressions
- [x] ternary operator
- [x] `for` loops
- [x] `while` loops
- [ ] `switch`-expressions (ClickUp: 86b6xaz1f)
    Switch expressions can _sometimes_ be optimized into lookup tables.
    If this optimization happens, the compiler crashes. This optimization is applied inconsistently.
    As a general rule of thumb, it should be applied when the case bodies are simple literal values and
    the case labels are sparsely distributed.
- [ ] defer
    Use of `defer` has been tested with simple blocks and loops so far, but it should work as expected
    in most common uses.


## Function Calls
- [x] Regular
- [x] Tail-Recursive
- [x] Non-Tail-Recursive
- [x] Mutually Recursive
- [ ] Inout parameters (ClickUp: 86b6ycdvn)
- [ ] (TODO) Non-escaping closure parameters
- [ ] Escaping closure parameters (ClickUp: 86b7a5j5u)


## Structs
- [ ] Property getters (ClickUp: 86b6vgh48, 86b70m272)
- [ ] Property setters (ClickUp: 86b6vgh48, 86b70m272, 86b6ycdvn)
- [ ] Default parameter initializers (ClickUp: 86b70m272)


## Enums
- [x] Pattern matching (`switch`)
- [ ] (TODO) `if case`/`guard case`


## Optionals
- [x] `if let` bindings
- [x] force-unwrapping a `some` variant
- [ ] force-unwrapping a `none` variant
