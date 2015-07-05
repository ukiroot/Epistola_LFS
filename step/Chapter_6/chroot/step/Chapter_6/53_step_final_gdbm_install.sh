#!/bin/bash
#########
#########53 step. Final GDBM install. 
#########
#6.39. GDBM-1.11
step_53_final_gdbm_install ()
{

GDBM="gdbm-1.11"
GDBM_SRC_FILE="$GDBM.tar.gz"

if [ ! -f /sources/$GDBM_SRC_FILE ]; then
   wget -O /sources/$GDBM_SRC_FILE $REPOSITORY/$GDBM_SRC_FILE
fi

cd /sources
tar zxf $GDBM_SRC_FILE
cd $GDBM
./configure --prefix=/usr --enable-libgdbm-compat
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $GDBM
}