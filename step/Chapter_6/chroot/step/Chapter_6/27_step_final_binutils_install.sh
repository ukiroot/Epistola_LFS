#!/bin/bash
#########
#########27 step. Final binutils install. 
#########
#6.13. Binutils-2.25
step_27_final_binutils_install ()
{

BINUTILS="binutils-2.25"
BINUTILS_SRC_FILE="$BINUTILS.tar.bz2"

if [ ! -f /sources/$BINUTILS_SRC_FILE ]; then
   wget -O /sources/$BINUTILS_SRC_FILE $REPOSITORY/$BINUTILS_SRC_FILE
fi

cd /sources
tar xjf $BINUTILS_SRC_FILE
mkdir -v ./binutils-build
cd ./binutils-build
../$BINUTILS/configure --prefix=/usr   \
                           --enable-shared \
                           --disable-werror
make -j$STREAM tooldir=/usr
if [ "$1" == "test" ] ; then
	make -k check
fi
make tooldir=/usr install
cd ..
rm -rf binutils-build
rm -rf $BINUTILS
}

