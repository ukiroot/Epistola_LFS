#!/bin/bash
#########
#########Tenth step. Install Libstdc++-4.9.2. 
#########
#5.8. Libstdc++-4.9.2
step_10_install_libstdc ()
{
echo 'step_10_install_libstdc' >> /tmp/log
GCC="gcc-5.1.0"
GCCV="5.1.0"
GCC_FILE_SRC="$GCC.tar.bz2"

if [ ! -f $LFS/sources/$GCC_FILE_SRC ]; then
   wget -O $LFS/sources/$GCC_FILE_SRC $REPOSITORY/$GCC_FILE_SRC
fi

cd $LFS/sources
tar xjf $GCC_FILE_SRC
mkdir -pv ./gcc-build
cd ./gcc-build

../gcc-5.1.0/libstdc++-v3/configure \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/5.1.0


make -j$STREAM
make install
make clean
cd ..
rm -rf gcc-build
rm -rf $GCC
}
