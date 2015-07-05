#!/bin/bash
#########
step_14_install_expect ()
{
echo 'step_14_install_expect' >> /tmp/log

EXPECT="expect5.45"
EXPECT_SRC_FILE="$EXPECT.tar.gz"

if [ ! -f $LFS/sources/$EXPECT_SRC_FILE ]; then
   wget -O $LFS/sources/$EXPECT_SRC_FILE $REPOSITORY/$EXPECT_SRC_FILE
fi

cd $LFS/sources/
tar zxf $EXPECT_SRC_FILE
cd ./$EXPECT
cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure
./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include
make -j$STREAM
if [ "$1" == "test" ] ; then
	make test
fi
make SCRIPTS="" install
cd ..
rm -rf ./$EXPECT
}
