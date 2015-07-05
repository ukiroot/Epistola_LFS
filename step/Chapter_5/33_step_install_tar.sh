#!/bin/bash
#########
step_33_install_tar ()
{
echo 'step_33_install_tar' >> /tmp/log

TAR="tar-1.28"
TAR_SRC_FILE="$TAR.tar.xz"

if [ ! -f $LFS/sources/$TAR_SRC_FILE ]; then
   wget -O $LFS/sources/$TAR_SRC_FILE $REPOSITORY/$TAR_SRC_FILE
fi

cd $LFS/sources/
tar -xf $TAR_SRC_FILE
cd ./$TAR
#If run from root ned set FORCE_UNSAFE_CONFIGURE in 1
FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $TAR
}
