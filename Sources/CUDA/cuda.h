/*
 * Interoperability layer to call CUDA functions from Swift
 *
 * We use the CUDA driver API, rather than the runtime API that is typically
 * demonstrated in the documentation/examples, as that relies more on C++
 * features and magic built into nvcc, such as  the <<< >>> syntax to launch
 * kernels.
 */

#include <cuda.h>

