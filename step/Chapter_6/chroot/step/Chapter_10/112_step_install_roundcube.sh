#!/bin/bash
#########
#########112 step. Install Roundcube. 
#########
step_112_install_roundcube ()
{

ROUNDCUBEMAIL="roundcubemail-1.1.1"
ROUNDCUBEMAIL_SRC_FILE="$ROUNDCUBEMAIL.tar.gz"

if [ ! -f /sources/$ROUNDCUBEMAIL_SRC_FILE ]; then
   wget -O /sources/$ROUNDCUBEMAIL_SRC_FILE $REPOSITORY/$ROUNDCUBEMAIL_SRC_FILE
fi

cp /sources/$ROUNDCUBEMAIL_SRC_FILE /var/www/webmail
cd /var/www/webmail
rm -rf public_html
tar zxf $ROUNDCUBEMAIL_SRC_FILE
rm -rf $ROUNDCUBEMAIL_SRC_FILE
mv $ROUNDCUBEMAIL public_html
cd /

}



