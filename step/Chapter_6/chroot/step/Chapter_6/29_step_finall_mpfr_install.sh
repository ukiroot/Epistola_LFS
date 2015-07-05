#!/bin/bash
#########
#########29 step. Final MPFR install. 
#########
#6.15. MPFR-3.1.2
step_29_finall_mpfr_install ()
{

MPFR="mpfr-3.1.2"
MPFR_SRC_FILE="$MPFR.tar.xz"
if [ ! -f /sources/$MPFR_SRC_FILE ]; then
   wget -O /sources/$MPFR_SRC_FILE $REPOSITORY/$MPFR_SRC_FILE
fi

MPFR_PATCH_1="mpfr-3.1.2-upstream_fixes-2.patch"
if [ ! -f /sources/$MPFR_PATCH_1 ]; then
   wget -O /sources/$MPFR_PATCH_1 $REPOSITORY/$MPFR_PATCH_1
fi

cd /sources
tar xf $MPFR_SRC_FILE
cd $MPFR
patch -Np1 -i ../$MPFR_PATCH_1
./configure --prefix=/usr        \
            --enable-thread-safe \
            --docdir=/usr/share/doc/$MPFR
make -j$STREAM
make html
if [ "$1" == "test" ] ; then
	make check
fi
make install
make install-html
cd ..
rm -rf $MPFR
}
