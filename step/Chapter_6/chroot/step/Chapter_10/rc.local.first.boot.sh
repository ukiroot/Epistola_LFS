#!/bin/bash

cat > /etc/rc.local << "EOF"
#!/bin/bash
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
#Set password_for_root_mysql
PASS_ROOT_DB=`openssl rand -base64 100 | sed -r 's/\=|\+|\///g' | grep -o ".............." | head -n1`
echo "$PASS_ROOT_DB" > /etc/mysql/root_password
chmod 400 /etc/mysql/root_password
sleep 10
mysqladmin -uroot password "$PASS_ROOT_DB"

#Create user, databases for roundcube. Import roundcube mysql dump in database
cd /var/www/webmail/public_html/
PASS_WEBMAIL_DB=`openssl rand -base64 100 | sed -r 's/\=|\+|\///g' | grep -o ".............." | head -n1`
mysql -uroot -p"$PASS_ROOT_DB" -e "CREATE DATABASE webmail;"
mysql -uroot -p"$PASS_ROOT_DB" -e "GRANT ALL PRIVILEGES ON webmail.* TO 'webmail'@'localhost' IDENTIFIED BY '"$PASS_WEBMAIL_DB"' WITH GRANT OPTION;"
mysql -uwebmail -p"$PASS_WEBMAIL_DB" webmail < SQL/mysql.initial.sql
cat ./config/config.inc.php.sample > ./config/config.inc.php
sed -i 's/mysql:\/\/roundcube:pass@localhost\/roundcubemail/mysql:\/\/webmail:'$PASS_WEBMAIL_DB'@localhost\/webmail/' ./config/config.inc.php
cd /
chown -R nginx:nginx /var/www

PASS_USERMAIL_DB=`openssl rand -base64 100 | sed -r 's/\=|\+|\///g' | grep -o ".............." | head -n1`
mysql -uroot -p"$PASS_ROOT_DB" -e "CREATE DATABASE usermail;"
mysql -uroot -p"$PASS_ROOT_DB" -e "GRANT ALL PRIVILEGES ON usermail.* TO 'usermail'@'localhost' IDENTIFIED BY '"$PASS_USERMAIL_DB"' WITH GRANT OPTION;"

