#!/bin/bash
#########
#########41 step. Final Procps-ng install. 
#########
#6.27. Procps-ng-3.3.10
step_41_final_procps_ng_install ()
{

PROCPSNG="procps-ng-3.3.10"
PROCPSNG_SRC_FILE="$PROCPSNG.tar.xz"

if [ ! -f /sources/$PROCPSNG_SRC_FILE ]; then
   wget -O /sources/$PROCPSNG_SRC_FILE $REPOSITORY/$PROCPSNG_SRC_FILE
fi

cd /sources
tar xf $PROCPSNG_SRC_FILE
cd $PROCPSNG
./configure --prefix=/usr                           \
            --exec-prefix=                          \
            --libdir=/usr/lib                       \
            --docdir=/usr/share/doc/$PROCPSNG \
            --disable-static                        \
            --disable-kill
make -j$STREAM

sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
if [ "$1" == "test" ] ; then
	make check
fi
make install

mv -v /usr/bin/pidof /bin
mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so
cd ..
rm -rf $PROCPSNG
}