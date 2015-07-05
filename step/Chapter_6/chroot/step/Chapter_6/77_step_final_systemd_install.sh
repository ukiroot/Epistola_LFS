#!/bin/bash
#########
#########77 step. Final Systemd install. 
#########
#6.63. Systemd-218
step_77_final_systemd_install ()
{

SYSTEMD="systemd-218"
SYSTEMD_SRC_FILE="$SYSTEMD.tar.xz"

if [ ! -f /sources/$SYSTEMD_SRC_FILE ]; then
   wget -O /sources/$SYSTEMD_SRC_FILE $REPOSITORY/$SYSTEMD_SRC_FILE
fi


SYSTEMD_PATCH_1="systemd-218-compat-1.patch"

if [ ! -f /sources/$SYSTEMD_PATCH_1 ]; then
   wget -O /sources/$SYSTEMD_PATCH_1 $REPOSITORY/$SYSTEMD_PATCH_1
fi


cd /sources
tar xf $SYSTEMD_SRC_FILE
cd $SYSTEMD

cat > config.cache << "EOF"
KILL=/bin/kill
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include/blkid"
HAVE_LIBMOUNT=1
MOUNT_LIBS="-lmount"
MOUNT_CFLAGS="-I/tools/include/libmount"
cc_cv_CFLAGS__flto=no
EOF

sed -i "s:blkid/::" $(grep -rl "blkid/blkid.h")
patch -Np1 -i ../$SYSTEMD_PATCH_1


./configure --prefix=/usr                                           \
            --includedir=/usr/include/				\
            --sysconfdir=/etc                                       \
            --localstatedir=/var                                    \
            --config-cache                                          \
            --with-rootprefix=                                      \
            --with-rootlibdir=/lib                                  \
            --enable-split-usr                                      \
            --disable-gudev                                         \
            --disable-firstboot                                     \
            --disable-ldconfig                                      \
            --disable-sysusers                                      \
            --without-python                                        \
            --docdir=/usr/share/doc/$SYSTEMD                     \
            --with-dbuspolicydir=/etc/dbus-1/system.d               \
            --with-dbusinterfacedir=/usr/share/dbus-1/interfaces    \
            --with-dbussessionservicedir=/usr/share/dbus-1/services \
            --with-dbussystemservicedir=/usr/share/dbus-1/system-services

#
sed -i 's/<libmount.h>/<\/usr\/include\/libmount\/libmount.h>/' src/core/mount.c
sed -i 's/<blkid.h>/<\/usr\/include\/blkid\/blkid.h>/' src/udev/udev-builtin-blkid.c
sed -i 's/<blkid.h>/<\/usr\/include\/blkid\/blkid.h>/' src/nspawn/nspawn.c
sed -i 's/<blkid.h>/<\/usr\/include\/blkid\/blkid.h>/' ./src/shared/blkid-util.h
sed -i 's/<blkid.h>/<\/usr\/include\/blkid\/blkid.h>/' src/gpt-auto-generator/gpt-auto-generator.c
#
	    
make LIBRARY_PATH=/tools/lib

if [ "$1" == "test" ] ; then
#If you are going to run the test suite, first prevent a few test cases from running because they fail in a chroot environment:
sed -e "s:test/udev-test.pl::g"              \
    -e "s:test-bus-cleanup\$(EXEEXT) ::g"    \
    -e "s:test-cgroup-mask\$(EXEEXT) ::g"    \
    -e "s:test-condition-util\$(EXEEXT) ::g" \
    -e "s:test-dhcp6-client\$(EXEEXT) ::g"   \
    -e "s:test-engine\$(EXEEXT) ::g"         \
    -e "s:test-journal-flush\$(EXEEXT) ::g"  \
    -e "s:test-path-util\$(EXEEXT) ::g"      \
    -e "s:test-sched-prio\$(EXEEXT) ::g"     \
    -e "s:test-strv\$(EXEEXT) ::g"           \
    -i Makefile
make -k check
fi
#Install the package:
make LD_LIBRARY_PATH=/tools/lib install
#Move NSS libraries to /lib:
mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib
#Remove an unnecessary directory:
rm -rfv /usr/lib/rpm
#Create the Sysvinit compatibility symlinks, so systemd is used as the default init system:
for tool in runlevel reboot shutdown poweroff halt telinit; do
     ln -sfv ../bin/systemctl /sbin/${tool}
done
ln -sfv ../lib/systemd/systemd /sbin/init

#Remove a reference to a non-existent group:
sed -i "s:0775 root lock:0755 root root:g" /usr/lib/tmpfiles.d/legacy.conf
systemd-machine-id-setup
cd ..
rm -rf $SYSTEMD
}