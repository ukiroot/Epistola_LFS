#!/bin/bash
#########
#########Sixth step. Installation of Cross Binutils. 
#########
#5.4.1. Installation of Cross Binutils
step_6_install_binutils ()
{
echo 'step_6_install_binutils' >> /tmp/log
BINUTILS="binutils-2.25"
BINUTILS_SRC_FILE="$BINUTILS.tar.bz2"

if [ ! -f $LFS/sources/$BINUTILS_SRC_FILE ]; then
   wget -O $LFS/sources/$BINUTILS_SRC_FILE $REPOSITORY/$BINUTILS_SRC_FILE
fi

cd $LFS/sources/
tar xjf $BINUTILS_SRC_FILE
mkdir -v ./binutils-build
cd ./binutils-build
../$BINUTILS/configure     \
    --prefix=/tools            \
    --with-sysroot=$LFS        \
    --with-lib-path=/tools/lib \
    --target=$LFS_TGT          \
    --disable-nls              \
    --disable-werror
make -j$STREAM
case $(uname -m) in
	x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac
make install
make clean
cd ..
rm -rf binutils-build
rm -rf $BINUTILS
}
