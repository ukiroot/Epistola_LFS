#!/bin/bash
#########
step_30_install_patch ()
{
echo 'step_30_install_patch' >> /tmp/log

PATCH="patch-2.7.4"
PATCH_SRC_FILE="$PATCH.tar.xz"

if [ ! -f $LFS/sources/$PATCH_SRC_FILE ]; then
   wget -O $LFS/sources/$PATCH_SRC_FILE $REPOSITORY/$PATCH_SRC_FILE
fi

cd $LFS/sources/
tar -xf $PATCH_SRC_FILE
cd ./$PATCH
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $PATCH
}
