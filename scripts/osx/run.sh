#!/usr/bin/env bash

set -e
set -o pipefail

BUILDTYPE=${BUILDTYPE:-Release}
JOBS=$((`sysctl -n hw.ncpu` + 2))

source ./scripts/travis_helper.sh

# Add Mason to PATH
export PATH="`pwd`/.mason:${PATH}"
export MASON_DIR="`pwd`/.mason"


################################################################################
# Now build
################################################################################

mapbox_time "checkout_styles" \
git submodule update --init styles

mapbox_time "build_osx_project" \
make xosx -j${JOBS}

mapbox_time "build_ios_project_device_release" \
make ios -j${JOBS}

mapbox_time "build_ios_project_simulator_debug" \
make isim -j${JOBS}
