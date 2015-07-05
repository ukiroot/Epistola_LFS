#!/bin/bash
#########
#########Twelfth step. Installation of GCC Pass 2. 
#########
#5.10.1. Installation of GCC Pass 2
step_12_install_gcc_pass_two ()
{
echo 'step_12_install_gcc_pass_two' >> /tmp/log

GCC="gcc-5.1.0"
GCC_SRC_FILE="$GCC.tar.bz2"
MPFR="mpfr-3.1.2"
MPFR_SRC_FILE="$MPFR.tar.xz"
GMP="gmp-6.0.0"
GMP_SRC_FILE="$GMP""a.tar.xz"
MPC="mpc-1.0.3"
MPC_SRC_FILE="$MPC.tar.gz"

if [ ! -f $LFS/sources/$GCC_SRC_FILE ]; then
   wget -O $LFS/sources/$GCC_SRC_FILE $REPOSITORY/$GCC_SRC_FILE
fi

if [ ! -f $LFS/sources/$MPFR_SRC_FILE ]; then
   wget -O $LFS/sources/$MPFR_SRC_FILE $REPOSITORY/$MPFR_SRC_FILE
fi

if [ ! -f $LFS/sources/$GMP_SRC_FILE ]; then
   wget -O $LFS/sources/$GMP_SRC_FILE $REPOSITORY/$GMP_SRC_FILE
fi

if [ ! -f $LFS/sources/$MPC_SRC_FILE ]; then
   wget -O $LFS/sources/$MPC_SRC_FILE $REPOSITORY/$MPC_SRC_FILE
fi

cd $LFS/sources/
tar xjf $GCC_SRC_FILE
cd $LFS/sources/$GCC

tar -xf ../$MPFR_SRC_FILE
mv -v $MPFR mpfr

tar -xf ../$GMP_SRC_FILE
mv -v $GMP gmp

tar -xf ../$MPC_SRC_FILE
mv -v $MPC mpc

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h
  
for file in \
 $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done

mkdir -v ../gcc-build
cd ../gcc-build

CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../$GCC/configure                             \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp

    
make -j$STREAM
make install
ln -sv gcc /tools/bin/cc

make clean
cd ..
rm -rf gcc-build
rm -rf $GCC
}
