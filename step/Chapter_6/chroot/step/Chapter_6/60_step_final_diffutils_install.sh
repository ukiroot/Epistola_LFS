#!/bin/bash
#########
#########60 step. Final Diffutils install. 
#########
#6.46. Diffutils-3.3
step_60_final_diffutils_install ()
{

DIFFUTILS="diffutils-3.3"
DIFFUTILS_SRC_FILE="$DIFFUTILS.tar.xz"

if [ ! -f /sources/$DIFFUTILS_SRC_FILE ]; then
   wget -O /sources/$DIFFUTILS_SRC_FILE $REPOSITORY/$DIFFUTILS_SRC_FILE
fi

cd /sources
tar xf $DIFFUTILS_SRC_FILE
cd $DIFFUTILS
sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in
./configure --prefix=/usr
make -j$STREAM

if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $DIFFUTILS
}