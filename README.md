## Feature 4: Dynamic Library Analysis

### 1. Position-Independent Code (-fPIC)
`-fPIC` generates machine code using relative memory addresses rather than fixed, absolute addresses. This allows the OS dynamic loader to load the shared library (`.so`) into any arbitrary memory address space shared across multiple processes without requiring code relocation at runtime.

### 2. File Size Comparison
* **Static Binary (`client_static`):** Larger, because all compiled object code from `libmyutils.a` is copied directly inside the binary.
* **Dynamic Binary (`client_dynamic`):** Smaller, because it only contains references/stubs to external functions. The actual library code remains inside `libmyutils.so` and is loaded at runtime.

### 3. Purpose of `LD_LIBRARY_PATH`
`LD_LIBRARY_PATH` is an environment variable that tells the dynamic linker/loader (`ld.so`) additional directory paths to search for shared object (`.so`) files before looking in standard system folders like `/lib` or `/usr/lib`. Setting it was necessary because `libmyutils.so` resides in a custom non-standard directory (`./lib`).
