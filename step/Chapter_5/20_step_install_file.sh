#!/bin/bash
step_20_install_file ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="file-5.22"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="20fa06592291555f2b478ea2fb70b53e9e8d1f7c"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   "$SRC_DIR_PATH"/configure --prefix=/tools
   make -j$STREAM
   if [ "$1" == "test" ] ; then
      make check
   fi
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
