#!/bin/bash
#########
#########81 step. Final Tar install. 
#########
#6.67. Tar-1.28
step_81_final_tar_install ()
{

TAR="tar-1.28"
TAR_SRC_FILE="$TAR.tar.xz"

if [ ! -f /sources/$TAR_SRC_FILE ]; then
   wget -O /sources/$TAR_SRC_FILE $REPOSITORY/$TAR_SRC_FILE
fi

cd /sources
tar xf $TAR_SRC_FILE
cd $TAR
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
	    
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
if [ "$2" == "doc" ] ; then
  make -C doc install-html docdir=/usr/share/doc/$TAR
fi
cd ..
rm -rf $TAR
}
