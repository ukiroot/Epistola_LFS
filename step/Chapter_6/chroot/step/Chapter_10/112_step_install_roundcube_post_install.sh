#!/bin/bash
#########
#########112 step. Install Roundcube. 
#########
step_112_install_roundcube ()
{
cd /var/www/webmail/public_html/
PASS_WEBMAIL_DB=`openssl rand -base64 10`
mysql -uroot -e "CREATE DATABASE webmail;"
mysql -uroot -e "GRANT ALL PRIVILEGES ON webmail.* TO 'webmail'@'localhost' IDENTIFIED BY '"$PASS_WEBMAIL_DB"' WITH GRANT OPTION;"
mysql -uwebmail -p$PASS_WEBMAIL_DB webmail < SQL/mysql.initial.sql
cat ./config/config.inc.php.sample > ./config/config.inc.php
sed -i 's/mysql:\/\/roundcube:pass@localhost\/roundcubemail/mysql:\/\/webmail:'$PASS_WEBMAIL_DB'@localhost\/webmail/' ./config/config.inc.php
cd /
chown -R nginx:nginx /var/www
}



