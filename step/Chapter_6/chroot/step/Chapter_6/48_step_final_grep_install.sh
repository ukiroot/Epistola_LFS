#!/bin/bash
#########
#########48 step. Final Grep install. 
#########
#6.34. Grep-2.21
step_48_final_grep_install ()
{

GREP="grep-2.21"
GREP_SRC_FILE="$GREP.tar.xz"

if [ ! -f /sources/$GREP_SRC_FILE ]; then
   wget -O /sources/$GREP_SRC_FILE $REPOSITORY/$GREP_SRC_FILE
fi

cd /sources
tar xf $GREP_SRC_FILE
cd $GREP
./configure --prefix=/usr --bindir=/bin
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $GREP
}
