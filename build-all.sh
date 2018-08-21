#!/bin/sh

export JDK_VERSIONS
export INSTALL_DEPS
export CLEANUP

JDK_VERSIONS=$(grep -v slim jdk-versions | grep -v alpine)
./build.sh


JDK_VERSIONS=$(grep slim jdk-versions)
INSTALL_DEPS='apt-get update && apt-get install -y curl'
CLEANUP='apt-get purge -y curl && apt-get --purge -y autoremove && rm -rf /var/lib/apt/lists/*'
./build.sh

JDK_VERSIONS=$(grep alpine jdk-versions)
INSTALL_DEPS='apk add --no-cache --virtual .build-deps curl unzip'
CLEANUP='apk del .build-deps'
./build.sh
