#!/bin/bash
#########
step_28_install_mfour ()
{
echo 'step_28_install_mfour' >> /tmp/log

MFOUR="m4-1.4.17"
MFOUR_SRC_FILE="$MFOUR.tar.xz"

if [ ! -f $LFS/sources/$MFOUR_SRC_FILE ]; then
   wget -O $LFS/sources/$MFOUR_SRC_FILE $REPOSITORY/$MFOUR_SRC_FILE
fi

cd $LFS/sources/
tar -xf $MFOUR_SRC_FILE
cd ./$MFOUR
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $MFOUR
}
