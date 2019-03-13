#!/usr/bin/env bash

# Recent Hadoop versions fail to copy hdfs libs to the dist dir

set -euo pipefail

src=/hadoop-${hadoop_version}-src

for name in hdfs hdfspp; do
    if [ ! -e "${target}"/lib${name}.so ]; then
	echo "searching for lib${name}"
	loc=$(find ${src} -name lib${name}.so -print -quit)
	if [ -n "${loc}" ]; then
	    parent=$(dirname "${loc}")
	    echo "  getting from ${parent}"
	    mv -f "${parent}"/lib${name}.* "${target}"
	fi
    fi
done
