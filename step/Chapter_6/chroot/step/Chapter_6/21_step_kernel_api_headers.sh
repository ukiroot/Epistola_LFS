#!/bin/bash
#########
#########21 step. Linux-3.18.1 API Headers. 
#########
#6.7. Linux-3.18.1 API Headers
step_21_kernel_api_headers ()
{


LINUX="linux-4.0.1"
LINUX_SRC_FILE="$LINUX.tar.xz"

if [ ! -f /sources/$LINUX_SRC_FILE ]; then
   wget -O /sources/$LINUX_SRC_FILE $REPOSITORY/$LINUX_SRC_FILE
fi

cd /sources/
tar -xf $LINUX_SRC_FILE
cd $LINUX


make mrproper
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include
cd ..
rm -rf $LINUX
}