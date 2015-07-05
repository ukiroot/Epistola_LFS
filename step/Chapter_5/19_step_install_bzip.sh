#!/bin/bash
#########
step_19_install_bzip ()
{
echo 'step_19_install_bzip' >> /tmp/log

BZIP="bzip2-1.0.6"
BZIP_SRC_FILE="$BZIP.tar.gz"

if [ ! -f $LFS/sources/$BZIP_SRC_FILE ]; then
   wget -O $LFS/sources/$BZIP_SRC_FILE $REPOSITORY/$BZIP_SRC_FILE
fi

cd $LFS/sources/
tar zxf $BZIP_SRC_FILE
cd ./$BZIP
make -j$STREAM
make PREFIX=/tools install
cd ..
rm -rf $BZIP
}
