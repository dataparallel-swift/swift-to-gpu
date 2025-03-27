import Testing

// TLM you are not meant to call the testing library in this way, there should
// be a way to hook into the stable ABI entry point and call that directly, but
// I was unable to get it to work. c.f. swt_abiv0_getEntryPoint
@main struct Runner {
    static func main() async {
        await Testing.__swiftPMEntryPoint() as Never
    }
}

// swift-testing doesn't have nested test suites at the moment, so until we do
// just pretend what the structure should be. Having a @Suite declaration
// doesn't do anything useful, so just remove it.
//    ---TLM 2025-03-27
struct NoFibTests {
    let config : Config = .init()
    let preludeTests : PreludeTests = .init()
}

