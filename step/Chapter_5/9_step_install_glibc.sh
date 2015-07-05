#!/bin/bash
#########
#########Ninth step. Glibc. 
#########
#5.7. Glibc. 
step_9_install_glibc ()
{
echo 'step_9_install_glibc' >> /tmp/log
GLIBC="glibc-2.21"
GLIBC_SRC_FILE="$GLIBC.tar.xz"

if [ ! -f $LFS/sources/$GLIBC_SRC_FILE ]; then
   wget -O $LFS/sources/$GLIBC_SRC_FILE $REPOSITORY/$GLIBC_SRC_FILE
fi

cd $LFS/sources/

tar -xf $GLIBC_SRC_FILE

sed -e '/ia32/s/^/1:/' \
    -e '/SSE2/s/^1://' \
    -i  $GLIBC/sysdeps/i386/i686/multiarch/mempcpy_chk.S


mkdir -v ./glibc-build
cd ./glibc-build
../$GLIBC/configure                             \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.21/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --enable-obsolete-rpc                         \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes
      
make -j$STREAM
make install
make clean
cd ..
rm -rf glibc-build
rm -rf $GLIBC
}
