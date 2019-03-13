#!/usr/bin/env bash

set -euo pipefail

deps=(
    build-essential
    cmake
    libssl-dev
    openjdk-8-jdk
    pkgconf
    zlib1g-dev
)
[ -e "/hadoop-${hadoop_version}-src/hadoop-hdfs-project/hadoop-hdfs-native-client/src/main/native/libhdfspp" ] && deps+=( libgsasl7-dev )

apt -y update && apt -y install "${deps[@]}"
