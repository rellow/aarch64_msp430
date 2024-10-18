#!/bin/bash

## GET AND BUILD BOOST
wget https://archives.boost.io/release/1.82.0/source/
tar --bzip2 -xf boost_1_82_0.tar.bz2
cd boost_1_82_0
./bootstrap.sh
./b2 cxxflags=-fPIC cflags=-fPIC
cd ..

cd rpi_msp430
# DOWNLOAD REQUIREMENTS
curl -L https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPDS/3_15_1_001/export/MSPDebugStack_OS_Package_3_15_1_1.zip --output mspds.zip
unzip -q -o mspds.zip -d mspds
git clone https://github.com/signal11/hidapi.git
DEBIAN_FRONTEND=noninteractive sudo apt-get isntall -y libusb-1.0 libudev-dev mspdebug

# BUILD HIDAPI
cd hidapi
sed -i '/AM\_INIT\_AUTOMAKE/{n;s/^/\#/}' configure.ac
./bootstrap || ./bootstrap # It installs ltmain.sh in the wrong place the first time, then it copies into the right folder the second time...
./configure
make
cd ..

# BUILD LIBMSP430
cp hidapi/hidapi/hidapi.h mspds/ThirdParty/include
cp hidapi/libusb/hid.o mspds/ThirdParty/lib/hid-libusb.o
cp hidapi/libusb/hid.o mspds/ThirdParty/lib64/hid-libusb.o
cd mspds
make STATIC=1 BOOST_DIR=../../boost_1_82_0
sudo cp libmsp430.so /usr/lib/libmsp430.so
