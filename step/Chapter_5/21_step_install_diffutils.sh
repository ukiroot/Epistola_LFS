#!/bin/bash
#########
step_21_install_diffutils ()
{
echo 'step_21_install_diffutils' >> /tmp/log

DIFFUTILS="diffutils-3.3"
DIFFUTILS_SRC_FILE="$DIFFUTILS.tar.xz"

if [ ! -f $LFS/sources/$DIFFUTILS_SRC_FILE ]; then
   wget -O $LFS/sources/$DIFFUTILS_SRC_FILE $REPOSITORY/$DIFFUTILS_SRC_FILE
fi

cd $LFS/sources/
tar -xf $DIFFUTILS_SRC_FILE
cd ./$DIFFUTILS
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $DIFFUTILS
}
