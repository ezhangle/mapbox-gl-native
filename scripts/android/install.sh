#!/usr/bin/env bash

set -e
set -o pipefail

source ./scripts/travis_helper.sh

mapbox_time "checkout_mason" \
git submodule update --init .mason

mapbox_time "install_awscli" \
pip install --user awscli

# Install Android SDK
if [ ! -f ./android/sdk/tools/android ] ; then
    ANDROID_SDK_PLATFORM=`uname -s`
    if [ `uname -s` == 'Darwin' ]; then
        ANDROID_SDK_FILENAME=android-sdk_r24.0.2-macosx.zip
        if [ ! -f ${ANDROID_SDK_FILENAME} ] ; then
            curl --retry 3 -f -L http://dl.google.com/android/${ANDROID_SDK_FILENAME} -o ${ANDROID_SDK_FILENAME}
        fi
        echo "3ab5e0ab0db5e7c45de9da7ff525dee6cfa97455  ${ANDROID_SDK_FILENAME}" | shasum -c
        mkdir -p android/sdk
        unzip -q ${ANDROID_SDK_FILENAME}
        mv android-sdk-macosx/* ./android/sdk/
        rm -rf android-sdk-macosx
    else
        ANDROID_SDK_FILENAME=android-sdk_r24.0.2-linux.tgz
        if [ ! -f ${ANDROID_SDK_FILENAME} ] ; then
            curl --retry 3 -f -L http://dl.google.com/android/${ANDROID_SDK_FILENAME} -o ${ANDROID_SDK_FILENAME}
        fi
        echo "b6fd75e8b06b0028c2427e6da7d8a09d8f956a86  ${ANDROID_SDK_FILENAME}" | shasum -c
        mkdir -p android/sdk
        tar xzf ${ANDROID_SDK_FILENAME} -C android/sdk --strip-components=1
    fi

    scripts/android/accept_licenses.sh \
        "./android/sdk/tools/android update sdk --no-ui --all --filter tools,platform-tools,build-tools-21.1.2,android-21" \
        "android-sdk-license-5be876d5"

    rm -rf ./android/sdk/temp
fi