mysql -uroot -p"$PASS_ROOT_DB" -e "
CREATE TABLE alias (
  address varchar(255) NOT NULL,
  goto text NOT NULL,
  domain varchar(255) NOT NULL,
  created datetime NOT NULL default '0000-00-00 00:00:00',
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1');

CREATE TABLE domain (
  domain varchar(255) NOT NULL,
  description varchar(255) NOT NULL,
  aliases int(10) NOT NULL default '0',
  mailboxes int(10) NOT NULL default '0',
  maxquota bigint(20) NOT NULL default '0',
  quota bigint(20) NOT NULL default '0',
  transport varchar(255) NOT NULL,
  backupmx tinyint(1) NOT NULL default '0',
  created datetime NOT NULL default '0000-00-00 00:00:00',
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1' );

CREATE TABLE mailbox (
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  maildir varchar(255) NOT NULL,
  quota bigint(20) NOT NULL default '0',
  domain varchar(255) NOT NULL,
  created datetime NOT NULL default '0000-00-00 00:00:00',
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1',
  local_part varchar(255) NOT NULL );" usermail

mysql -uroot -p"$PASS_ROOT_DB" -e "INSERT INTO domain ( domain, description, transport ) VALUES ( 'epistola.local', ' ', 'virtual' );
INSERT INTO mailbox ( username, password, name, maildir, domain, local_part ) VALUES ( 'admin@epistola.local', '{PLAIN}admin', 'admin', 'epistola.local/', 'epistola.local', 'admin' );
INSERT INTO alias ( address, goto, domain ) VALUES ( 'admin@epistola.local', 'admin@epistola.local', 'epistola.local' );" usermail

#Dovecot
sed -i 's/SET_PASSWORD/'$PASS_USERMAIL_DB'/' /etc/dovecot/dovecot-mysql.conf
#Postfix
sed -i 's/SET_PASSWORD/'$PASS_USERMAIL_DB'/' /etc/postfix/mysql_relay_domains_maps.cf 
sed -i 's/SET_PASSWORD/'$PASS_USERMAIL_DB'/' /etc/postfix/mysql_relay_recipient_maps.cf 
sed -i 's/SET_PASSWORD/'$PASS_USERMAIL_DB'/' /etc/postfix/mysql_virtual_alias_maps.cf 
sed -i 's/SET_PASSWORD/'$PASS_USERMAIL_DB'/' /etc/postfix/mysql_virtual_domains_maps.cf


mkdir /tmp/ca
cd /tmp/ca

mkdir x509-types
mkdir -p pki/certs_by_serial
mkdir -p pki/certs
mkdir -p pki/private
mkdir -p pki/reqs
touch pki/index.txt
echo 01 > pki/crlnumber
echo 01 > pki/serial

#CA
echo "
basicConstraints =critical, CA:TRUE
subjectKeyIdentifier = hash
keyUsage = cRLSign, keyCertSign
" > x509-types/ca
#Client
echo "
basicConstraints =critical, CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid
extendedKeyUsage = clientAuth
keyUsage = digitalSignature
" > x509-types/client
#Server
echo "
basicConstraints =critical, CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid
extendedKeyUsage = serverAuth
keyUsage = digitalSignature,keyEncipherment
" > x509-types/server
echo "
basicConstraints =critical, CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid
extendedKeyUsage = serverAuth, clientAuth
keyUsage = digitalSignature,keyEncipherment
" > x509-types/serverClient
echo "
crlDistributionPoints = URI:http://pki.epistola.local/epistola.crl
" > x509-types/COMMON

echo '
[ ca ]
default_ca = CA_default
[ CA_default ]
dir = ./pki
certs = $dir
crl_dir = $dir
crlnumber = $dir/crlnumber
database = $dir/index.txt
new_certs_dir = $dir/certs_by_serial
certificate = $dir/ca.crt
serial = $dir/serial
crl = $dir/crl.pem
private_key = $dir/private/ca.key
RANDFILE = $dir/.rand
x509_extensions = basic_exts
crl_extensions = crl_ext
default_days = 365
default_crl_days = 30
default_md = default
preserve = no
policy = policy_anything
[ policy_anything ]
countryName = optional
stateOrProvinceName = optional
localityName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
name = optional
emailAddress = optional
[ req ]
default_bits = 2048
default_keyfile = privkey.pem
default_md = default
distinguished_name = org
x509_extensions = clineos_ca
[ org ]
commonName = Common Name (eg: your user, host, or server name)
commonName_max = 64
commonName_default = ClineOS.ru
countryName = Country Name (2 letter code)
countryName_default = RU
countryName_min = 2
countryName_max = 2
stateOrProvinceName = State or Province Name (full name)
stateOrProvinceName_default = California
localityName = Locality Name (eg, city)
localityName_default = Francisco
0.organizationName = Organization Name (eg, company)
0.organizationName_default = Organization
organizationalUnitName = Organizational Unit Name (eg, section)
organizationalUnitName_default = "Organizational Unit"
emailAddress = Email Address
emailAddress_default = i@clineos.ru
emailAddress_max = 64
[ basic_exts ]
basicConstraints = CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
[ clineos_ca ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints = CA:true
keyUsage = cRLSign, keyCertSign
[ crl_ext ]
authorityKeyIdentifier = keyid:always,issuer:always
' > openssl-1.0.cnf


sed -i 's/commonName_default\ =.*/commonName_default\ =\ Epistola.local.ca/' openssl-1.0.cnf
sed -i 's/countryName_default\ =.*/countryName_default\ =\ RU/' openssl-1.0.cnf
sed -i 's/stateOrProvinceName_default\ =.*/stateOrProvinceName_default\ =\ SeveroZapad/' openssl-1.0.cnf
sed -i 's/localityName_default\ =.*/localityName_default\ =\ Saint-Petersburg/' openssl-1.0.cnf
sed -i 's/0.organizationName_default\ =.*/0.organizationName_default\ =\ Epistola/' openssl-1.0.cnf
sed -i 's/organizationalUnitName_default\ =.*/organizationalUnitName_default\ =\ Epistola/' openssl-1.0.cnf
sed -i 's/emailAddress_default\ =.*/emailAddress_default\ =\ admin@epistola.local/' openssl-1.0.cnf
openssl req -new -newkey rsa:2048 -config ./openssl-1.0.cnf -keyout ./pki/private/ca.key -out ./pki/ca.crt -nodes -batch -x509 -days 3650


openssl ca -verbose -gencrl -out ./pki/crl.pem -config openssl-1.0.cnf


CERTNAME=epistola.local
cat ./x509-types/server > ./x509-types/$CERTNAME
cat ./x509-types/COMMON >>  ./x509-types/$CERTNAME
sed -i 's/commonName_default\ =.*/commonName_default\ =\ Epistola.local.server/' openssl-1.0.cnf
sed -i 's/countryName_default\ =.*/countryName_default\ =\ RU/' openssl-1.0.cnf
sed -i 's/stateOrProvinceName_default\ =.*/stateOrProvinceName_default\ =\ SeveroZapad/' openssl-1.0.cnf
sed -i 's/localityName_default\ =.*/localityName_default\ =\ Saint-Petersburg/' openssl-1.0.cnf
sed -i 's/0.organizationName_default\ =.*/0.organizationName_default\ =\ Epistola/' openssl-1.0.cnf
sed -i 's/organizationalUnitName_default\ =.*/organizationalUnitName_default\ =\ Epistola/' openssl-1.0.cnf
sed -i 's/emailAddress_default\ =.*/emailAddress_default\ =\ admin@epistola.local/' openssl-1.0.cnf
openssl req -new -newkey rsa:2048 -config ./openssl-1.0.cnf -keyout ./pki/private/$CERTNAME.key -out ./pki/reqs/$CERTNAME.req -nodes -batch
touch ./pki/certs/$CERTNAME.crt
openssl ca -in ./pki/reqs/$CERTNAME.req -out ./pki/certs/$CERTNAME.crt -config ./openssl-1.0.cnf -extfile ./x509-types/$CERTNAME -days 3650 -batch


mkdir -p /etc/ssl/private/ca/epistola.local/
mv pki/private/ca.key /etc/ssl/private/ca/epistola.local/
mv pki/private/epistola.local.key /etc/ssl/private/
mv pki/certs/epistola.local.crt /etc/ssl/certs/
mv pki/ca.crt /etc/ssl/certs/epistola.local.ca.crt

cd /
rm -rf /tmp/ca

#chmod -R 400 /etc/ssl/private
systemctl restart postfix 
systemctl restart dovecot
rm -rf /etc/rc.local
rm /etc/systemd/system/multi-user.target.wants/rc-local.service
EOF

ln -sv /lib/systemd/system/rc-local.service /etc/systemd/system/multi-user.target.wants/
chmod 700 /etc/rc.local