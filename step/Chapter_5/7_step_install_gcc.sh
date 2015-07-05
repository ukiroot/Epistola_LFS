#!/bin/bash
#########
#########Seventh step. Installation of Cross GCC. 
#########
#5.5.1. Installation of Cross GCC
 
 step_7_install_gcc ()
{
echo 'step_7_install_gcc' >> /tmp/log
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

#sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

mkdir -v ../gcc-build
cd ../gcc-build

../gcc-5.1.0/configure                             \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libitm                               \
    --disable-libquadmath                          \
    --disable-libsanitizer                         \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libcilkrts                           \
    --disable-libstdc++-v3                         \
    --enable-languages=c,c++
    
make -j$STREAM
make install
make clean
cd ..
rm -rf gcc-build
rm -rf $GCC
}
