#!/bin/bash
#########
#########22 step. Man-pages-3.75. 
#########
#6.8. Man-pages-3.75
step_22_man_pages_install ()
{
MANPAGES="man-pages-3.79"
MANPAGES_SRC_FILE="MANPAGES.tar.xz"

if [ ! -f /sources/$MANPAGES_SRC_FILE ]; then
   wget -O /sources/$MANPAGES_SRC_FILE $REPOSITORY/$MANPAGES_SRC_FILE
fi

cd /sources
tar xf $MANPAGES_SRC_FILE
cd $MANPAGES
make install
cd ..
rm -rf $MANPAGES
}