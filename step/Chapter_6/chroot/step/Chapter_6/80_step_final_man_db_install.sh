#!/bin/bash
#########
#########80 step. Final Man-DB install. 
#########
#6.66. Man-DB-2.7.1
step_80_final_man_db_install ()
{

MANDB="man-db-2.7.1"
MANDB_SRC_FILE="$MANDB.tar.xz"

if [ ! -f /sources/$MANDB_SRC_FILE ]; then
   wget -O /sources/$MANDB_SRC_FILE $REPOSITORY/$MANDB_SRC_FILE
fi

cd /sources
tar xf $MANDB_SRC_FILE
cd $MANDB
./configure --prefix=/usr                          \
            --docdir=/usr/share/doc/$MANDB \
            --sysconfdir=/etc                      \
            --disable-setuid                       \
            --with-browser=/usr/bin/lynx           \
            --with-vgrind=/usr/bin/vgrind          \
            --with-grap=/usr/bin/grap
	    
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
sed -i "s:man root:root root:g" /usr/lib/tmpfiles.d/man-db.conf
cd ..
rm -rf $MANDB
}
