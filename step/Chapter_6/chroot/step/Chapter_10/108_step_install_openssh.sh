#!/bin/bash
#########
#########108 step. Install Dovecot. 
#########
step_108_install_openssh ()
{

OPENSSH="openssh-6.7p1"
OPENSSH_SRC_FILE="$OPENSSH.tar.gz"

if [ ! -f /sources/$OPENSSH_SRC_FILE ]; then
   wget -O /sources/$OPENSSH_SRC_FILE $REPOSITORY/$OPENSSH_SRC_FILE
fi

install -v -m700 -d /var/lib/sshd
chown   -v root:sys /var/lib/sshd

groupadd -g 50 sshd
useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd

cd /sources
tar zxf $OPENSSH_SRC_FILE
cd $OPENSSH
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-privsep-path=/var/lib/sshd
make -j$STREAM
make install
cd ..
rm -rf $OPENSSH
##
##Install unit file
##
cp /root_tmp/step/systemd-units/units/sshd.service /lib/systemd/system/
systemctl enable sshd.service
}
