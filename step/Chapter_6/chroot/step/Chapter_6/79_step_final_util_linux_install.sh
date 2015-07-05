#!/bin/bash
#########
#########79 step. Final Util-linux install. 
#########
#6.65. Util-linux-2.25.2
step_79_final_util_linux_install ()
{

UTILLINUX="util-linux-2.25.2"
UTILLINUX_SRC_FILE="$UTILLINUX.tar.xz"

if [ ! -f /sources/$UTILLINUX_SRC_FILE ]; then
   wget -O /sources/$UTILLINUX_SRC_FILE $REPOSITORY/$UTILLINUX_SRC_FILE
fi


cd /sources
tar xf $UTILLINUX_SRC_FILE
cd $UTILLINUX
mkdir -pv /var/lib/hwclock

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime     \
            --docdir=/usr/share/doc/$UTILLINUX \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --without-python
	    
	    
make -j$STREAM

if [ "$1" == "test" ] ; then
#Warning
#Running the test suite as the root user can be harmful to your system. To run it, the CONFIG_SCSI_DEBUG option for the kernel must be available in the currently running system, and must be built as a module. Building it into the kernel will prevent booting. For complete coverage, other BLFS packages must be installed. If desired, this test can be run after rebooting into the completed LFS system and running:
   bash tests/run.sh --srcdir=$PWD --builddir=$PWD
   chown -Rv nobody .
   su nobody -s /bin/bash -c "PATH=$PATH make -k check"
fi

make install
cd ..
rm -rf $UTILLINUX
}

