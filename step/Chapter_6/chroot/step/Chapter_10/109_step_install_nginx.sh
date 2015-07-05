#!/bin/bash
#########
#########110 step. Install Nginx. 
#########
step_110_install_nginx ()
{


PCRE="pcre-8.35"
PCRE_SRC_FILE="$PCRE.tar.gz"

if [ ! -f /sources/$PCRE_SRC_FILE ]; then
   wget -O /sources/$PCRE_SRC_FILE $REPOSITORY/$PCRE_SRC_FILE
fi

cd /sources
tar zxf $PCRE_SRC_FILE
cd $PCRE
./configure --prefix=/usr
make -j$STREAM
make install
cd ..
rm -rf $PCRE

groupadd -g 47 nginx
useradd -c "Nginx user" -d /var/www -u 47 -g nginx -s /bin/false nginx


NGINX="nginx-1.9.0"
NGINX_SRC_FILE="$NGINX.tar.gz"

if [ ! -f /sources/$NGINX_SRC_FILE ]; then
   wget -O /sources/$NGINX_SRC_FILE $REPOSITORY/$NGINX_SRC_FILE
fi

cd /sources
tar zxf $NGINX_SRC_FILE
cd $NGINX
./configure --prefix=/usr --pid-path=/run/nginx.pid \
	--conf-path=/etc/nginx/nginx.conf \
	--user=nginx \
	--group=nginx \
	--with-http_ssl_module \
	--http-client-body-temp-path=/var/lib/nginx/body-temp \
	--http-proxy-temp-path=/var/lib/nginx/proxy-temp \
	--http-fastcgi-temp-path=/var/lib/nginx/fastcgi-temp \
	--http-uwsgi-temp-path=/var/lib/nginx/uwsgi-temp \
	--http-scgi-temp-path=/var/lib/nginx/scgi-temp \
	--without-mail_pop3_module \
	--without-mail_imap_module \
	--without-mail_smtp_module \
	--without-http_uwsgi_module \
	--without-http_scgi_module \
	--without-http_memcached_module

make
make install
cd ..
rm -rf $NGINX
##
##Install unit file
##
cp /root_tmp/step/systemd-units/units/nginx.service /lib/systemd/system/
systemctl enable nginx.service


#Create config
mkdir -p /var/www/webmail/public_html/
mkdir -p /etc/nginx/conf.d/
mkdir -p /etc/nginx/sites-enabled/
mkdir -p /etc/nginx/sites-available/
mkdir -p /var/lib/nginx
mkdir -p /etc/nginx/site-conf/

chown -R nginx:nginx  /var/www
cat >  /etc/nginx/nginx.conf << "EOF"
user nginx;
worker_processes 2;
pid /run/nginx.pid;

events {
       worker_connections 768;
}

http {
       sendfile on;
       tcp_nopush on;
       tcp_nodelay on;
       keepalive_timeout 900;
       types_hash_max_size 2048;
       include /etc/nginx/mime.types;
       default_type application/octet-stream;
       
       access_log syslog:server=unix:/run/systemd/journal/dev-log;
       error_log syslog:server=unix:/run/systemd/journal/dev-log;

       gzip on;
       gzip_disable "msie6";

       include /etc/nginx/conf.d/*.conf;
       include /etc/nginx/sites-enabled/*;

       client_header_timeout 3m;
       client_body_timeout 3m;
       send_timeout 3m;
}
EOF


cat > /etc/nginx/sites-available/webmail << "EOF"
server {
       listen 443 ssl;
       server_name webmail.epistola.ru www.webmail.epistola.ru;
       ssl                      on;
       ssl_protocols            SSLv3 TLSv1;
       ssl_certificate          /etc/ssl/certs/epistola.local.crt;
       ssl_certificate_key      /etc/ssl/private/epistola.local.key;
       include /etc/nginx/site-conf/webmail;
}
server {
       listen 80;
       server_name webmail.epistola.ru www.webmail.epistola.ru;
       include /etc/nginx/site-conf/webmail;
}
EOF

cat > /etc/nginx/site-conf/webmail << "EOF"
       root /var/www/webmail/public_html;
       index index.php;
       location ~ ^/favicon.ico$ {
                root /var/www/webmail/public_html/skins/default/images;
                log_not_found off;
                access_log off;
                expires max;
       }
       location = /robots.txt {
                allow all;
                log_not_found off;
                access_log off;
       }
       location ~ ^/(README|INSTALL|LICENSE|CHANGELOG|UPGRADING)$ {
                deny all;
       }
       location ~ ^/(bin|SQL)/ {
                deny all;
       }
       # Deny all attempts to access hidden files such as .htaccess, .htpasswd, .DS_Store (Mac).
       location ~ /\. {
                deny all;
                access_log off;
                log_not_found off;
       }
       location ~ \.php$ {
                try_files $uri =404;
                include /etc/nginx/fastcgi_params;
                fastcgi_pass 127.0.0.1:9000;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                fastcgi_index index.php;
      }
EOF

ln -s /etc/nginx/sites-available/webmail /etc/nginx/sites-enabled/

rm -rf /etc/nginx/fastcgi.conf.default
rm -rf /etc/nginx/fastcgi_params.default
rm -rf /etc/nginx/koi-win
rm -rf /etc/nginx/mime.types.default
rm -rf /etc/nginx/nginx.conf.default
rm -rf /etc/nginx/scgi_params.default
rm -rf /etc/nginx/uwsgi_params
rm -rf /etc/nginx/uwsgi_params.default
rm -rf /etc/nginx/scgi_params
}
