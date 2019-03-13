#!/usr/bin/env bash

set -euo pipefail

pushd /hadoop-${hadoop_version}-src
grep -rq __WAIT_STATUS . && patch -p1 < /YARN-8498-02.patch
if [ ${hadoop_version%%.*} -lt 3 ]; then
    # patch might be ported to Hadoop 2 eventually, so ignore any failures
    patch -p1 < /HADOOP-14597.04.patch || :
fi
mvn -q -B package -Pdist,native -DskipTests -Dtar
mkdir -p "${target}" && rmdir "${target}"
mv hadoop-dist/target/hadoop-${hadoop_version}/lib/native "${target}"
popd
