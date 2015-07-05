#!/bin/bash
#########
#########49 step. Final Readline install. 
#########
#6.35. Readline-6.3
step_49_final_readline_install ()
{

READLINE="readline-6.3"
READLINE_SRC_FILE="$READLINE.tar.gz"

if [ ! -f /sources/$READLINE_SRC_FILE ]; then
   wget -O /sources/$READLINE_SRC_FILE $REPOSITORY/$READLINE_SRC_FILE
fi

READLINE_PATCH_1="readline-6.3-upstream_fixes-3.patch"
if [ ! -f /sources/$READLINE_PATCH_1 ]; then
   wget -O /sources/$READLINE_PATCH_1 $REPOSITORY/$READLINE_PATCH_1
fi

cd /sources
tar zxf $READLINE_SRC_FILE
cd $READLINE
patch -Np1 -i ../$READLINE_PATCH_1
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
./configure --prefix=/usr --docdir=/usr/share/doc/$READLINE
make SHLIB_LIBS=-lncurses

make SHLIB_LIBS=-lncurses install

mv -v /usr/lib/lib{readline,history}.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so

install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/$READLINE
cd ..
rm -rf $READLINE
}
