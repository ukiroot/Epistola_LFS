#!/bin/bash
#########
step_20_install_coreutils ()
{
echo 'step_20_install_coreutils' >> /tmp/log

COREUTILS="coreutils-8.23"
COREUTILS_SRC_FILE="$COREUTILS.tar.xz"

if [ ! -f $LFS/sources/$COREUTILS_SRC_FILE ]; then
   wget -O $LFS/sources/$COREUTILS_SRC_FILE $REPOSITORY/$COREUTILS_SRC_FILE
fi

cd $LFS/sources/
tar -xf $COREUTILS_SRC_FILE
cd ./$COREUTILS
#If run from root ned set FORCE_UNSAFE_CONFIGURE in 1
FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/tools --enable-install-program=hostname
make -j$STREAM
if [ "$1" == "test" ] ; then
	make RUN_EXPENSIVE_TESTS=yes check
fi
make install
cd ..
rm -rf $COREUTILS
}
