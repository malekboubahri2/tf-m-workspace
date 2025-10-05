# Dev Container for Trusted Firmware-M Workspace

This repository provides a Visual Studio Code Dev Container setup for developing, building, and testing [Trusted Firmware-M (TF-M)](https://www.trustedfirmware.org/projects/tfm/) and related projects. The environment is based on **Ubuntu 22.04 LTS** and is pre-configured for embedded firmware development, especially targeting Arm Cortex-M platforms.

## Overview

Trusted Firmware-M (TF-M) is a reference implementation of the [Platform Security Architecture (PSA)](https://www.psacertified.org/) specifications, providing foundational security services for Arm microcontrollers. This workspace includes all major TF-M dependencies and tools, enabling you to build, test, and extend TF-M for your own hardware platforms.

## Features

- **Pre-installed Toolchains**
  - ARM GCC (`gcc-arm-none-eabi-10.3-2021.10`)
  - CMake (v3.21+), Ninja
- **STM32Cube Programmer** for flashing and debugging STM32 devices
- **Python 3** and `venv` for TF-M Python dependencies
- **VS Code Tasks** for building and flashing TF-M firmware:
  - **Build TF-M**: Use the "Build TF-M" task to compile the firmware and tests.
  - **Flash TF-M**: Use the "Flash TF-M" task to program the built firmware to your STM32 device.
- **Cloned Dependencies** in `/deps`:
  - `trusted-firmware-m`
  - `tf-m-tests`
  - `tf-m-extras`
  - `mbedtls`
  - `mcuboot`
  - `QCBOR`
- **Build Scripts** in `/scripts` for regression tests and firmware images
- **Easy Extension** for new platforms and toolchains

## Getting Started

1. **Open in VS Code**  
   Open this workspace in Visual Studio Code. When prompted, select "Reopen in Container" to launch the dev container.

2. **Build TF-M**  
   Run the "Build TF-M" task from the VS Code command palette or the Run Task menu to compile TF-M and its tests for your target platform.

3. **Flash Firmware**  
   Run the "Flash TF-M" task to program the built firmware to your STM32 device using STM32Cube Programmer.

## Extending for Your Platform

To support additional hardware platforms or toolchains:

- **Add Toolchains**  
  Update `.devcontainer/Dockerfile` to install your platform’s compiler, debugger, or flashing tools.

- **Update Build Scripts**  
  Modify or add scripts in `/scripts` to build firmware for your platform. Adjust CMake toolchain files or Makefiles as needed.

- **Configure VS Code Tasks**  
  Edit `.vscode/tasks.json` to add build, flash, or debug tasks for your platform.

- **Integrate Platform SDKs**  
  Place SDKs or platform libraries in the appropriate location (e.g., `/deps` or `/app`). Update environment variables as needed.

- **Document Platform Steps**  
  Add instructions to this README for building, flashing, and debugging on your platform.

For more details on extending TF-M, see the [TF-M Integration Guide](https://trustedfirmware-m.readthedocs.io/en/latest/integration/index.html).

## Supported Build Environments

TF-M officially supports building on Linux (Ubuntu 18.04+). The following toolchains are supported:

- Arm Compiler v6.21+
- GNU Arm Compiler 10.3.2021.10+
- IAR Arm Compiler v9.30.1+
- LLVM Embedded Toolchain for Arm v18.1.3+

## Resources

- [TF-M Documentation](https://trustedfirmware-m.readthedocs.io/en/latest/)
- [PSA Certified](https://www.psacertified.org/)
- [Armv8-M Architecture](https://developer.arm.com/architectures/cpu-architecture/armv8-m)
- [TF-M Source Code](https://git.trustedfirmware.org/TF-M/trusted-firmware-m.git)

---

SPDX-License-Identifier: BSD-3-Clause  
SPDX-FileCopyrightText: Copyright The TrustedFirmware-M Contributors