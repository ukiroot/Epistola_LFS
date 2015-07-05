#!/bin/bash
#########
#########52 step. Final Libtool install. 
#########
#6.38. Libtool-2.4.4
step_52_final_libtool_install ()
{

LIBTOOL="libtool-2.4.6"
LIBTOOL_SRC_FILE="$LIBTOOL.tar.xz"

if [ ! -f /sources/$LIBTOOL_SRC_FILE ]; then
   wget -O /sources/$LIBTOOL_SRC_FILE $REPOSITORY/$LIBTOOL_SRC_FILE
fi

cd /sources
tar xf $LIBTOOL_SRC_FILE
cd $LIBTOOL
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $LIBTOOL
}
