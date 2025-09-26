// Copyright (c) 2025 PassiveLogic, Inc.

import Testing

// TLM you are not meant to call the testing library in this way, there should
// be a way to hook into the stable ABI entry point and call that directly, but
// I was unable to get it to work. c.f. swt_abiv0_getEntryPoint
@main
struct Runner {
    static func main() async {
        await Testing.__swiftPMEntryPoint() as Never
    }
}
#endif
