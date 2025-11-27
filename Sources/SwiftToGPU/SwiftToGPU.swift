// Copyright (c) 2025 PassiveLogic, Inc.

import BackendInterface

#if CPU
@_exported import func CPUBackend.parallel_for
#endif

#if PTX
@_exported import func PTXBackend.parallel_for
#endif
