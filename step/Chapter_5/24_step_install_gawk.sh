#!/bin/bash
#########
step_24_install_gawk ()
{
echo 'step_24_install_gawk' >> /tmp/log

GAWK="gawk-4.1.1"
GAWK_SRC_FILE="$GAWK.tar.xz"

if [ ! -f $LFS/sources/$GAWK_SRC_FILE ]; then
   wget -O $LFS/sources/$GAWK_SRC_FILE $REPOSITORY/$GAWK_SRC_FILE
fi

cd $LFS/sources/
tar -xf $GAWK_SRC_FILE
cd ./$GAWK
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $GAWK
}
