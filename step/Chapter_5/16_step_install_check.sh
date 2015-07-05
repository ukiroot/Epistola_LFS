#!/bin/bash
#########
step_16_install_check ()
{
echo 'step_16_install_check' >> /tmp/log

CHECK="check-0.9.14"
CHECK_SRC_FILE="$CHECK.tar.gz"

if [ ! -f $LFS/sources/$CHECK_SRC_FILE ]; then
   wget -O $LFS/sources/$CHECK_SRC_FILE $REPOSITORY/$CHECK_SRC_FILE
fi

cd $LFS/sources/
tar xzf $CHECK_SRC_FILE
cd ./$CHECK
PKG_CONFIG= ./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $CHECK
}
