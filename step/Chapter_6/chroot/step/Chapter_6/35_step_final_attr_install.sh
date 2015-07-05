#!/bin/bash
#########
#########35 step. Finall Attr install. 
#########
#6.21. Attr-2.4.47
step_35_final_attr_install ()
{

ATTR="attr-2.4.47"
ATTR_SRC_FILE="$ATTR.src.tar.gz"

if [ ! -f /sources/$ATTR_SRC_FILE ]; then
   wget -O /sources/$ATTR_SRC_FILE $REPOSITORY/$ATTR_SRC_FILE
fi

cd /sources
tar zxf $ATTR_SRC_FILE
cd $ATTR
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i -e "/SUBDIRS/s|man2||" man/Makefile
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
   make -j1 tests root-tests
fi
make install install-dev install-lib
chmod -v 755 /usr/lib/libattr.so
mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so
cd ..
rm -rf $ATTR
}
