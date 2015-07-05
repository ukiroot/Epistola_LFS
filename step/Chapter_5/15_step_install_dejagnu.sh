#!/bin/bash
#########
step_15_install_dejagnu ()
{
echo 'step_15_install_dejagnu' >> /tmp/log

DEJAGNU="dejagnu-1.5.3"
DEJAGNU_SRC_FILE="$DEJAGNU.tar.gz"

if [ ! -f $LFS/sources/$DEJAGNU_SRC_FILE ]; then
   wget -O $LFS/sources/$DEJAGNU_SRC_FILE $REPOSITORY/$DEJAGNU_SRC_FILE
fi

cd $LFS/sources/
tar xzf $DEJAGNU_SRC_FILE
cd $DEJAGNU
./configure --prefix=/tools
make install
if [ "$1" == "test" ] ; then
	make check
fi
cd ..
rm -rf $DEJAGNU
}
