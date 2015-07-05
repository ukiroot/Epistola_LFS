#!/bin/bash
#########
#########67 step. Final Xz install. 
#########
#6.53. Xz-5.2.0
step_67_final_xz_install ()
{

XZ="xz-5.2.0"
XZ_SRC_FILE="$XZ.tar.xz"

if [ ! -f /sources/$XZ_SRC_FILE ]; then
   wget -O /sources/$XZ_SRC_FILE $REPOSITORY/$XZ_SRC_FILE
fi

cd /sources
tar xf $XZ_SRC_FILE
cd $XZ
./configure --prefix=/usr --docdir=/usr/share/doc/$XZ
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so
cd ..
rm -rf $XZ
}

