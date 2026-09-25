# Section Report: Build Automation & Release Process

## 1. Makefile Linking Rules

### Explanation of `$(TARGET): $(OBJECTS)`
The rule `$(TARGET): $(OBJECTS)` instructs the build system to take individual compiled object files (`.o`) and link them directly into the final binary executable using the compiler (e.g., `gcc`). The linker resolves all function and variable symbols directly across these supplied object files.

### Difference from Library Linking
* **Direct Object Linking:** Combines explicit local `.o` files directly into a single target file.
* **Library Linking:** Uses compiler flags such as `-L<path>` and `-l<libname>` to link against pre-compiled static (`.a`) or dynamic (`.so`) archive files. The linker searches the archive and extracts only the required symbols rather than processing local source object files individually.

## 2. Git Tags

### Definition & Purpose
A Git tag is an immutable pointer assigned to a specific commit in a repository's history. Unlike branches, tags remain fixed as new commits are added. They are primarily used to mark release milestones (e.g., `v1.0.0`) so developers can easily reference, checkout, or track exact software versions.

### Simple vs. Annotated Tags
* **Simple (Lightweight) Tag:** A basic reference pointing directly to a commit hash. It contains no metadata or release notes (`git tag v1.0`).
* **Annotated Tag:** A full Git object stored in the database containing a tagger's name, email, creation date, tag message, and optional GPG signature (`git tag -a v1.0 -m "Release v1.0"`). Annotated tags are standard for public release tracking.

## 3. GitHub Releases & Binary Attachments

### Purpose of GitHub Releases
A GitHub Release packages software at a specific version point tied to a Git tag. It provides a formal distribution hub containing release notes, changelogs, and downloadable software artifacts for users and deployment systems.

### Significance of Attaching Binaries
Attaching pre-compiled executables (such as the `client` binary) ensures:
1. **Zero-Dependency Execution:** End-users can download and run the application immediately without installing build tools (like `gcc` or `make`) or source dependencies.
2. **Environment Consistency:** Eliminates compilation errors caused by different local compiler versions, configurations, or missing header files.

## Feature 3: Static Library Analysis

### 1. Key Makefile Differences (Part 2 vs. Part 3)
* **Part 2 (Direct Linking):** Object files (`.o`) were compiled and directly linked into `bin/client` in a single linking step via `gcc`.
* **Part 3 (Static Linking):** Object files for utility functions are first packaged into an archive file `lib/libmyutils.a` using `ar rcs`. The executable is then linked against this library using `-Llib -lmyutils`.

### 2. Purpose of `ar` and `ranlib`
* **`ar` (Archiver):** Used to create, modify, and extract archive files (`.a`). It bundles multiple object files into a single static library file.
* **`ranlib`:** Generates or updates an index of symbols inside the static archive to allow the linker to quickly look up functions. (Modern GNU `ar` handles symbol indexing automatically via the `s` flag).

### 3. Symbol Inspection (`nm`)
Running `nm bin/client_static` displays defined text symbols (`T`) for custom library functions such as `mystrlen`. This proves that static linking copies the actual code of referenced functions directly into the final executable binary at build time.



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


