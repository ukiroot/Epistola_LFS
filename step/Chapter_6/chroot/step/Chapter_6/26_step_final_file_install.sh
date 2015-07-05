#!/bin/bash
#########
#########26 step. FInal file install. 
#########
#6.12. File-5.21
step_26_final_file_install ()
{
FILE="file-5.22"
FILE_SRC_FILE="$FILE.tar.gz"

if [ ! -f /sources/$FILE_SRC_FILE ]; then
   wget -O /sources/$FILE_SRC_FILE $REPOSITORY/$FILE_SRC_FILE
fi

cd /sources
tar zxf $FILE_SRC_FILE
cd $FILE
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $FILE
}