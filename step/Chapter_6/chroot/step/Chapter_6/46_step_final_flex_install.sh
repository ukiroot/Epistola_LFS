#!/bin/bash
#########
#########46 step. Final Flex install. 
#########
#6.32. Flex-2.5.39
step_46_final_flex_install ()
{

FLEX="flex-2.5.39"
FLEX_SRC_FILE="$FLEX.tar.bz2"

if [ ! -f /sources/$FLEX_SRC_FILE ]; then
   wget -O /sources/$FLEX_SRC_FILE $REPOSITORY/$FLEX_SRC_FILE
fi

cd /sources
tar xjf $FLEX_SRC_FILE
cd $FLEX
sed -i -e '/test-bison/d' tests/Makefile.in
./configure --prefix=/usr --docdir=/usr/share/doc/$FLEX
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
ln -sv flex /usr/bin/lex
cd ..
rm -rf $FLEX
}
