#!/bin/bash
#########
#########97 step. The end. 
#########
#9.1. The End
step_97_the_end ()
{
#Strip
/tools/bin/find /{,usr/}{bin,lib,sbin} -type f \
    -exec /tools/bin/strip --strip-debug '{}' ';'
    
set +o errexit
rm -rf /sources
rm -rf /root_tmp
rm -rf /usr/bin/x86_64*
rm -rf /usr/docs/*
rm -rf  /usr/share/doc/*
rm -rf /usr/share/info/
rm -rf /usr/share/man/
rm -rf /usr/share/gtk-doc/
rm -rf /usr/share/mysql/test
rm -rf /usr/lib/cmake
rm -rf /usr/include/*
set -o errexit
#Stage1
rm -rf /tools
rm -rf /opt/*

export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

#Set release
cat > /etc/os-release << "EOF"
NAME="Linux Epistola"
VERSION="20141228-systemd"
ID=epistola
PRETTY_NAME="Linux Epistola 20141228-systemd"
EOF

echo 20141228-systemd > /etc/lfs-release

cat > /etc/epistola-release << "EOF"
DISTRIB_ID="Linux Epistola"
DISTRIB_RELEASE="20141228-systemd"
DISTRIB_CODENAME="Epistola with a surprise"
DISTRIB_DESCRIPTION="Linux Epistola"
EOF
}
