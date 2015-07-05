#!/bin/bash
#########
#########54 step. Final Expat install. 
#########
#6.40. Expat-2.1.0
step_54_final_expat_install ()
{

EXPAT="expat-2.1.0"
EXPAT_SRC_FILE="$EXPAT.tar.gz"

if [ ! -f /sources/$EXPAT_SRC_FILE ]; then
   wget -O /sources/$EXPAT_SRC_FILE $REPOSITORY/$EXPAT_SRC_FILE
fi

cd /sources
tar zxf $EXPAT_SRC_FILE
cd $EXPAT
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install

install -v -dm755 /usr/share/doc/$EXPAT
install -v -m644 doc/*.{html,png,css} /usr/share/doc/$EXPAT
cd ..
rm -rf $EXPAT
}