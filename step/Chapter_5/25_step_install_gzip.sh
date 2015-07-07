#!/bin/bash
step_25_install_gzip ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="gzip-1.6"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="05bd01fc90178b806e0c13f9526e2ad392084085"
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
