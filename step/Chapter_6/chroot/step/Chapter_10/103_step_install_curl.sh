#!/bin/bash
#########
#########103 step. Install Curl. 
#########
step_103_install_curl ()
{

CURL="curl-7.42.1"
CURL_SRC_FILE="$CURL.tar.gz"

if [ ! -f /sources/$CURL_SRC_FILE ]; then
   wget -O /sources/$CURL_SRC_FILE $REPOSITORY/$CURL_SRC_FILE
fi

cd /sources/
tar xzf $CURL_SRC_FILE
cd $CURL
./configure --prefix=/usr
make -j$STREAM
make install
cd ..
rm -rf $CURL
}