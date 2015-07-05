#!/bin/bash
#########
#########39 step. FInal Shadow install. 
#########
#6.25. Shadow-4.2.1
step_39_final_shadow_install ()
{

SHADOW="shadow-4.2.1"
SHADOW_SRC_FILE="$SHADOW.tar.xz"

if [ ! -f /sources/$SHADOW_SRC_FILE ]; then
   wget -O /sources/$SHADOW_SRC_FILE $REPOSITORY/$SHADOW_SRC_FILE
fi

cd /sources
tar xf $SHADOW_SRC_FILE
cd $SHADOW
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs
sed -i 's/1000/999/' etc/useradd

./configure --sysconfdir=/etc --with-group-name-max-length=32

make -j$STREAM
make install
mv -v /usr/bin/passwd /bin

#To enable shadowed passwords, run the following command:
pwconv
#To enable shadowed group passwords, run:
grpconv

sed -i 's/yes/no/' /etc/default/useradd

cat > /etc/shadow << "EOF"
root:$6$sbzsHW1h$M9IhJIlI0PrMpxZZs.6QKnH7c5qCO1742XjkzFmBolKMRdDr6py3zqMnHo5CjD3hTskca7ahtkfLYbzax4Y3B0:16464:0:99999:7:::
bin:x:16464:0:99999:7:::
daemon:x:16464:0:99999:7:::
messagebus:x:16464:0:99999:7:::
systemd-bus-proxy:x:16464:0:99999:7:::
systemd-journal-gateway:x:16464:0:99999:7:::
systemd-journal-remote:x:16464:0:99999:7:::
systemd-journal-upload:x:16464:0:99999:7:::
systemd-network:x:16464:0:99999:7:::
systemd-resolve:x:16464:0:99999:7:::
systemd-timesync:x:16464:0:99999:7:::
nobody:x:16464:0:99999:7:::
EOF


chmod -v 400 /etc/shadow


cd ..
rm -rf $SHADOW
}

