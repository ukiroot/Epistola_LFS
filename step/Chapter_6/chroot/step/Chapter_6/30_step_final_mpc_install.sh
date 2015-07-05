#!/bin/bash
#########
#########30 step. Final MPC install . 
#########
#6.16. MPC-1.0.2
step_30_final_mpc_install ()
{
MPC="mpc-1.0.3"
MPC_SRC_FILE="$MPC.tar.gz"

if [ ! -f /sources/$MPC_SRC_FILE ]; then
   wget -O /sources/$MPC_SRC_FILE $REPOSITORY/$MPC_SRC_FILE
fi

cd /sources
tar xzf $MPC_SRC_FILE
cd $MPC
./configure --prefix=/usr --docdir=/usr/share/doc/$MPC
make -j$STREAM
make html
if [ "$1" == "test" ] ; then
	make check
fi
make install
make install-html
cd ..
rm -rf $MPC
}
