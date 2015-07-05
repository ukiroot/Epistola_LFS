#!/bin/bash
#########
#########82 step. Final Textinfo install. 
#########
#6.68. Texinfo-5.2
step_82_final_text_info_install ()
{

TEXTINFO="texinfo-5.2"
TEXTINFO_SRC_FILE="$TEXTINFO.tar.xz"

if [ ! -f /sources/$TEXTINFO_SRC_FILE ]; then
   wget -O /sources/$TEXTINFO_SRC_FILE $REPOSITORY/$TEXTINFO_SRC_FILE
fi

cd /sources
tar xf $TEXTINFO_SRC_FILE
cd $TEXTINFO
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make check
fi
make install
if [ "$2" == "doc" ] ; then
   make TEXMF=/usr/share/texmf install-tex
#The Info documentation system uses a plain text file to hold its list of menu entries. The file is located at /usr/share/info/dir. Unfortunately, due to occasional problems in the Makefiles of various packages, it can sometimes get out of sync with the info pages installed on the system. If the /usr/share/info/dir file ever needs to be recreated, the following optional commands will accomplish the task:

   pushd /usr/share/info
   rm -v dir
   for f in *
     do install-info $f dir 2>/dev/null
   done
   popd
   cd ..
fi
rm -rf $TEXTINFO
}
