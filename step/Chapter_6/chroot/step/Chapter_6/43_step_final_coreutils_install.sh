#!/bin/bash
#########
#########43 step. Final Coreutils install. 
#########
#6.29. Coreutils-8.23
step_43_final_coreutils_install ()
{

COREUTILS="coreutils-8.23"
COREUTILS_SRC_FILE="$COREUTILS.tar.xz"

if [ ! -f /sources/$COREUTILS_SRC_FILE ]; then
   wget -O /sources/$COREUTILS_SRC_FILE $REPOSITORY/$COREUTILS_SRC_FILE
fi

COREUTILS_PATCH_1="coreutils-8.23-i18n-1.patch"

if [ ! -f /sources/$COREUTILS_PATCH_1 ]; then
   wget -O /sources/$COREUTILS_PATCH_1 $REPOSITORY/$COREUTILS_PATCH_1
fi


cd /sources
tar xf $COREUTILS_SRC_FILE
cd $COREUTILS
patch -Np1 -i ../$COREUTILS_PATCH_1
touch Makefile.in
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime
make -j$STREAM
if [ "$1" == "test" ] ; then
   make NON_ROOT_USERNAME=nobody check-root
fi
echo "dummy:x:1000:nobody" >> /etc/group

chown -Rv nobody . 

if [ "$1" == "test" ] ; then
su nobody -s /bin/bash \
          -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"
fi
	  
sed -i '/dummy/d' /etc/group

make install


mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8
#Some packages in BLFS and beyond expect the following programs in /bin, so make sure they are placed there:
mv -v /usr/bin/{head,sleep,nice,test,[} /bin
cd ..
rm -rf $COREUTILS
}
