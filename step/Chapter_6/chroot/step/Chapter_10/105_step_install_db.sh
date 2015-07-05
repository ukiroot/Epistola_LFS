#!/bin/bash
#########
#########105 step. Install DB. 
#########
step_105_install_db ()
{

DB="db5.3_5.3.28"
DBDIR="db-5.3.28"
DB_SRC_FILE="$DB.orig.tar.xz"

if [ ! -f /sources/$DB_SRC_FILE ]; then
   wget -O /sources/$DB_SRC_FILE $REPOSITORY/$DB_SRC_FILE
fi

cd /sources/
tar xf $DB_SRC_FILE
cd $DBDIR/build_unix
../dist/configure --prefix=/usr
make -j$STREAM
make install
cd ../..
rm -rf $DBDIR
}
