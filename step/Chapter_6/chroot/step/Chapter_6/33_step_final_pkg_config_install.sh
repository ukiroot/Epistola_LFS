#!/bin/bash
#########
#########33 step. Final Pkg-config install. 
#########
#6.19. Pkg-config-0.28
step_33_final_pkg_config_install ()
{
PKGCONFIG="pkg-config-0.28"
PKGCONFIG_SRC_FILE="$PKGCONFIG.tar.gz"

if [ ! -f /sources/$PKGCONFIG_SRC_FILE ]; then
   wget -O /sources/$PKGCONFIG_SRC_FILE $REPOSITORY/$PKGCONFIG_SRC_FILE
fi

cd /sources
tar zxf $PKGCONFIG_SRC_FILE
cd $PKGCONFIG
./configure --prefix=/usr         \
            --with-internal-glib  \
            --disable-host-tool   \
            --docdir=/usr/share/doc/$PKGCONFIG
	    
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
cd ..
rm -rf $PKGCONFIG
}
