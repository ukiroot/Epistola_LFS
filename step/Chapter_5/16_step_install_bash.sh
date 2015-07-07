#!/bin/bash
step_16_install_bash ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="bash-4.3.30"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="33b1bcc5dca1b72f28b2baeca6efa0d422097964"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   "$SRC_DIR_PATH"/configure \
      --prefix=/tools \
      --without-bash-malloc
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make tests
   fi
   make install
   ln -sv bash /tools/bin/sh
   popd
   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
