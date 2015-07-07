#!/bin/bash
step_9_install_binutils_pass_two ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="binutils-2.25"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.bz2
   local SRC_FILE_SHA1="b46cc90ebaba7ffcf6c6d996d60738881b14e50d"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"
   local BUILD_DIR_PATH="$LFS"/sources/binutils-build

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   mkdir -v "$BUILD_DIR_PATH"
   pushd "$BUILD_DIR_PATH"
   CC="$LFS_TGT"-gcc                \
   AR="$LFS_TGT"-ar                 \
   RANLIB="$LFS_TGT"-ranlib         \
   "$SRC_DIR_PATH"/configure     \
      --prefix=/tools            \
      --disable-nls              \
      --disable-werror           \
      --with-lib-path=/tools/lib \
      --with-sysroot
   make -j"$STREAM"
   make install
   make -C ld clean
   make -C ld LIB_PATH=/usr/lib:/lib
   cp -v ld/ld-new /tools/bin
   make clean
   popd

   rm -rf "$BUILD_DIR_PATH"
   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
