#!/bin/bash
#########
step_32_install_sed ()
{
echo 'step_32_install_sed' >> /tmp/log

SED="sed-4.2.2"
SED_SRC_FILE="$SED.tar.bz2"

if [ ! -f $LFS/sources/$SED_SRC_FILE ]; then
   wget -O $LFS/sources/$SED_SRC_FILE $REPOSITORY/$SED_SRC_FILE
fi

cd $LFS/sources/
tar xjf $SED_SRC_FILE
cd ./$SED
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $SED
}
