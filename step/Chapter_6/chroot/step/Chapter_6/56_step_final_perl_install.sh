#!/bin/bash
#########
#########56 step. Final Perl install. 
#########
#6.42. Perl-5.20.1
step_56_final_perl_install ()
{

PERL="perl-5.20.2"
PERL_SRC_FILE="$PERL.tar.bz2"

if [ ! -f /sources/$PERL_SRC_FILE ]; then
   wget -O /sources/$PERL_SRC_FILE $REPOSITORY/$PERL_SRC_FILE
fi

PERL_PATCH_1="perl-5.20.2-gcc5_fixes-1.patch"

if [ ! -f /sources/$PERL_PATCH_1 ]; then
   wget -O /sources/$PERL_PATCH_1 $REPOSITORY/$PERL_PATCH_1
fi

cd /sources
tar xjf $PERL_SRC_FILE
cd $PERL
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
export BUILD_ZLIB=False
export BUILD_BZIP2=0
patch -Np1 -i ../$PERL_PATCH_1
sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib
make -j$STREAM
if [ "$1" == "test" ] ; then
	make -k test
fi
make install
unset BUILD_ZLIB BUILD_BZIP2
cd ..
rm -rf $PERL
}