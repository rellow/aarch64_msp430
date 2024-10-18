#!/usr/bin/env bash
set -eu -o pipefail

trap "echo ❌ Something failed" ERR

$SHELL steps/download_mspds.sh
$SHELL steps/clone_hidapi.sh
$SHELL steps/install_apt_packages.sh
$SHELL steps/build_hidapi.sh
$SHELL steps/build_libmsp430.sh

echo ✔️ All OK, now try running mspdebug!
