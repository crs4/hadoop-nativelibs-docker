#!/usr/bin/env bash

set -euo pipefail

# Maven
mkdir -p "${maven_home}"
mv /apache-maven-${maven_version}/* "${maven_home}"/
cat >/etc/profile.d/maven.sh <<EOF
export M2_HOME="${maven_home}"
export M2="\${M2_HOME}/bin"
export PATH="\${M2}:\${PATH}"
EOF

# Protobuf
pushd /protobuf-${protobuf_version}
./configure
make -j$(nproc)
make install
ldconfig
popd
