#!/bin/bash
step_30_install_sed ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="sed-4.2.2"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.bz2
   local SRC_FILE_SHA1="f17ab6b1a7bcb2ad4ed125ef78948092d070de8f"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   ./configure --prefix=/tools
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make check
   fi
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
