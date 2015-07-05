#!/bin/bash
#########
#########94 step. Kernel install. 
#########
#8.3.1. Installation of the kernel
step_94_kernel_install ()
{

LINUX="linux-4.0.1"
LINUXV="4.0.1"
LINUX_SRC_FILE="$LINUX.tar.xz"

if [ ! -f /sources/$LINUX_SRC_FILE ]; then
   wget -O /sources/$LINUX_SRC_FILE $REPOSITORY/$LINUX_SRC_FILE
fi

cd /sources
tar xf $LINUX_SRC_FILE
cd $LINUX
make mrproper
make defconfig
make -j$STREAM
make modules_install
cp -v arch/x86/boot/bzImage /boot/vmlinuz-$LINUXV-epistola
cp -v System.map /boot/System.map-$LINUXV
cp -v .config /boot/config-$LINUXV
install -d /usr/share/doc/linux-$LINUXV
cp -r Documentation/* /usr/share/doc/linux-$LINUXV
#8.3.2. Configuring Linux Module Load Order
install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

cd ..
rm -rf $LINUX
}
