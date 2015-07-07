#!/bin/bash
step_28_install_patch ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="patch-2.7.4"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="b2e29867263095e0f8bfd4b1319124b04102f2b0"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR/"

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
