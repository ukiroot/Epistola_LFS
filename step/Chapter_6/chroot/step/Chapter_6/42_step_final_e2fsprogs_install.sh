#!/bin/bash
#########
#########42 step. Final E2fsprogs install. 
#########
#6.28. E2fsprogs-1.42.12
step_42_final_e2fsprogs_install ()
{

ETWOFSPROGS="e2fsprogs-1.42.12"
ETWOFSPROGS_SRC_FILE="$ETWOFSPROGS.tar.gz"

if [ ! -f /sources/$ETWOFSPROGS_SRC_FILE ]; then
   wget -O /sources/$ETWOFSPROGS_SRC_FILE $REPOSITORY/$ETWOFSPROGS_SRC_FILE
fi

cd /sources
tar zxf $ETWOFSPROGS_SRC_FILE
cd $ETWOFSPROGS
mkdir -v build
cd build

LIBS=-L/tools/lib                    \
CFLAGS=-I/tools/include              \
PKG_CONFIG_PATH=/tools/lib/pkgconfig \
../configure --prefix=/usr           \
             --bindir=/bin           \
             --with-root-prefix=""   \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck
	     
make -j$STREAM
#To set up and run the test suite we need to first link some libraries from /tools/lib to a location where the test programs look. To run the tests, issue:
ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib
if [ "$1" == "test" ] ; then
	make LD_LIBRARY_PATH=/tools/lib check
fi
make install
make install-libs

chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info


makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
cd ../../
rm -rf $ETWOFSPROGS
}