# Section Report: Build Automation & Release Process

## 1. Makefile Linking Rules

### Explanation of `$(TARGET): $(OBJECTS)`
The rule `$(TARGET): $(OBJECTS)` instructs the build system to take individual compiled object files (`.o`) and link them directly into the final binary executable using the compiler (e.g., `gcc`). The linker resolves all function and variable symbols directly across these supplied object files.

### Difference from Library Linking
* **Direct Object Linking:** Combines explicit local `.o` files directly into a single target file.
* **Library Linking:** Uses compiler flags such as `-L<path>` and `-l<libname>` to link against pre-compiled static (`.a`) or dynamic (`.so`) archive files. The linker searches the archive and extracts only the required symbols rather than processing local source object files individually.

---

## 2. Git Tags

### Definition & Purpose
A Git tag is an immutable pointer assigned to a specific commit in a repository's history. Unlike branches, tags remain fixed as new commits are added. They are primarily used to mark release milestones (e.g., `v1.0.0`) so developers can easily reference, checkout, or track exact software versions.

### Simple vs. Annotated Tags
* **Simple (Lightweight) Tag:** A basic reference pointing directly to a commit hash. It contains no metadata or release notes (`git tag v1.0`).
* **Annotated Tag:** A full Git object stored in the database containing a tagger's name, email, creation date, tag message, and optional GPG signature (`git tag -a v1.0 -m "Release v1.0"`). Annotated tags are standard for public release tracking.

---

## 3. GitHub Releases & Binary Attachments

### Purpose of GitHub Releases
A GitHub Release packages software at a specific version point tied to a Git tag. It provides a formal distribution hub containing release notes, changelogs, and downloadable software artifacts for users and deployment systems.

### Significance of Attaching Binaries
Attaching pre-compiled executables (such as the `client` binary) ensures:
1. **Zero-Dependency Execution:** End-users can download and run the application immediately without installing build tools (like `gcc` or `make`) or source dependencies.
2. **Environment Consistency:** Eliminates compilation errors caused by different local compiler versions, configurations, or missing header files.
