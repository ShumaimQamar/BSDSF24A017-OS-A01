## Feature 3: Static Library Analysis

### 1. Key Makefile Differences (Part 2 vs. Part 3)
* **Part 2 (Direct Linking):** Object files (`.o`) were compiled and directly linked into `bin/client` in a single linking step via `gcc`.
* **Part 3 (Static Linking):** Object files for utility functions are first packaged into an archive file `lib/libmyutils.a` using `ar rcs`. The executable is then linked against this library using `-Llib -lmyutils`.

### 2. Purpose of `ar` and `ranlib`
* **`ar` (Archiver):** Used to create, modify, and extract archive files (`.a`). It bundles multiple object files into a single static library file.
* **`ranlib`:** Generates or updates an index of symbols inside the static archive to allow the linker to quickly look up functions. (Modern GNU `ar` handles symbol indexing automatically via the `s` flag).

### 3. Symbol Inspection (`nm`)
Running `nm bin/client_static` displays defined text symbols (`T`) for custom library functions such as `mystrlen`. This proves that static linking copies the actual code of referenced functions directly into the final executable binary at build time.
