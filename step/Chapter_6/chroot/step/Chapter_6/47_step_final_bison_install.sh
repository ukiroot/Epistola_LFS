#!/bin/bash
#########
#########47 step. Final Bison install. 
#########
#6.33. Bison-3.0.2
step_47_final_bison_install ()
{

BISON="bison-3.0.4"
BISON_SRC_FILE="$BISON.tar.xz"

if [ ! -f /sources/$BISON_SRC_FILE ]; then
   wget -O /sources/$BISON_SRC_FILE $REPOSITORY/$BISON_SRC_FILE
fi

cd /sources
tar xf $BISON_SRC_FILE
cd $BISON
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $BISON
}