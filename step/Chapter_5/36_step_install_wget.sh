#!/bin/bash
step_36_install_wget ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="wget-1.15"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="e9fb1d25fa04f9c69e74e656a3174dca02700ba1"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   "$SRC_DIR_PATH"/configure \
      --prefix=/tools \
      --without-ssl \
      --without-zlib \
      --disable-ntlm
   make -j"$STREAM"
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
