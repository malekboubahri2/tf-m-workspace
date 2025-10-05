#!/usr/bin/env bash
set -e

#Install STM32CubeProgrammer
cd /workdir/workspace/.devcontainer/resources
unzip -n ./st-stm32cubeclt_1.19.0_25876_20250729_1159_amd64.sh.zip
chmod +x ./st-stm32cubeclt_1.19.0_25876_20250729_1159_amd64.sh
export LICENSE_ALREADY_ACCEPTED=1 
echo "" | ./st-stm32cubeclt_1.19.0_25876_20250729_1159_amd64.sh 
echo 'export PATH="$PATH:/opt/st/stm32cubeclt_1.19.0/STM32CubeProgrammer/bin"' >> ~/.bashrc
echo 'export STM32CUBE_SVD_PATH="/opt/st/stm32cubeclt_1.19.0/STMicroelectronics_CMSIS_SVD"' >> ~/.bashrc
source ~/.bashrc

#Install OpenOCD
TMP_DIR=$(mktemp -d)
git clone --branch v0.12.0 --recurse-submodules https://github.com/ntfreak/openocd.git "$TMP_DIR" >/dev/null 2>&1
cd "$TMP_DIR"
./bootstrap >/dev/null 2>&1
./configure --enable-stlink --enable-cmsis-dap >/dev/null 2>&1
make -j$(nproc) >/dev/null 2>&1
make install >/dev/null 2>&1
rm -rf "$TMP_DIR"

# Create a directory for TF-M dependencies
mkdir -p /workdir/deps
cd /workdir/deps

# Clone TF-M dependencies if not already present
[ ! -d "trusted-firmware-m" ] && git clone https://git.trustedfirmware.org/TF-M/trusted-firmware-m.git
[ ! -d "tf-m-tests" ] && git clone https://git.trustedfirmware.org/TF-M/tf-m-tests.git
[ ! -d "tf-m-extras" ] && git clone https://git.trustedfirmware.org/TF-M/tf-m-extras.git
[ ! -d "mbedtls" ] && git clone https://github.com/Mbed-TLS/mbedtls.git
[ ! -d "mcuboot" ] && git clone https://github.com/mcu-tools/mcuboot
[ ! -d "qcbor" ] && git clone https://github.com/laurencelundblade/QCBOR.git

# Setup Python venv for TF-M
cd trusted-firmware-m
python3 -m venv .venv
source .venv/bin/activate
pip install -e .