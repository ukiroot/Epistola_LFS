#!/bin/bash
#########
#########74 step. Final Libpipeline install.
#########
#6.60. Libpipeline-1.4.0
step_74_final_libpipeline_install ()
{

LIBPIPELINE="libpipeline-1.4.0"
LIBPIPELINE_SRC_FILE="$LIBPIPELINE.tar.gz"

if [ ! -f /sources/$LIBPIPELINE_SRC_FILE ]; then
   wget -O /sources/$LIBPIPELINE_SRC_FILE $REPOSITORY/$LIBPIPELINE_SRC_FILE
fi

cd /sources
tar zxf $LIBPIPELINE_SRC_FILE
cd $LIBPIPELINE
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $LIBPIPELINE
}