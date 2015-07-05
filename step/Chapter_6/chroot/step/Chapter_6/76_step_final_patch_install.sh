#!/bin/bash
#########
#########76 step. Final Patch install. 
#########
#6.62. Patch-2.7.1
step_76_final_patch_install ()
{

PATCH="patch-2.7.1"
PATCH_SRC_FILE="$PATCH.tar.xz"

if [ ! -f /sources/$PATCH_SRC_FILE ]; then
   wget -O /sources/$PATCH_SRC_FILE $REPOSITORY/$PATCH_SRC_FILE
fi

cd /sources
tar xf $PATCH_SRC_FILE
cd $PATCH
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $PATCH
}