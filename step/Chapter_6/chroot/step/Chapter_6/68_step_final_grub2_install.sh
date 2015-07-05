#!/bin/bash
#########
#########68 step. Final GRUB2 install. 
#########
#6.54. GRUB-2.02~beta2
step_68_final_grub2_install ()
{

GRUB="grub-2.02~beta2"
GRUB_SRC_FILE="$GRUB.tar.xz"

if [ ! -f /sources/$GRUB_SRC_FILE ]; then
   wget -O /sources/$GRUB_SRC_FILE $REPOSITORY/$GRUB_SRC_FILE
fi

cd /sources
tar xf $GRUB_SRC_FILE
cd $GRUB
./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-grub-emu-usb \
            --disable-efiemu       \
            --disable-werror
make -j$STREAM
make install
cd ..
rm -rf $GRUB
}