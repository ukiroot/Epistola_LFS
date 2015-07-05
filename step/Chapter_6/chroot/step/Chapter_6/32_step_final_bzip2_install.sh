#!/bin/bash
#########
#########32 step. Final Bzip2 install. 
#########
#6.18. Bzip2-1.0.6
step_32_final_bzip2_install ()
{
BZIP="bzip2-1.0.6"
BZIP_SRC_FILE="$BZIP.tar.gz"
if [ ! -f /sources/$BZIP_SRC_FILE ]; then
   wget -O /sources/$BZIP_SRC_FILE $REPOSITORY/$BZIP_SRC_FILE
fi
BZIP_PATCH_1="bzip2-1.0.6-install_docs-1.patch"
if [ ! -f /sources/$BZIP_PATCH_1 ]; then
   wget -O /sources/$BZIP_PATCH_1 $REPOSITORY/$BZIP_PATCH_1
fi

cd /sources
tar zxf $BZIP_SRC_FILE
cd $BZIP
patch -Np1 -i ../$BZIP_PATCH_1
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -f Makefile-libbz2_so
make clean

make -j$STREAM
make PREFIX=/usr install

cp -v bzip2-shared /bin/bzip2
cp -av libbz2.so* /lib
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
ln -sv bzip2 /bin/bunzip2
ln -sv bzip2 /bin/bzcat
cd ..
rm -rf $BZIP
}
