#!/bin/bash
#########
step_17_install_ncurses ()
{
echo 'step_17_install_ncurses' >> /tmp/log

NCURSES="ncurses-5.9"
NCURSES_SRC_FILE="$NCURSES.tar.gz"

if [ ! -f $LFS/sources/$NCURSES_SRC_FILE ]; then
   wget -O $LFS/sources/$NCURSES_SRC_FILE $REPOSITORY/$NCURSES_SRC_FILE
fi

NCURSES_PATCH="ncurses-5.9-gcc5_buildfixes-1.patch"

if [ ! -f $LFS/sources/$NCURSES_PATCH ]; then
   wget -O $LFS/sources/$NCURSES_PATCH $REPOSITORY/$NCURSES_PATCH
fi


cd $LFS/sources/
tar zxf $NCURSES_SRC_FILE
cd ./$NCURSES

patch -Np1 -i ../$NCURSES_PATCH

./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite
make -j$STREAM
make install
cd ..
rm -rf $NCURSES
}
