#!/bin/bash
step_15_install_ncurses ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="ncurses-5.9"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.gz
   local SRC_FILE_SHA1="3e042e5f2c7223bffdaac9646a533b8c758b65b5"
   local PATCH_1="ncurses-5.9-gcc5_buildfixes-1.patch"
   local PATCH_1_SHA1="18b1449d3c22d204ee75827322db4bf84b771c94"
   local PATCH_1_WITH_PATH="$LFS"/sources/"$PATCH_1"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"
   get_check_extract_src \
      "$PATCH_1" \
      "$PATCH_1_SHA1"

   pushd "$SRC_DIR_PATH"
   patch -Np1 -i "$PATCH_1_WITH_PATH"
   ./configure \
      --prefix=/tools \
      --with-shared   \
      --without-debug \
      --without-ada   \
      --enable-widec  \
      --enable-overwrite
   make -j"$STREAM"
   make install
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
