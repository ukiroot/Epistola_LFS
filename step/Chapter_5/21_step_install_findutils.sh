#!/bin/bash
step_21_install_findutils ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="findutils-4.4.2"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="e8dd88fa2cc58abffd0bfc1eddab9020231bb024"
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
