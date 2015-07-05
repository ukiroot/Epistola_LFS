#!/bin/bash
#########
#########44 step. Final Iana-Etc install. 
#########
#6.30. Iana-Etc-2.30
step_44_final_iana_etc_install ()
{

IANA="iana-etc-2.30"
IANA_SRC_FILE="$IANA.tar.bz2"

if [ ! -f /sources/$IANA_SRC_FILE ]; then
   wget -O /sources/$IANA_SRC_FILE $REPOSITORY/$IANA_SRC_FILE
fi

cd /sources
tar xjf $IANA_SRC_FILE
cd $IANA
make -j$STREAM
make install
cd ..
rm -rf $IANA
}