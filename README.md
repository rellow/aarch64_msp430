# aarch64_msp430

This repo contains the `msp430` toolchain and dependencies as well as scripts for installing `mspdebug` on the Raspberry Pi.

## Add LIBBOOST to LD_LIBRARY_PATH

]$ LD_LIBRARY_PATH=/path/to/libboost/lib:$LD_LIBRARY_PATH

## Setup

]$ bash `setup.sh`

If it runs successfully then you can execute `mspdebug` with your MSP430 board connected to your RPi

## Modify the blink Makefile

]$ cd /path/to/aarch64_msp430/msp430_code_examples/blink

Edit the following Makefile paths to point to their correct location

MSP_TOOLS_HOME=/path/to/aarch64_msp430/msp430_toolchain/bin
MSP_SUPPORT_HOME=/path/to/aarch64_msp430/msp430_support_files

## Copy the blink Makefile to button

]$ cp /path/to/aarch64_msp430/msp430_code_examples/blink/Makefile /path/to/aarch64_msp430/msp430_code_examples/button/
