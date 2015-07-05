#!/bin/bash
step_38_install_wget ()
{
echo 'step_38_install_wget' >> /tmp/log

WGET="wget-1.15"
WGET_SRC_FILE="$WGET.tar.xz"

if [ ! -f $LFS/sources/$WGET_SRC_FILE ]; then
   wget -O $LFS/sources/$WGET_SRC_FILE $REPOSITORY/$WGET_SRC_FILE
fi

cd $LFS/sources/
tar -xf $WGET_SRC_FILE
cd ./$WGET
./configure --prefix=/tools --without-ssl --without-zlib --disable-ntlm
make -j$STREAM
make install
cd ..
rm -rf $WGET
}
