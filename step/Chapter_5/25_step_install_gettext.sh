#!/bin/bash
#########
step_25_install_gettext ()
{
echo 'step_25_install_gettext' >> /tmp/log

GETTEXT="gettext-0.19.4"
GETTEXT_SRC_FILE="$GETTEXT.tar.xz"

if [ ! -f $LFS/sources/$GETTEXT_SRC_FILE ]; then
   wget -O $LFS/sources/$GETTEXT_SRC_FILE $REPOSITORY/$GETTEXT_SRC_FILE
fi

cd $LFS/sources/
tar -xf $GETTEXT_SRC_FILE
cd ./$GETTEXT
cd ./gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared
make -C gnulib-lib
#
#
make -C intl pluralx.c
#
#
make -C src msgfmt
make -C src msgmerge
make -C src xgettext
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
cd ../../
rm -rf $GETTEXT
}
