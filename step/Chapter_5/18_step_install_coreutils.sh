#!/bin/bash
step_18_install_coreutils ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="coreutils-8.23"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="adead02839225218b85133fa57b4dba02af2291d"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   #If run from root ned set FORCE_UNSAFE_CONFIGURE in 1
   FORCE_UNSAFE_CONFIGURE=1 "$SRC_DIR_PATH"/configure \
      --prefix=/tools \
      --enable-install-program=hostname
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make RUN_EXPENSIVE_TESTS=yes check
   fi
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
