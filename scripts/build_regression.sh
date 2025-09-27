#!/usr/bin/env bash
set -e
source /workdir/deps/trusted-firmware-m/.venv/bin/activate

PLATFORM=$1
BUILD_TYPE=${2:-Debug}
TOOLCHAIN=$3

if [ -z "$PLATFORM" ] || [ -z "$TOOLCHAIN" ]; then
  echo "Usage: $0 <platform> <build_type> <toolchain>"
  exit 1
fi

# Absolute paths
WORKSPACE_DIR=/workdir/workspace
TFM_SRC=/workdir//deps/trusted-firmware-m
TFM_TESTS=/workdir/deps/tf-m-tests/tests_reg
#MBEDTLS_DIR=/workdir/deps/mbedtls
#MCUBOOT_DIR=/workdir/deps/mcuboot
#QCBOR_DIR=/workdir/deps/QCBOR

echo "Building TF-M regression test:"
echo "  Platform: $PLATFORM"
echo "  Build type: $BUILD_TYPE"
echo "  Toolchain: $TOOLCHAIN"

# Step 1: Build SPE
BUILD_SPE_DIR=$WORKSPACE_DIR/app/$PLATFORM/reg_tests/build_spe
cmake -S $TFM_TESTS/spe -B $BUILD_SPE_DIR \
      -DTFM_PLATFORM=$PLATFORM \
      -DCONFIG_TFM_SOURCE_PATH=$TFM_SRC \
      -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
      -DTFM_TOOLCHAIN_FILE=$TFM_SRC/toolchain_${TOOLCHAIN}.cmake

cmake --build $BUILD_SPE_DIR -- install

# Step 2: Build Test
BUILD_TEST_DIR=$WORKSPACE_DIR/app/$PLATFORM/reg_tests/build_test
cmake -S $TFM_TESTS -B $BUILD_TEST_DIR \
      -DCONFIG_SPE_PATH=$BUILD_SPE_DIR/api_ns \
      -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
      -DTFM_TOOLCHAIN_FILE=$BUILD_SPE_DIR/api_ns/cmake/toolchain_ns_${TOOLCHAIN}.cmake

cmake --build $BUILD_TEST_DIR