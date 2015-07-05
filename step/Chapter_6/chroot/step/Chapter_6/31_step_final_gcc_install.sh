#!/bin/bash
#########
#########31 step. Final GCC install. 
#########
#6.17. GCC-4.9.2
step_31_final_gcc_install ()
{
GCC="gcc-5.1.0"
GCCV="5.1.0"
GCC_SRC_FILE="$GCC.tar.bz2"

if [ ! -f /sources/$GCC_SRC_FILE ]; then
   wget -O /sources/$GCC_SRC_FILE $REPOSITORY/$GCC_SRC_FILE
fi

cd /sources
tar xjf $GCC_SRC_FILE
mkdir -v ./gcc-build
cd ./gcc-build
SED=sed                       \
../$GCC/configure        \
     --prefix=/usr            \
     --enable-languages=c,c++ \
     --disable-multilib       \
     --disable-bootstrap      \
     --with-system-zlib
make -j$STREAM
ulimit -s 32768
if [ "$1" == "test" ] ; then
	make -k check
	../$GCC/contrib/test_summary
fi
make install
ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc

install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/$GCCV/liblto_plugin.so /usr/lib/bfd-plugins/

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
cd ..
rm -rf $GCC
rm -rf gcc-build
}
