#!/bin/bash
#########
#########25 step. Final zlib install. 
#########
#6.11. Zlib-1.2.8

step_25_final_zlib_install ()
{
ZLIB="zlib-1.2.8"
ZLIB_SRC_FILE="$ZLIB.tar.xz"
if [ ! -f /sources/$ZLIB_SRC_FILE ]; then
   wget -O /sources/$ZLIB_SRC_FILE $REPOSITORY/$ZLIB_SRC_FILE
fi

cd /sources
tar xf $ZLIB_SRC_FILE
cd $ZLIB
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so
cd ..
rm -rf $ZLIB
}