#!/usr/bin/env bash

set -e
set -o pipefail

BUILDTYPE=${BUILDTYPE:-Release}
JOBS=$((`nproc` + 2))

source ./scripts/travis_helper.sh

# Add Mason to PATH
export PATH="`pwd`/.mason:${PATH}"
export MASON_DIR="`pwd`/.mason"

# Activate the C++11 toolchain
source ./toolchain/env.sh

# Set the core file limit to unlimited so a core file is generated upon crash
ulimit -c unlimited -S

# Start the mock X server
if [ -f /etc/init.d/xvfb ] ; then
    mapbox_time "start_xvfb" \
    sh -e /etc/init.d/xvfb start
    sleep 2 # sometimes, xvfb takes some time to start up
fi

# Make sure we're connecting to xvfb
export DISPLAY=:99.0

# Make sure we're loading the 10.4.3 libs we installed manually
export LD_LIBRARY_PATH="`mason prefix mesa 10.4.3`/lib:${LD_LIBRARY_PATH:-}"

mapbox_time "glxinfo" \
glxinfo

# use g++ that supports c++11
if [[ ${CXX} == "g++" ]]; then
    export CXX="g++-4.8"
    export CC="gcc-4.8"
else
    export CXX="clang++-3.5"
    export CC="clang-3.5"
fi

echo \$ export CXX=${CXX}
echo \$ ${CXX} --version
${CXX} --version

echo \$ export CC=${CC}
echo \$ ${CC} --version
${CC} --version

# add node to PATH for running the test server
export PATH="`mason prefix node 0.10.35`/bin":"$PATH"


################################################################################
# Now build
################################################################################

mapbox_time "checkout_styles" \
git submodule update --init styles

mapbox_time "compile_program" \
make linux -j${JOBS} BUILDTYPE=${BUILDTYPE}

mapbox_time "compile_tests" \
make test -j${JOBS} BUILDTYPE=${BUILDTYPE}

mapbox_time "checkout_test_suite" \
git submodule update --init test/suite

mapbox_time "run_tests" \
make test-* BUILDTYPE=${BUILDTYPE}

mapbox_time "compare_results" \
./scripts/compare_images.sh

if [ ! -z "${AWS_ACCESS_KEY_ID}" ] && [ ! -z "${AWS_SECRET_ACCESS_KEY}" ] ; then
    # Add awscli to PATH for uploading the results
    export PATH="`python -m site --user-base`/bin:${PATH}"

    mapbox_time_start "deploy_results"
    (cd ./test/suite/ && ./bin/deploy_results.sh)
    mapbox_time_finish
fi
