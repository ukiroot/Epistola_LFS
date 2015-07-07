#!/bin/bash
step_35_install_cmake ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="cmake-3.1.1"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="e96098e402903e09f56d0c4cfef516e591088d78"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   "$SRC_DIR_PATH"/configure \
      --prefix=/tools \

   make -j"$STREAM"
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
