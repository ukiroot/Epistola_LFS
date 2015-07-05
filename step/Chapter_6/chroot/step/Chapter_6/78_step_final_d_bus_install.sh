#!/bin/bash
#########
#########78 step. Final D-Bus install 
#########
#6.64. D-Bus-1.8.12
step_78_final_d_bus_install ()
{

DBUS="dbus-1.8.12"
DBUS_SRC_FILE="$DBUS.tar.gz"

if [ ! -f /sources/$DBUS_SRC_FILE ]; then
   wget -O /sources/$DBUS_SRC_FILE $REPOSITORY/$DBUS_SRC_FILE
fi

cd /sources
tar zxf $DBUS_SRC_FILE
cd $DBUS
./configure --prefix=/usr                       \
            --sysconfdir=/etc                   \
            --localstatedir=/var                \
            --docdir=/usr/share/doc/$DBUS \
            --with-console-auth-dir=/run/console
make -j$STREAM
make install

mv -v /usr/lib/libdbus-1.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so
ln -sfv /etc/machine-id /var/lib/dbus
cd ..
rm -rf $DBUS
}