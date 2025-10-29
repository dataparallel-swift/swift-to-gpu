# Language

Tests for Swift language features that work in GPU kernels (or not).

## Conditional Control Flow
- [x] `if`-expressions
- [x] `guard`-expressions
- [x] ternary operator
- [x] `for` loops
- [x] `while` loops
- [ ] `switch`-expressions (ClickUp: )
TODO: guidelines
- [ ] defer
TODO: guidelines


## Function Calls
- [x] Regular
- [x] Tail-Recursive
- [x] Non-Tail-Recursive
- [x] Mutually Recursive
- [ ] Inout parameters (ClickUp: 86b6ycdvn)
- [ ] (TODO) Non-escaping closure parameters
- [ ] Escaping closure Parameters (ClickUp: )


## Structs
- [ ] Property getters (ClickUp: 86b6vgh48, 86b70m272)
- [ ] Property setters (ClickUp: 86b6vgh48, 86b70m272, 86b6ycdvn)
- [ ] Default parameter initializers (ClickUp: )


## Enums
- [x] Pattern matching (`switch`)
- [ ] (TODO) `if case`/`guard case`


## Optionals
- [x] `if let` bindings
- [x] force-unwrapping a `some` variant
- [ ] force-unwrapping a `none` variant
