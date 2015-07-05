#!/bin/bash
#########
#########111 step. Install Php. 
#########
step_111_install_php ()
{


LIBXML="libxml2-2.9.2"
LIBXML_SRC_FILE="$LIBXML.tar.gz"

if [ ! -f /sources/$LIBXML_SRC_FILE ]; then
   wget -O /sources/$LIBXML_SRC_FILE $REPOSITORY/$LIBXML_SRC_FILE
fi

cd /sources
tar zxf $LIBXML_SRC_FILE
cd $LIBXML
./configure --prefix=/usr
make -j$STREAM
make install
cd ..
rm -rf $LIBXML

PHP="php-5.5.21"
PHP_SRC_FILE="$PHP.tar.gz"

if [ ! -f /sources/$PHP_SRC_FILE ]; then
   wget -O /sources/$PHP_SRC_FILE $REPOSITORY/$PHP_SRC_FILE
fi


cd /sources
tar zxf $PHP_SRC_FILE
cd $PHP
./configure --prefix=/usr                \
            --sysconfdir=/etc/php            \
            --localstatedir=/var         \
            --datadir=/usr/share/php     \
            --mandir=/usr/share/man      \
            --enable-fpm                 \
            --with-fpm-user=nginx       \
            --with-fpm-group=nginx      \
            --with-config-file-path=/etc \
            --with-zlib                  \
            --enable-bcmath              \
            --with-bz2                   \
            --enable-calendar            \
            --enable-dba=shared          \
            --with-gdbm                  \
            --with-gmp                   \
            --enable-ftp                 \
            --with-gettext               \
            --enable-mbstring            \
            --with-readline	\
	    --with-mysql \
	    --with-pdo-mysql \
	    --with-mysql-sock=/run/mysqld/mysqld.sock

make -j$STREAM
make install

rm /etc/php/php-fpm.conf.default
cat > /etc/php/php-fpm.conf << "EOF"
[global]
error_log = syslog
syslog.facility = daemon
syslog.ident = php-fpm
log_level = notice

[www]
user = nginx
group = nginx
listen = 127.0.0.1:9000
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
EOF
cd ..
rm -rf $PHP

cat > /etc/php/php.ini << "EOF"
[PHP]
engine = On
short_open_tag = Off
asp_tags = Off
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = 17
disable_functions =
disable_classes =
zend.enable_gc = On
expose_php = On
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
display_errors = Off
display_startup_errors = Off
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
track_errors = Off
html_errors = On
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 8M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
doc_root =
user_dir =
enable_dl = Off
file_uploads = On
upload_max_filesize = 2M
max_file_uploads = 20
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60

[CLI Server]
cli_server.color = On

[Pdo_mysql]
pdo_mysql.cache_size = 2000
pdo_mysql.default_socket=

[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = On
[SQL]
sql.safe_mode = Off

[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1

[Interbase]
ibase.allow_persistent = 1
ibase.max_persistent = -1
ibase.max_links = -1
ibase.timestampformat = "%Y-%m-%d %H:%M:%S"
ibase.dateformat = "%Y-%m-%d"
ibase.timeformat = "%H:%M:%S"

[MySQL]
mysql.allow_local_infile = On
mysql.allow_persistent = On
mysql.cache_size = 2000
mysql.max_persistent = -1
mysql.max_links = -1
mysql.default_port =
mysql.default_socket = "/run/mysqld/mysqld.sock"
mysql.default_host =
mysql.default_user =
mysql.default_password =
mysql.connect_timeout = 60
mysql.trace_mode = Off

[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.cache_size = 2000
mysqli.default_port = 3306
mysqli.default_socket = 
mysqli.default_host =
mysqli.default_user =
mysqli.default_pw =
mysqli.reconnect = Off

[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = Off

[Sybase-CT]
sybct.allow_persistent = On
sybct.max_persistent = -1
sybct.max_links = -1
sybct.min_server_severity = 10
sybct.min_client_severity = 10

[bcmath]
bcmath.scale = 0

[Session]
session.save_handler = files
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.hash_function = 0
session.hash_bits_per_character = 5
url_rewriter.tags = "a=href,area=href,frame=src,input=src,form=fakeentry"

[Tidy]
tidy.clean_output = Off
[soap]
soap.wsdl_cache_enabled=1
soap.wsdl_cache_dir="/tmp"
soap.wsdl_cache_ttl=86400
soap.wsdl_cache_limit = 5
EOF


##
##Install unit file
##
cp /root_tmp/step/systemd-units/units/php-fpm.service /lib/systemd/system/
systemctl enable php-fpm.service
}
