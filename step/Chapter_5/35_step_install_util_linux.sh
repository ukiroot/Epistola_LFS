#!/bin/bash
#########
step_35_install_util_linux ()
{
echo 'step_35_install_util_linux' >> /tmp/log

UTILLINUX="util-linux-2.26.2"
UTILLINUX_SRC_FILE="$UTILLINUX.tar.xz"

if [ ! -f $LFS/sources/$UTILLINUX_SRC_FILE ]; then
   wget -O $LFS/sources/$UTILLINUX_SRC_FILE $REPOSITORY/$UTILLINUX_SRC_FILE
fi

cd $LFS/sources/
tar -xf $UTILLINUX_SRC_FILE
cd ./$UTILLINUX
./configure --prefix=/tools                \
            --without-python               \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG=""
make -j$STREAM
if [ "$1" == "test" ] ; then
	make install
fi
cd ..
rm -rf $UTILLINUX
}
