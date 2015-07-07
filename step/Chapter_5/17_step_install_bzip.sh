#!/bin/bash
step_17_install_bzip ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="bzip2-1.0.6"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="3f89f861209ce81a6bab1fd1998c0ef311712002"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   make -j"$STREAM"
   make PREFIX=/tools install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
