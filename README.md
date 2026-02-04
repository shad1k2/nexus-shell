# 🚀 Nexus Shell (v0.6-alpha)

A lightweight, customizable command-line shell written in **Nim**. Designed for power users who value control and efficiency.

> **Status:** Early Alpha.

## 🔥 Why Nexus?
* **Blazing Fast:** Compiles to optimized C code via the Nim compiler.
* **Modern Syntax:** A fresh take on shell logic without the legacy bloat of 40-year-old bash scripts.
* **Configurable:** Moving towards a simple, human-readable configuration style (inspired by Polybar/i3).

## 🛠 Installation (Arch Linux)

First, ensure you have the Nim compiler installed:
`sudo pacman -S nim` (arch based), `sudo apt install nim` (debian/ubuntu based), `sudo dnf install nim` (rhel/fedora based), `sudo zypper install nim` (opensuse/sle based), `pkg install nim` (freebsd/openindiana based)

Then, clone and build:

`git clone [https://github.com/shad1k2/nexus-shell.git](https://github.com/shad1k2/nexus-shell.git)`

`cd nexus-shell`

`mv nexus-shell/tools ~`

`nim c -d:release --opt:speed src/nexus.nim`

🚀 Roadmap

    [x] Basic command execution and parsing

    [ ] Support for environment variables

    [ ] Custom .nshrc configuration (Polybar-style)

    [ ] Command history and aliases
    
Contributing: Please do not PR to this repo directly. Send your features and experiments to [opennexus](https://github.com/shad1k2/opennexus/).


