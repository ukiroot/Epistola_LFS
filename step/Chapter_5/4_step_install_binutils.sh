#!/bin/bash
step_4_install_binutils ()
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
   "$SRC_DIR_PATH"/configure     \
      --prefix=/tools            \
      --with-sysroot="$LFS"      \
      --with-lib-path=/tools/lib \
      --target="$LFS_TGT"        \
      --disable-nls              \
      --disable-werror
   make -j"$STREAM"
   case $(uname -m) in
      x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
   esac
   make install
   make clean
   popd

   rm -rf "$BUILD_DIR_PATH"
   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
