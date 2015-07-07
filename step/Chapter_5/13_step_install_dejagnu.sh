#!/bin/bash
step_13_install_dejagnu ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="dejagnu-1.5.3"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="d81288e7d7bd38e74b7fee8e570ebfa8c21508d9"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   ./configure --prefix=/tools
   make install
   if [ "$1" == "test" ] ; then
      make check
   fi
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
