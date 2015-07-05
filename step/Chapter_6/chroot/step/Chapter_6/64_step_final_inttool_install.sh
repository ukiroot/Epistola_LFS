#!/bin/bash
#########
#########64 step. Final Inttool install. 
#########
#6.50. Intltool-0.50.2
step_64_final_inttool_install ()
{

INITTOOL="intltool-0.50.2"
INITTOOL_SRC_FILE="$INITTOOL.tar.gz"

if [ ! -f /sources/$INITTOOL_SRC_FILE ]; then
   wget -O /sources/$INITTOOL_SRC_FILE $REPOSITORY/$INITTOOL_SRC_FILE
fi

cd /sources
tar zxf $INITTOOL_SRC_FILE
cd $INITTOOL
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/$INITTOOL/I18N-HOWTO
cd ..
rm -rf $INITTOOL
}
