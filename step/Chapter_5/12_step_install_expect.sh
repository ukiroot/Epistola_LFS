#!/bin/bash
step_12_install_expect ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="expect5.45"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="e634992cab35b7c6931e1f21fbb8f74d464bd496"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   cp -v configure{,.orig}
   sed 's:/usr/local/bin:/bin:' configure.orig > configure
   "$SRC_DIR_PATH"/configure \
      --prefix=/tools \
      --with-tcl=/tools/lib \
      --with-tclinclude=/tools/include
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make test
   fi
   make SCRIPTS="" install
   popd
   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
