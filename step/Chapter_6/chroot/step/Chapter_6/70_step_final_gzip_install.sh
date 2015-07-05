#!/bin/bash
#########
#########70 step. Final Gzip install. 
#########
#6.56. Gzip-1.6
step_70_final_gzip_install ()
{

GZIP="gzip-1.6"
GZIP_SRC_FILE="$GZIP.tar.xz"

if [ ! -f /sources/$GZIP_SRC_FILE ]; then
   wget -O /sources/$GZIP_SRC_FILE $REPOSITORY/$GZIP_SRC_FILE
fi

cd /sources
tar xf $GZIP_SRC_FILE
cd $GZIP
./configure --prefix=/usr --bindir=/bin
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
cd ..
rm -rf $GZIP
}
