#!/bin/bash
#########
#########65 step. Final Gperf install. 
#########
#6.51. Gperf-3.0.4
step_65_final_gperf_install ()
{

GPERF="gperf-3.0.4"
GPERF_SRC_FILE="$GPERF.tar.gz"

if [ ! -f /sources/$GPERF_SRC_FILE ]; then
   wget -O /sources/$GPERF_SRC_FILE $REPOSITORY/$GPERF_SRC_FILE
fi

cd /sources
tar zxf $GPERF_SRC_FILE
cd $GPERF
./configure --prefix=/usr --docdir=/usr/share/doc/$GPERF
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $GPERF
}
