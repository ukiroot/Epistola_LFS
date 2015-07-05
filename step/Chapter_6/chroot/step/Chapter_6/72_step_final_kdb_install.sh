#!/bin/bash
#########
#########72 step. Final Kdb install. 
#########
#6.58. Kbd-2.0.2
step_72_final_kdb_install ()
{

KDB="kbd-2.0.2"
KDB_SRC_FILE="$KDB.tar.gz"

if [ ! -f /sources/$KDB_SRC_FILE ]; then
   wget -O /sources/$KDB_SRC_FILE $REPOSITORY/$KDB_SRC_FILE
fi

KDB_PATCH_1="kbd-2.0.2-backspace-1.patch"

if [ ! -f /sources/$KDB_PATCH_1 ]; then
   wget -O /sources/$KDB_PATCH_1 $REPOSITORY/$KDB_PATCH_1
fi


cd /sources
tar zxf $KDB_SRC_FILE
cd $KDB
patch -Np1 -i ../$KDB_PATCH_1
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
mkdir -v       /usr/share/doc/$KDB
cp -R -v docs/doc/* /usr/share/doc/$KDB
cd ..
rm -rf $KDB
}
