#!/bin/bash
#########
#########62 step. Filan Findutils install. 
#########
#6.48. Findutils-4.4.2
step_62_final_findutils_install ()
{
FINDUTILS="findutils-4.4.2"
FINDUTILS_SRC_FILE="$FINDUTILS.tar.gz"

if [ ! -f /sources/$FINDUTILS_SRC_FILE ]; then
   wget -O /sources/$FINDUTILS_SRC_FILE $REPOSITORY/$FINDUTILS_SRC_FILE
fi

cd /sources
tar zxf $FINDUTILS_SRC_FILE
cd $FINDUTILS
./configure --prefix=/usr --localstatedir=/var/lib/locate
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install

mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb
cd ..
rm -rf $FINDUTILS
}
