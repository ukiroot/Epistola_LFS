#!/bin/bash
#########
######### step. Install Sqlite3. 
#########
step_106_install_sqlite ()
{
cd /sources
tar zxf sqlite-autoconf-3080801.tar.gz
cd sqlite-autoconf-3080801
./configure --prefix=/usr
make
make install
cd ..
rm -rf sqlite-autoconf-3080801
}