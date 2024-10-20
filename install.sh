#!/bin/bash

WORKING_PATH="$(cd "$(dirname -- "$1")" >/dev/null; pwd -P)/$(basename -- "$1")"
WORKING_PATH_ESC=$(printf '%s\n' "$WORKING_PATH" | sed -e 's/[\/&]/\\&/g')

## GET AND BUILD BOOST
wget https://archives.boost.io/release/1.82.0/source/boost_1_82_0.tar.bz2
tar --bzip2 -xf boost_1_82_0.tar.bz2
cd boost_1_82_0
./bootstrap.sh
./b2 cxxflags=-fPIC cflags=-fPIC
cd ..

mkdir rpi_msp430 && cd rpi_msp430
# DOWNLOAD REQUIREMENTS
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y libusb-1.0 libudev-dev mspdebug

# BUILD HIDAPI
git clone https://github.com/signal11/hidapi.git
cd hidapi
sed -i '/AM\_INIT\_AUTOMAKE/{n;s/^/\#/}' configure.ac
./bootstrap || ./bootstrap # It installs ltmain.sh in the wrong place the first time, then it copies into the right folder the second time...
./configure
make
cd ..

# BUILD LIBMSP430
curl -L https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPDS/3_15_1_001/export/MSPDebugStack_OS_Package_3_15_1_1.zip --output mspds.zip
unzip -q -o mspds.zip -d mspds
cp hidapi/hidapi/hidapi.h mspds/ThirdParty/include
cp hidapi/libusb/hid.o mspds/ThirdParty/lib/hid-libusb.o
cp hidapi/libusb/hid.o mspds/ThirdParty/lib64/hid-libusb.o
cd mspds
make STATIC=1 BOOST_DIR=$WORKING_PATH/boost_1_82_0
sudo cp libmsp430.so /usr/lib/libmsp430.so
cd ../..

# BUILD MSP430-GCC
wget https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-LlCjWuAbzH/9.3.1.2/msp430-gcc-9.3.1.11-source-full.tar.bz2
tar --bzip2 -xf msp430-gcc-9.3.1.11-source-full.tar.bz2
cd msp430-gcc-9.3.1.11-source-full
sed -i '88s/.*/make -j \`nproc\`/' README-build.sh
sed -i '98s/.*/make -j \`nproc\`/' README-build.sh
sed -i '107s/.*/make -j \`nproc\`/' README-build.sh
sed -i '111,142 {s/^/#/}' README-build.sh
bash README-build.sh
cd ..

# GET MSP430-GCC SUPPORT FILES
wget https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-LlCjWuAbzH/9.3.1.2/msp430-gcc-support-files-1.212.zip
unzip msp430-gcc-support-files-1.212.zip

# UPDATE MAKEFILES
cd msp430_code_examples/blink
sed -i "3s/.*/MSP\_TOOLS\_HOME="$WORKING_PATH_ESC"msp430-gcc-9.3.1.11-source-full\/install\/usr\/local\/bin/" Makefile
sed -i "4s/.*/MSP\_SUPPORT\_HOME="$WORKING_PATH_ESC"msp430-gcc-support-files/" Makefile

