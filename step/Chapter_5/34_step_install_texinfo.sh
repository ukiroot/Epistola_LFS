#!/bin/bash
#########
step_34_install_texinfo ()
{
echo 'step_34_install_texinfo' >> /tmp/log

TEXTINFO="texinfo-5.2"
TEXTINFO_SRC_FILE="$TEXTINFO.tar.xz"

if [ ! -f $LFS/sources/$TEXTINFO_SRC_FILE ]; then
   wget -O $LFS/sources/$TEXTINFO_SRC_FILE $REPOSITORY/$TEXTINFO_SRC_FILE
fi

cd $LFS/sources/
tar -xf $TEXTINFO_SRC_FILE
cd ./$TEXTINFO
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $TEXTINFO
}
