#!/bin/bash
#########
#########59 step. Final Automake install. 
#########
#6.45. Automake-1.14.1
step_59_final_automake_install ()
{


AUTOMAKE="automake-1.14.1"
AUTOMAKE_SRC_FILE="$AUTOMAKE.tar.xz"

if [ ! -f /sources/$AUTOMAKE_SRC_FILE ]; then
   wget -O /sources/$AUTOMAKE_SRC_FILE $REPOSITORY/$AUTOMAKE_SRC_FILE
fi

cd /sources
tar xf $AUTOMAKE_SRC_FILE
cd $AUTOMAKE
./configure --prefix=/usr --docdir=/usr/share/doc/$AUTOMAKE
make -j$STREAM

if [ "$1" == "test" ] ; then
	sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
	make -j4 check
fi
make install
cd ..
rm -rf $AUTOMAKE
}
