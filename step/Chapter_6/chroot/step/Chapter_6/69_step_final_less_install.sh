#!/bin/bash
#########
#########69 step. Final Less install. 
#########
#6.55. Less-458
step_69_final_less_install ()
{

LESS="less-458"
LESS_SRC_FILE="$LESS.tar.gz"

if [ ! -f /sources/$LESS_SRC_FILE ]; then
   wget -O /sources/$LESS_SRC_FILE $REPOSITORY/$LESS_SRC_FILE
fi

cd /sources
tar zxf $LESS_SRC_FILE
cd $LESS
./configure --prefix=/usr --sysconfdir=/etc
make -j$STREAM
make install
cd ..
rm -rf $LESS
}

