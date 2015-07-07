#!/bin/bash
step_7_install_glibc ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="glibc-2.21"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="1157be3fe63baa81b7ba104a103337775a6ed06f"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"
   local BUILD_DIR_PATH="$LFS"/sources/glibc-build

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   sed -e '/ia32/s/^/1:/' \
      -e '/SSE2/s/^1://' \
      -i  "$SRC_DIR_PATH"/sysdeps/i386/i686/multiarch/mempcpy_chk.S
   mkdir -v "$BUILD_DIR_PATH"
   pushd "$BUILD_DIR_PATH"
   "$SRC_DIR_PATH"/configure                        \
      --prefix=/tools                               \
      --host="$LFS_TGT"                             \
      --build=$(../glibc-2.21/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --enable-obsolete-rpc                         \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes
   make -j"$STREAM"
   make install
   popd

   rm -rf "$BUILD_DIR_PATH"
   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
