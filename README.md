

## Feature 4: Dynamic Library Analysis

### 1. Position-Independent Code (-fPIC)
`-fPIC` generates machine code using relative memory addresses rather than fixed, absolute addresses. This allows the OS dynamic loader to load the shared library (`.so`) into any arbitrary memory address space shared across multiple processes without requiring code relocation at runtime.

### 2. File Size Comparison
* **Static Binary (`client_static`):** Larger, because all compiled object code from `libmyutils.a` is copied directly inside the binary.
* **Dynamic Binary (`client_dynamic`):** Smaller, because it only contains references/stubs to external functions. The actual library code remains inside `libmyutils.so` and is loaded at runtime.

### 3. Purpose of `LD_LIBRARY_PATH`
`LD_LIBRARY_PATH` is an environment variable that tells the dynamic linker/loader (`ld.so`) additional directory paths to search for shared object (`.so`) files before looking in standard system folders like `/lib` or `/usr/lib`. Setting it was necessary because `libmyutils.so` resides in a custom non-standard directory (`./lib`).
## Feature 3: Static Library Analysis

### 1. Key Makefile Differences (Part 2 vs. Part 3)
* **Part 2 (Direct Linking):** Object files (`.o`) were compiled and directly linked into `bin/client` in a single linking step via `gcc`.
* **Part 3 (Static Linking):** Object files for utility functions are first packaged into an archive file `lib/libmyutils.a` using `ar rcs`. The executable is then linked against this library using `-Llib -lmyutils`.

### 2. Purpose of `ar` and `ranlib`
* **`ar` (Archiver):** Used to create, modify, and extract archive files (`.a`). It bundles multiple object files into a single static library file.
* **`ranlib`:** Generates or updates an index of symbols inside the static archive to allow the linker to quickly look up functions. (Modern GNU `ar` handles symbol indexing automatically via the `s` flag).

### 3. Symbol Inspection (`nm`)
Running `nm bin/client_static` displays defined text symbols (`T`) for custom library functions such as `mystrlen`. This proves that static linking copies the actual code of referenced functions directly into the final executable binary at build time.


