#!/bin/bash
step_37_install_xz ()
{
echo 'step_37_install_xz' >> /tmp/log

XZ="xz-5.2.0"
XZ_SRC_FILE="$XZ.tar.xz"

if [ ! -f $LFS/sources/$XZ_SRC_FILE ]; then
   wget -O $LFS/sources/$XZ_SRC_FILE $REPOSITORY/$XZ_SRC_FILE
fi

cd $LFS/sources/
tar -xf $XZ_SRC_FILE
cd ./$XZ
./configure --prefix=/tools
make -j$STREAM
make install
cd ..
rm -rf $XZ
}
