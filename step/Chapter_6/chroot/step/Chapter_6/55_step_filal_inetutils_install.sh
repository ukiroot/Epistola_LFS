#!/bin/bash
#########
#########55 step. Final Inetutis install. 
#########
#6.41. Inetutils-1.9.2
step_55_filal_inetutils_install ()
{

INETTOOLS="inetutils-1.9.2"
INETTOOLS_SRC_FILE="$INETTOOLS.tar.gz"

if [ ! -f /sources/$INETTOOLS_SRC_FILE ]; then
   wget -O /sources/$INETTOOLS_SRC_FILE $REPOSITORY/$INETTOOLS_SRC_FILE
fi

cd /sources
tar zxf $INETTOOLS_SRC_FILE
cd $INETTOOLS
echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h 
./configure --prefix=/usr  \
            --localstatedir=/var   \
            --disable-logger       \
            --disable-whois        \
            --disable-servers
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin
cd ..
rm -rf $INETTOOLS
}