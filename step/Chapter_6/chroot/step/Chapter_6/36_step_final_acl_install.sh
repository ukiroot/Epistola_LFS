#!/bin/bash
#########
#########36 step. Final Acl install. 
#########
#6.22. Acl-2.2.52
step_36_final_acl_install ()
{

ACL="acl-2.2.52"
ACL_SRC_FILE="$ACL.src.tar.gz"

if [ ! -f /sources/$ACL_SRC_FILE ]; then
   wget -O /sources/$ACL_SRC_FILE $REPOSITORY/$ACL_SRC_FILE
fi

cd /sources
tar zxf $ACL_SRC_FILE
cd $ACL
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test
sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c
./configure --prefix=/usr --libexecdir=/usr/lib
make -j$STREAM
make install install-dev install-lib
chmod -v 755 /usr/lib/libacl.so
mv -v /usr/lib/libacl.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so
cd ..
rm -rf $ACL
}
