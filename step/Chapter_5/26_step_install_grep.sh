#!/bin/bash
#########
step_26_install_grep ()
{
echo 'step_26_install_grep' >> /tmp/log

GREP="grep-2.21"
GREP_SRC_FILE="$GREP.tar.xz"

if [ ! -f $LFS/sources/$GREP_SRC_FILE ]; then
   wget -O $LFS/sources/$GREP_SRC_FILE $REPOSITORY/$GREP_SRC_FILE
fi

cd $LFS/sources/
tar -xf $GREP_SRC_FILE
cd ./$GREP
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $GREP
}
