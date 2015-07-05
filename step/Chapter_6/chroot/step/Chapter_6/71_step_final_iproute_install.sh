#!/bin/bash
#########
#########71 step. Final IPRoute install. 
#########
#6.57. IPRoute2-3.18.0
step_71_final_iproute_install ()
{

IPROUTE2="iproute2-3.18.0"
IPROUTE2_SRC_FILE="$IPROUTE2.tar.xz"

if [ ! -f /sources/$IPROUTE2_SRC_FILE ]; then
   wget -O /sources/$IPROUTE2_SRC_FILE $REPOSITORY/$IPROUTE2_SRC_FILE
fi

cd /sources
tar xf $IPROUTE2_SRC_FILE
cd $IPROUTE2
sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile
make -j$STREAM
make DOCDIR=/usr/share/doc/$IPROUTE2 install
cd ..
rm -rf $IPROUTE2
}
