#!/bin/bash
#########
#########73 step. Final Kmod install. 
#########
#6.59. Kmod-19
step_73_final_kmod_install ()
{

KMOD="kmod-19"
KMOD_SRC_FILE="$KMOD.tar.xz"

if [ ! -f /sources/$KMOD_SRC_FILE ]; then
   wget -O /sources/$KMOD_SRC_FILE $REPOSITORY/$KMOD_SRC_FILE
fi

cd /sources
tar xf $KMOD_SRC_FILE
cd $KMOD
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
	    
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
for target in depmod insmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod
cd ..
rm -rf $KMOD
}
