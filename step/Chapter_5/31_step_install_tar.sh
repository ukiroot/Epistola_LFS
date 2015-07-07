#!/bin/bash
step_31_install_tar ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="tar-1.28"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="40f3470a96b80749531fe48dbba99e43b6dfa7d3"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   #If run from root ned set FORCE_UNSAFE_CONFIGURE in 1
   FORCE_UNSAFE_CONFIGURE=1 "$SRC_DIR_PATH"/configure --prefix=/tools
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make check
   fi
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
