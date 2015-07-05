#!/bin/bash
#########
#########106 step. Install Postfix. 
#########
step_106_install_postfix ()
{

POSTFIX="postfix-3.0.1"
POSTFIX_SRC_FILE="$POSTFIX.tar.gz"

if [ ! -f /sources/$POSTFIX_SRC_FILE ]; then
   wget -O /sources/$POSTFIX_SRC_FILE $REPOSITORY/$POSTFIX_SRC_FILE
fi

#POSTFIX_PATCH_1="postfix-2.11.3_enable_gost.patch"
#if [ ! -f /sources/$POSTFIX_PATCH_1 ]; then
#   wget -O /sources/$POSTFIX_PATCH_1 $REPOSITORY/$POSTFIX_PATCH_1
#fi

groupadd -g 32 postfix
groupadd -g 33 postdrop
useradd -c "Postfix Daemon User" -d /var/spool/postfix -g postfix -s /bin/false -u 32 postfix
chown -v postfix:postfix /var/mail

cd /sources
tar zxf $POSTFIX_SRC_FILE
cd $POSTFIX
#patch -Np1 -i /root_tmp/step/Patch/$POSTFIX_PATCH_1

make AUXLIBS='-lssl -lcrypto -lmysqlclient -lz -lm' CCARGS="-DUSE_TLS -I/usr/include/openssl/ -DHAS_MYSQL -I/usr/include/mysql" makefiles

make -j$STREAM
make upgrade
cd ..
rm -rf $POSTFIX
##
##Install unit file
##
cp /root_tmp/step/systemd-units/units/postfix.service /lib/systemd/system/
systemctl enable postfix.service

#/etc/postfix/main.cf
cat > /etc/postfix/main.cf << "EOF"
#######
#Dynamic
#######
smtpd_banner = $myhostname ESMTP
mydomain = ru
myhostname = epistola.$mydomain

mynetworks = 127.0.0.0/8

inet_interfaces = all
smtp_bind_address = 0.0.0.0

#TLS
smtp_use_tls = yes
smtpd_use_tls = yes
smtpd_tls_key_file = /etc/ssl/private/epistola.local.key
smtpd_tls_cert_file = /etc/ssl/certs/epistola.local.crt
smtpd_tls_CAfile = /etc/ssl/certs/epistola.local.ca.crt

#Relay access denied
smtpd_relay_restrictions = permit_mynetworks, permit_sasl_authenticated, defer_unauth_destination

#######
#Static
#######
#biff - a mail notification tool
biff = no
#recipient_delimiter use special char in address. Example lol+lolichan@example.com
recipient_delimiter = +.
#list domain for get mail
mydestination = 
readme_directory = no
append_dot_mydomain = no
relayhost =
mailbox_size_limit = 0
#Need for skip warning
#warning: hash:/etc/aliases is unavailable. open database /etc/aliases.db: No such file or directory
#warning: hash:/etc/aliases: lookup of 'admin' failed
alias_database =
alias_maps = 

virtual_transport = dovecot
relay_domains = mysql:/etc/postfix/mysql_relay_domains_maps.cf
relay_recipient_maps = mysql:/etc/postfix/mysql_relay_recipient_maps.cf
virtual_alias_maps = mysql:/etc/postfix/mysql_virtual_alias_maps.cf
virtual_mailbox_domains = mysql:/etc/postfix/mysql_virtual_domains_maps.cf
EOF

cat > /etc/postfix/master.cf << "EOF"
25      inet  n       -       n       -       -       smtpd
587      inet  n       -       n       -       -       smtpd
2525      inet  n       -       n       -       -       smtpd
465     inet  n       -       n       -       -       smtpd
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
pickup    unix  n       -       n       60      1       pickup
cleanup   unix  n       -       n       -       0       cleanup
qmgr      unix  n       -       n       300     1       qmgr
tlsmgr    unix  -       -       n       1000?   1       tlsmgr
rewrite   unix  -       -       n       -       -       trivial-rewrite
bounce    unix  -       -       n       -       0       bounce
defer     unix  -       -       n       -       0       bounce
trace     unix  -       -       n       -       0       bounce
verify    unix  -       -       n       -       1       verify
flush     unix  n       -       n       1000?   0       flush
proxymap  unix  -       -       n       -       -       proxymap
proxywrite unix -       -       n       -       1       proxymap
smtp      unix  -       -       n       -       -       smtp
relay     unix  -       -       n       -       -       smtp
showq     unix  n       -       n       -       -       showq
error     unix  -       -       n       -       -       error
retry     unix  -       -       n       -       -       error
discard   unix  -       -       n       -       -       discard
local     unix  -       n       n       -       -       local
virtual   unix  -       n       n       -       -       virtual
lmtp      unix  -       -       n       -       -       lmtp
anvil     unix  -       -       n       -       1       anvil
scache    unix  -       -       n       -       1       scache
dovecot unix  -       n       n       -       -       pipe
    flags=DRhu user=vmail argv=/usr/libexec/dovecot/deliver -d ${recipient}
EOF

cat > /etc/postfix/mysql_relay_domains_maps.cf << "EOF"
user=usermail
password=SET_PASSWORD
dbname=usermail
host=/run/mysqld/mysqld.sock
query = SELECT domain FROM domain WHERE domain='%s' AND backupmx = '1' AND active = '1' 
EOF

cat > /etc/postfix/mysql_relay_recipient_maps.cf << "EOF"
user=usermail
password=SET_PASSWORD
dbname=usermail
host=/run/mysqld/mysqld.sock
query = SELECT goto FROM alias WHERE address='%s' AND active = 1
EOF

cat > /etc/postfix/mysql_virtual_alias_maps.cf << "EOF"
user=usermail
password=SET_PASSWORD
dbname=usermail
host=/run/mysqld/mysqld.sock
query = SELECT goto FROM alias WHERE address='%s' AND active = '1'
EOF

cat > /etc/postfix/mysql_virtual_domains_maps.cf << "EOF"
user=usermail
password=SET_PASSWORD
dbname=usermail
host=/run/mysqld/mysqld.sock
query = SELECT domain FROM domain WHERE domain='%s' AND backupmx = '0' AND active = '1'
EOF

rm -rf /etc/postfix/transport
rm -rf /etc/postfix/relocated
rm -rf /etc/postfix/virtual
rm -rf /etc/postfix/canonical
rm -rf /etc/postfix/LICENSE
rm -rf /etc/postfix/TLS_LICENSE
rm -rf /etc/postfix/makedefs.out
rm -rf /etc/postfix/generic
rm -rf /etc/postfix/header_checks
rm -rf /etc/postfix/access
rm -rf /etc/postfix/aliases
}
