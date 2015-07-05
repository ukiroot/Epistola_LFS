#!/bin/bash
#########
#########40 step. Final Psmisc install. 
#########
#6.26. Psmisc-22.21
step_40_final_psmisc_install ()
{

PSMISC="psmisc-22.21"
PSMISC_SRC_FILE="$PSMISC.tar.gz"

if [ ! -f /sources/$PSMISC_SRC_FILE ]; then
   wget -O /sources/$PSMISC_SRC_FILE $REPOSITORY/$PSMISC_SRC_FILE
fi

cd /sources
tar zxf $PSMISC_SRC_FILE
cd $PSMISC
./configure --prefix=/usr
make -j$STREAM
make install
mv -v /usr/bin/fuser   /bin
mv -v /usr/bin/killall /bin
cd ..
rm -rf $PSMISC
}
