#!/bin/bash
#########
#########Eleven step. Install Binutils pass 2. 
#########
#5.9. Binutils-2.25 - Pass 2
step_11_install_binutils_pass_two ()
{
echo 'step_11_install_binutils_pass_two' >> /tmp/log
BINUTILS="binutils-2.25"
BINUTILS_SRC_FILE="$BINUTILS.tar.bz2"

if [ ! -f $LFS/sources/$BINUTILS_SRC_FILE ]; then
   wget -O $LFS/sources/$BINUTILS_SRC_FILE $REPOSITORY/$BINUTILS_SRC_FILE
fi

cd $LFS/sources
tar xjf $BINUTILS_SRC_FILE
mkdir -v ./binutils-build
cd ./binutils-build

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../$BINUTILS/configure     \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot


make -j$STREAM
make install
make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin
make clean
cd ..
rm -rf binutils-build
rm -rf $BINUTILS
}
