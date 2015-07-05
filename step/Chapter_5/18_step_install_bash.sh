#!/bin/bash
#########
step_18_install_bash ()
{
echo 'step_18_install_bash' >> /tmp/log

BASH="bash-4.3.30"
BASH_SRC_FILE="$BASH.tar.gz"

if [ ! -f $LFS/sources/$BASH_SRC_FILE ]; then
   wget -O $LFS/sources/$BASH_SRC_FILE $REPOSITORY/$BASH_SRC_FILE
fi

cd $LFS/sources/
tar xzf $BASH_SRC_FILE
cd ./$BASH
./configure --prefix=/tools --without-bash-malloc
make -j$STREAM
if [ "$1" == "test" ] ; then
	make tests
fi
make install
ln -sv bash /tools/bin/sh
cd ..
rm -rf $BASH
}
