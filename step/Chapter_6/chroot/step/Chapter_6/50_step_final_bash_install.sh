#!/bin/bash
#########
#########50 step. FInal Bash install. 
#########
#6.36. Bash-4.3.30
step_50_final_bash_install ()
{

BASH="bash-4.3.30"
BASH_SRC_FILE="$BASH.tar.gz"

if [ ! -f /sources/$BASH_SRC_FILE ]; then
   wget -O /sources/$BASH_SRC_FILE $REPOSITORY/$BASH_SRC_FILE
fi

cd /sources
tar zxf $BASH_SRC_FILE
cd $BASH
./configure --prefix=/usr                    \
            --bindir=/bin                    \
            --docdir=/usr/share/doc/$BASH \
            --without-bash-malloc            \
            --with-installed-readline
make -j$STREAM
chown -Rv nobody .
if [ "$1" == "test" ] ; then
   su nobody -s /bin/bash -c "PATH=$PATH make tests"
fi
make install
#exec /bin/bash --login +h
cd ..
rm -rf $BASH
}
