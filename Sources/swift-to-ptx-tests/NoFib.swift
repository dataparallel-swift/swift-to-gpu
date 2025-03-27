import Testing

@main struct Runner {
    static func main() async {
        await Testing.__swiftPMEntryPoint() as Never
    }
}

@Suite("no-fib") struct NoFibTests {
    let config : Config = .init()
    let preludeTests : PreludeTests = .init()
}

