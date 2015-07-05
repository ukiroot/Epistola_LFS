#!/bin/bash
#########
step_27_install_gzip ()
{
echo 'step_27_install_gzip' >> /tmp/log

GZIP="gzip-1.6"
GZIP_SRC_FILE="$GZIP.tar.xz"

if [ ! -f $LFS/sources/$GZIP_SRC_FILE ]; then
   wget -O $LFS/sources/$GZIP_SRC_FILE $REPOSITORY/$GZIP_SRC_FILE
fi

cd $LFS/sources/
tar -xf $GZIP_SRC_FILE
cd ./$GZIP
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $GZIP
}
