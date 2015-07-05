#!/bin/bash
#########
#########75 step. Final Make install. 
#########
#6.61. Make-4.1
step_75_final_make_install ()
{

MAKE="make-4.1"
MAKE_SRC_FILE="$MAKE.tar.bz2"

if [ ! -f /sources/$MAKE_SRC_FILE ]; then
   wget -O /sources/$MAKE_SRC_FILE $REPOSITORY/$MAKE_SRC_FILE
fi

cd /sources
tar xjf $MAKE_SRC_FILE
cd $MAKE
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $MAKE
}