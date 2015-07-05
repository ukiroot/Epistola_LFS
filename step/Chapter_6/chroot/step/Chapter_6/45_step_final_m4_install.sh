#!/bin/bash
#########
#########45 step. Final M4 install. 
#########
#6.31. M4-1.4.17
step_45_final_m4_install ()
{

MFOUR="m4-1.4.17"
MFOUR_SRC_FILE="$MFOUR.tar.xz"

if [ ! -f /sources/$MFOUR_SRC_FILE ]; then
   wget -O /sources/$MFOUR_SRC_FILE $REPOSITORY/$MFOUR_SRC_FILE
fi

cd /sources
tar xf $MFOUR_SRC_FILE
cd $MFOUR
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $MFOUR
}

