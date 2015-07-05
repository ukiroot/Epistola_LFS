#!/bin/bash
#########
#########61 step. Final Gawk install. 
#########
#6.47. Gawk-4.1.1
step_61_final_gawk_install ()
{

GAWK="gawk-4.1.1"
GAWK_SRC_FILE="$GAWK.tar.xz"

if [ ! -f /sources/$GAWK_SRC_FILE ]; then
   wget -O /sources/$GAWK_SRC_FILE $REPOSITORY/$GAWK_SRC_FILE
fi

cd /sources
tar xf $GAWK_SRC_FILE
cd $GAWK
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
mkdir -v /usr/share/doc/$GAWK
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/$GAWK
cd ..
rm -rf $GAWK
}