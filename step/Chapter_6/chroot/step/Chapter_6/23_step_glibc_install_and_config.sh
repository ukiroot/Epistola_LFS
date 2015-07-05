#!/bin/bash
#########
#########23 step. Glibc in chroot. 
#########
#6.9. Glibc-2.20
step_23_glibc_install_and_config ()
{
GLIBC="glibc-2.21"
GLIBC_SRC_FILE="$GLIBC.tar.xz"

if [ ! -f /sources/$GLIBC_SRC_FILE ]; then
   wget -O /sources/$GLIBC_SRC_FILE $REPOSITORY/$GLIBC_SRC_FILE
fi

cd /sources
tar -xf $GLIBC_SRC_FILE
cd $GLIBC

mkdir -v ../glibc-build
cd ../glibc-build

../$GLIBC/configure    \
    --prefix=/usr          \
    --disable-profile      \
    --enable-kernel=2.6.32 \
    --enable-obsolete-rpc
    
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
#Though it is a harmless message, the install stage of Glibc will complain about the absence of /etc/ld.so.conf. Prevent this warning with:
touch /etc/ld.so.conf
make install
#Install the configuration file and runtime directory for nscd:
cp -v ../$GLIBC/nscd/nscd.conf /etc/nscd.conf
mkdir -pv /var/cache/nscd
#Install the systemd support files for nscd:
install -v -Dm644 ../$GLIBC/nscd/nscd.tmpfiles /usr/lib/tmpfiles.d/nscd.conf
install -v -Dm644 ../$GLIBC/nscd/nscd.service /lib/systemd/system/nscd.service
# The following instructions will install the minimum set of locales necessary for the optimal coverage of tests:
mkdir -pv /usr/lib/locale
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
localedef -i de_DE -f ISO-8859-1 de_DE
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
localedef -i de_DE -f UTF-8 de_DE.UTF-8
localedef -i en_GB -f UTF-8 en_GB.UTF-8
localedef -i en_HK -f ISO-8859-1 en_HK
localedef -i en_PH -f ISO-8859-1 en_PH
localedef -i en_US -f ISO-8859-1 en_US
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i es_MX -f ISO-8859-1 es_MX
localedef -i fa_IR -f UTF-8 fa_IR
localedef -i fr_FR -f ISO-8859-1 fr_FR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
localedef -i it_IT -f ISO-8859-1 it_IT
localedef -i it_IT -f UTF-8 it_IT.UTF-8
localedef -i ja_JP -f EUC-JP ja_JP
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
localedef -i zh_CN -f GB18030 zh_CN.GB18030
#Alternatively ???????
#make localedata/install-locales

#6.9.2. Configuring Glibc
#Create a new file /etc/nsswitch.conf by running the following:
cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns myhostname
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF
#Install timezone data:

TZDATA="tzdata2014j"
TZDATA_SRC_FILE="$TZDATA.tar.gz"
mkdir /sources/$TZDATA

if [ ! -f /sources/$TZDATA_SRC_FILE ]; then
   wget -O /sources/$TZDATA/$TZDATA_SRC_FILE $REPOSITORY/$TZDATA_SRC_FILE
fi

cd /sources/$TZDATA
tar -xf $TZDATA_SRC_FILE

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

ln -sfv /usr/share/zoneinfo/Europe/Moscow /etc/localtime


#6.9.3. Configuring the Dynamic Loader
#Create a new file /etc/ld.so.conf by running the following:
cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF
#If desired, the dynamic loader can also search a directory and include the contents of files found there. Generally the files in this include directory are one line specifying the desired library path. To add this capability run the following commands:
cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir -pv /etc/ld.so.conf.d

rm -rf /sources/$GLIBC
rm -rf /sources/glibc-build
rm -rf /sources/$TZDATA
}
