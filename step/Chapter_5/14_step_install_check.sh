#!/bin/bash
step_14_install_check ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="check-0.9.14"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="4b79e2d485d014ddb438e322b64235347d57b0ff"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   PKG_CONFIG= "$SRC_DIR_PATH"/configure --prefix=/tools
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make check
   fi
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
