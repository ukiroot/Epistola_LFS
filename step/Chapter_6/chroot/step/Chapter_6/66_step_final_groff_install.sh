#!/bin/bash
#########
#########66 step. Final Groff install. 
#########
#6.52. Groff-1.22.3
step_66_final_groff_install ()
{

GROFF="groff-1.22.3"
GROFF_SRC_FILE="$GROFF.tar.gz"

if [ ! -f /sources/$GROFF_SRC_FILE ]; then
   wget -O /sources/$GROFF_SRC_FILE $REPOSITORY/$GROFF_SRC_FILE
fi

cd /sources
tar xzf $GROFF_SRC_FILE
cd $GROFF
PAGE=A4 ./configure --prefix=/usr
# -j Must_be_1
make -j1
make install
cd ..
rm -rf $GROFF
}
