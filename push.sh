#!/usr/bin/env bash

set -euo pipefail

repo=crs4/hadoop-nativelibs

echo "${CI_PASS}" | docker login -u "${CI_USER}" --password-stdin
docker push ${repo}:${HADOOP_VERSION}-${OS}

if [ -n "${SHORT_TAG:-}" ]; then
    docker tag ${repo}:${HADOOP_VERSION}-${OS} ${repo}:${SHORT_TAG}
    docker push ${repo}:${SHORT_TAG}
fi

if [ -n "${LATEST:-}" ]; then
    docker tag ${repo}:${HADOOP_VERSION}-${OS} ${repo}:latest
    docker push ${repo}:latest
fi
