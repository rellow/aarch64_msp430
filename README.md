# aarch64_msp430

This repo contains the `msp430` toolchain and dependencies as well as scripts for installing `mspdebug` on the Raspberry Pi.

## Navigate to the Repository

]$ cd /path/to/aarch64_msp430 < br/ >
]$ bash `install.sh`

## Modify the blink Makefile

]$ cd /path/to/aarch64_msp430/msp430_code_examples/blink

Edit the following Makefile paths to point to their correct location

MSP_TOOLS_HOME=/path/to/aarch64_msp430/msp430_toolchain/bin
MSP_SUPPORT_HOME=/path/to/aarch64_msp430/msp430_support_files

## Copy the blink Makefile to button

]$ cp /path/to/aarch64_msp430/msp430_code_examples/blink/Makefile /path/to/aarch64_msp430/msp430_code_examples/button/
