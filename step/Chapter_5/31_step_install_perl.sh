#!/bin/bash
#########
step_31_install_perl ()
{
echo 'step_31_install_perl' >> /tmp/log

PERL="perl-5.20.2"
PERLV="5.20.2"
PERL_SRC_FILE="$PERL.tar.bz2"

if [ ! -f $LFS/sources/$PERL_SRC_FILE ]; then
   wget -O $LFS/sources/$PERL_SRC_FILE $REPOSITORY/$PERL_SRC_FILE
fi


PERL_PATCH="perl-5.20.2-gcc5_fixes-1.patch"

if [ ! -f $LFS/sources/$PERL_PATCH ]; then
   wget -O $LFS/sources/$PERL_PATCH $REPOSITORY/$PERL_PATCH
fi

cd $LFS/sources/
tar xjf $PERL_SRC_FILE
cd ./$PERL

patch -Np1 -i ../$PERL_PATCH

sh Configure -des -Dprefix=/tools -Dlibs=-lm
make -j$STREAM
cp -v perl cpan/podlators/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/$PERLV
cp -Rv lib/* /tools/lib/perl5/$PERLV
cd ..
rm -rf $PERL
}
