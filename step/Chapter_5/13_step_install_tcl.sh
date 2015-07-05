#!/bin/bash
#########
step_13_install_tcl ()
{
echo 'step_13_install_tcl' >> /tmp/log

#5.11. Tcl-8.6.3
TCL="tcl8.6.4"
TCL_SRC_FILE="$TCL-src.tar.gz"

if [ ! -f $LFS/sources/$TCL_SRC_FILE ]; then
   wget -O $LFS/sources/$TCL_SRC_FILE $REPOSITORY/$TCL_SRC_FILE
fi

cd $LFS/sources/
tar zxf $TCL_SRC_FILE
cd ./$TCL/unix/
./configure --prefix=/tools
make -j$STREAM
if [ "$1" == "test" ] ; then
	TZ=UTC make test
fi
make install
chmod -v u+w /tools/lib/libtcl8.6.so
make install-private-headers
ln -sv tclsh8.6 /tools/bin/tclsh
cd $LFS/sources/
rm -rf tcl8.6.3
}
