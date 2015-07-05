#!/bin/bash
#########
#########34 step. Final Ncurses install. 
#########
#6.20. Ncurses-5.9
step_34_ncurses_install ()
{

NCURSES="ncurses-5.9"
NCURSES_SRC_FILE="$NCURSES.tar.gz"

if [ ! -f /sources/$NCURSES_SRC_FILE ]; then
   wget -O /sources/$NCURSES_SRC_FILE $REPOSITORY/$NCURSES_SRC_FILE
fi

NCURSES_PATCH_1="ncurses-5.9-gcc5_buildfixes-1.patch"

if [ ! -f /sources/$NCURSES_PATCH_1 ]; then
   wget -O /sources/$NCURSES_PATCH_1 $REPOSITORY/$NCURSES_PATCH_1
fi

cd /sources
tar zxf $NCURSES_SRC_FILE
cd $NCURSES

patch -Np1 -i ../$NCURSES_PATCH_1

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --enable-pc-files       \
            --enable-widec
make -j$STREAM
make install
mv -v /usr/lib/libncursesw.so.5* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv lib${lib}w.a      /usr/lib/lib${lib}.a
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

ln -sfv libncurses++w.a /usr/lib/libncurses++.a

rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so
ln -sfv libncursesw.a      /usr/lib/libcursesw.a
ln -sfv libncurses.a       /usr/lib/libcurses.a

mkdir -v       /usr/share/doc/ncurses-5.9
cp -v -R doc/* /usr/share/doc/ncurses-5.9

#The instructions above don't create non-wide-character Ncurses libraries since no package installed by compiling from sources would link against them at runtime. If you must have such libraries because of some binary-only application or to be compliant with LSB, build the package again with the following commands:
make distclean
./configure --prefix=/usr    \
            --with-shared    \
            --without-normal \
            --without-debug  \
            --without-cxx-binding
make sources libs
cp -av lib/lib*.so.5* /usr/lib
cd ..
rm -rf $NCURSES
}