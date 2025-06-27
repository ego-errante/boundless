# Boundless Development Environment Setup

This guide walks you through setting up a complete development environment for the Boundless project.

## Quick Start

For a detailed walkthrough and explanation of each step, see the full article:
**[Boundless: A Guide to Setting Up Your Dev Environment](https://egoerrante.substack.com/p/boundless-a-guide-to-setting-up-your-dev-environment)**

## Summary

The `setup.sh` script automates the installation and configuration of:

- **RISC Zero toolchain** - Zero-knowledge proof framework
- **Foundry** - Ethereum development toolkit (forge, cast, anvil, chisel)
- **Boundless template** - Pre-configured project template with submodules
- **Environment configuration** - Required environment variables and keys
- **Build verification** - Rust and Solidity tests to ensure proper setup

## Prerequisites

Before running the script, ensure you have:

- Rust installed ([rustup.rs](https://rustup.rs/))
- Git installed
- Package manager (Homebrew on macOS, apt/yum on Linux)

## Usage

```bash
chmod +x setup.sh
./setup.sh
```

**Note:** The script will pause for manual configuration of environment variables (private keys, etc.) before completing the setup process.

## Next Steps

After setup completion, you'll have a fully configured Boundless development environment ready for building zero-knowledge applications with Ethereum integration.
