#!/usr/bin/env bash

set -e
set -o pipefail

export TRAVIS_OS_NAME=linux
export FLAVOR=linux

cd build

export DISPLAY=:99.0
Xvfb :99 -ac -screen 0 1024x768x24 &

if [[ ${CXX} == "g++" ]]; then
    export CXX="g++-4.8"
    export CC="gcc-4.8"
fi

./scripts/${FLAVOR}/install.sh
./scripts/${FLAVOR}/run.sh
