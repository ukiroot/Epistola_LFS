#!/bin/bash
step_26_install_mfour ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="m4-1.4.17"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="74ad71fa100ec8c13bc715082757eb9ab1e4bbb0"
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
