#!/bin/bash
#########
step_23_install_findutils ()
{
echo 'step_23_install_findutils' >> /tmp/log

FINDUTILS="findutils-4.4.2"
FINDUTILS_SRC_FILE="$FINDUTILS.tar.gz"

if [ ! -f $LFS/sources/$FINDUTILS_SRC_FILE ]; then
   wget -O $LFS/sources/$FINDUTILS_SRC_FILE $REPOSITORY/$FINDUTILS_SRC_FILE
fi

cd $LFS/sources/
tar zxf $FINDUTILS_SRC_FILE
cd ./$FINDUTILS
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $FINDUTILS
}
