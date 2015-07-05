#!/bin/bash
#########
#########28 step.Final GMP iinstall. 
#########
#6.14. GMP-6.0.0a
step_28_final_gmp_install ()
{

GMP="gmp-6.0.0"
GMP_SRC_FILE="$GMP""a.tar.xz"
if [ ! -f /sources/GMP_SRC_FILE ]; then
   wget -O /sources/$GMP_SRC_FILE $REPOSITORY/$GMP_SRC_FILE
fi

cd /sources
tar xf $GMP_SRC_FILE
cd $GMP
./configure --prefix=/usr \
            --enable-cxx  \
            --docdir=/usr/share/doc/"$GMP"a
	    
make -j$STREAM
make html
if [ "$1" == "test" ] ; then
	make check 2>&1 | tee gmp-check-log
	awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
fi
make install
make install-html
cd ..
rm -rf $GMP
}
