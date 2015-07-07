#!/bin/bash
step_6_install_linux_api_headers ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="linux-4.0.1"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="678feded15d79675bd2301c0cd138707f6fb7c43"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   make mrproper
   make INSTALL_HDR_PATH=dest headers_install
   cp -rv dest/include/* /tools/include
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
