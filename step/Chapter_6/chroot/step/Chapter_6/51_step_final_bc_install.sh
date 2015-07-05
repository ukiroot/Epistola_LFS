#!/bin/bash
#########
#########51 step. FInal Bc install. 
#########
#6.37. Bc-1.06.95
step_51_final_bc_install ()
{

BC="bc-1.06.95"
BC_SRC_FILE="$BC.tar.bz2"

if [ ! -f /sources/$BC_SRC_FILE ]; then
   wget -O /sources/$BC_SRC_FILE $REPOSITORY/$BC_SRC_FILE
fi

BC_PATCH_1="bc-1.06.95-memory_leak-1.patch"
if [ ! -f /sources/$BC_PATCH_1 ]; then
   wget -O /sources/$BC_PATCH_1 $REPOSITORY/$BC_PATCH_1
fi


cd /sources
tar xjf $BC_SRC_FILE
cd $BC
patch -Np1 -i ../$BC_PATCH_1
./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info
make -j$STREAM
if [ "$1" == "test" ] ; then
  echo "quit" | ./bc/bc -l Test/checklib.b
fi
make install
cd ..
rm -rf $BC
}
