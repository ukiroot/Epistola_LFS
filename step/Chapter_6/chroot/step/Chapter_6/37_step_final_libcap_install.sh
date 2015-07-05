#!/bin/bash
#########
#########37 step. Final Libcap instal. 
#########
#6.23. Libcap-2.24
step_37_final_libcap_install ()
{

LIBCAP="libcap-2.24"
LIBCAP_SRC_FILE="$LIBCAP.tar.xz"
if [ ! -f /sources/$LIBCAP_SRC_FILE ]; then
   wget -O /sources/$LIBCAP_SRC_FILE $REPOSITORY/$LIBCAP_SRC_FILE
fi

cd /sources
tar xf $LIBCAP_SRC_FILE
cd $LIBCAP
make -j$STREAM
make RAISE_SETFCAP=no prefix=/usr install
chmod -v 755 /usr/lib/libcap.so
mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so
cd ..
rm -rf $LIBCAP
}
