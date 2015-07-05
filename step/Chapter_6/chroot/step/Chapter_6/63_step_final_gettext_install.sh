#!/bin/bash
#########
#########63 step. Final Gettext install. 
#########
#6.49. Gettext-0.19.4
step_63_final_gettext_install ()
{

GETTEXT="gettext-0.19.4"
GETTEXT_SRC_FILE="$GETTEXT.tar.xz"

if [ ! -f /sources/$GETTEXT_SRC_FILE ]; then
   wget -O /sources/$GETTEXT_SRC_FILE $REPOSITORY/$GETTEXT_SRC_FILE
fi

cd /sources
tar xf $GETTEXT_SRC_FILE
cd $GETTEXT
./configure --prefix=/usr --docdir=/usr/share/doc/$GETTEXT
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $GETTEXT
}
