#!/usr/bin/env bash
set -eu -o pipefail

trap "echo ❌ Failed to build HIDAPI" ERR

cd hidapi
./bootstrap || ./bootstrap # It installs ltmain.sh in the wrong place the first time, then it copies into the right folder the second time...
./configure
sed '/AM_INIT_AUTOMAKE/{n;s/^/\#/}' configure.ac
make
cd ..

echo "✔️ Successfully built HIDAPI"
