#!/bin/bash
step_8_install_libstdc ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="gcc-5.1.0"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.bz2
   local SRC_FILE_SHA1="b6c947b09adf780fe02065d0c48bfd7b4bdddfa3"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"
   local BUILD_DIR_PATH="$LFS"/sources/gcc-build

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   mkdir -pv "$BUILD_DIR_PATH"
   pushd "$BUILD_DIR_PATH"
   "$SRC_DIR_PATH"/libstdc++-v3/configure \
      --host="$LFS_TGT"                 \
      --prefix=/tools                 \
      --disable-multilib              \
      --disable-nls                   \
      --disable-libstdcxx-threads     \
      --disable-libstdcxx-pch         \
      --with-gxx-include-dir=/tools/"$LFS_TGT"/include/c++/5.1.0
   make -j"$STREAM"
   make install
   make clean
   popd

   rm -rf "$BUILD_DIR_PATH"
   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
