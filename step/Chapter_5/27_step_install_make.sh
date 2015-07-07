#!/bin/bash
step_27_install_make ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="make-4.1"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.bz2
   local SRC_FILE_SHA1="0d701882fd6fd61a9652cb8d866ad7fc7de54d58"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   "$SRC_DIR_PATH"/configure --prefix=/tools --without-guile
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make check
   fi
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
