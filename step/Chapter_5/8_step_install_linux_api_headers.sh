#!/bin/bash
#########
#########Eighth step. Linux API Headers. 
#########
#5.6. Linux API Headers
step_8_install_linux_api_headers ()
{
echo 'step_8_install_linux_api_headers' >> /tmp/log
LINUX="linux-4.0.1"
LINUX_SRC_FILE="$LINUX.tar.xz"

if [ ! -f $LFS/sources/$LINUX_SRC_FILE ]; then
   wget -O $LFS/sources/$LINUX_SRC_FILE $REPOSITORY/$LINUX_SRC_FILE
fi

cd $LFS/sources/
tar -xf $LINUX_SRC_FILE
cd $LINUX

make mrproper
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include
cd ..
rm -rf $LINUX
}
