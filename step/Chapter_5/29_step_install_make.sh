#!/bin/bash
#########
step_29_install_make ()
{
echo 'step_29_install_make' >> /tmp/log

MAKE="make-4.1"
MAKE_SRC_FILE="$MAKE.tar.bz2"

if [ ! -f $LFS/sources/$MAKE_SRC_FILE ]; then
   wget -O $LFS/sources/$MAKE_SRC_FILE $REPOSITORY/$MAKE_SRC_FILE
fi

cd $LFS/sources/
tar xjf $MAKE_SRC_FILE
cd $MAKE
./configure --prefix=/tools --without-guile
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $MAKE
}
