#!/bin/bash
#########
#########107 step. Install Dovecot. 
#########
step_107_install_dovecot ()
{

DOVECOT="dovecot-2.2.15"
DOVECOT_SRC_FILE="$DOVECOT.tar.gz"

if [ ! -f /sources/$DOVECOT_SRC_FILE ]; then
   wget -O /sources/$DOVECOT_SRC_FILE $REPOSITORY/$DOVECOT_SRC_FILE
fi

groupadd -g 42 dovecot
useradd -c "Dovecot unprivileged user" -d /dev/null -u 42 -g dovecot -s /bin/false dovecot
groupadd -g 43 dovenull
useradd -c "Dovecot login user" -d /dev/null -u 43 -g dovenull -s /bin/false dovenull
groupadd -g 1000 vmail
useradd -c "Mail box user" vmail -m -g1000 -u1000 -s /bin/false
cd /sources
tar zxf $DOVECOT_SRC_FILE
cd $DOVECOT
#patch -Np1 -i /root_tmp/step/Patch/dovecot-2.2.15_enable_gost.patch
./configure --with-mysql --with-ssl=openssl --prefix=/usr --sysconfdir=/etc/ --with-systemdsystemunitdir=/lib/systemd/system --localstatedir=/var --disable-static --with-mysql
make -j$STREAM
make install
cd ..
rm -rf $DOVECOT
##
##Install unit file
##
systemctl enable dovecot

cat > /etc/dovecot/dovecot.conf << "EOF"
#######
#Dinamyc
#######
protocols = pop3 imap
auth_mechanisms = plain login
disable_plaintext_auth = no
ssl_ca = </etc/ssl/certs/epistola.local.ca.crt
ssl_key = </etc/ssl/private/epistola.local.key
ssl_cert = </etc/ssl/certs/epistola.local.crt
service imap-login {
  inet_listener imap {
    address = 
    port = 143
    reuse_port = no
    ssl = no
  }
  inet_listener imaps {
    address = 127.0.0.1, ::1
    port = 993
    reuse_port = no
    ssl = yes
  }
}
service pop3-login {
  inet_listener pop3 {
    address = 
    port = 110
    reuse_port = no
    ssl = no
  }
  inet_listener pop3s {
    address = 127.0.0.1, ::1
    port = 995
    reuse_port = no
    ssl = yes
  }
}
#######
#Static
#######
ssl = yes
mail_location = maildir:/home/vmail/%d/%u

passdb {
  args = /etc/dovecot/dovecot-mysql.conf
  driver = sql
}
userdb {
  args = /etc/dovecot/dovecot-mysql.conf
  driver = sql
}
EOF

cat > /etc/dovecot/dovecot-mysql.conf << "EOF"
driver = mysql
connect = host=/run/mysqld/mysqld.sock dbname=usermail user=usermail password=SET_PASSWORD
password_query = SELECT password, username AS user FROM mailbox WHERE username = '%u' AND domain = '%d'
user_query = SELECT maildir, 1000 AS uid, 1000 AS gid FROM mailbox WHERE  username = '%u' AND domain = '%d' AND active = '1'
EOF

rm -rf /etc/dovecot/README

}
