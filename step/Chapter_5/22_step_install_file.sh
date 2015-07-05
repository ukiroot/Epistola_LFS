#!/bin/bash
#########
step_22_install_file ()
{
echo 'step_22_install_file' >> /tmp/log

FILE="file-5.22"
FILE_SRC_FILE="$FILE.tar.gz"

if [ ! -f $LFS/sources/$FILE_SRC_FILE ]; then
   wget -O $LFS/sources/$FILE_SRC_FILE $REPOSITORY/$FILE_SRC_FILE
fi

cd $LFS/sources/
tar zxf $FILE_SRC_FILE
cd ./$FILE
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $FILE
}
