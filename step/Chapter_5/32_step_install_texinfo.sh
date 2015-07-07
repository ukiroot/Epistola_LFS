#!/bin/bash
step_32_install_texinfo ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="texinfo-5.2"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="fbbc35c5857d11d1164c8445c78b66ad6d472072"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   "$SRC_DIR_PATH"/configure --prefix=/tools
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make check
   fi
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
