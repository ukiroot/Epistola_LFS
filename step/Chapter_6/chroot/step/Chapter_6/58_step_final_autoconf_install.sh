#!/bin/bash
#########
#########58 step. Final Autoconf install. 
#########
step_58_final_autoconf_install ()
{

AUTOCONF=" autoconf-2.69"
AUTOCONF_SRC_FILE="$AUTOCONF.tar.xz"

if [ ! -f /sources/$AUTOCONF_SRC_FILE ]; then
   wget -O /sources/$AUTOCONF_SRC_FILE $REPOSITORY/$AUTOCONF_SRC_FILE
fi


cd /sources
tar xf $AUTOCONF_SRC_FILE
cd $AUTOCONF
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $AUTOCONF
}
