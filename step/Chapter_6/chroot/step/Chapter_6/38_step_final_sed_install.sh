#!/bin/bash
#########
#########38 step. Final Sed install. 
#########
#6.24. Sed-4.2.2
step_38_final_sed_install ()
{

SED="sed-4.2.2"
SED_SRC_FILE="$SED.tar.bz2"
if [ ! -f /sources/$SED_SRC_FILE ]; then
   wget -O /sources/$SED_SRC_FILE $REPOSITORY/$SED_SRC_FILE
fi

cd /sources
tar xjf $SED_SRC_FILE
cd $SED
./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/$SED
make -j$STREAM
make html
if [ "$1" == "test" ] ; then
	make check
fi
make install
make -C doc install-html
cd ..
rm -rf $SED
}
