#!/bin/bash
step_5_install_gcc ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="gcc-5.1.0"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.bz2
   local SRC_FILE_SHA1="b6c947b09adf780fe02065d0c48bfd7b4bdddfa3"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"
   local BUILD_DIR_PATH="$LFS"/sources/gcc-build
   local MPFR="mpfr-3.1.2"
   local MPFR_SRC_FILE="$MPFR".tar.xz
   local MPFR_SHA1="03e593cc6e26639ef5e60be1af8dc527209e5172"
   local GMP="gmp-6.0.0"
   local GMP_SRC_FILE="$GMP"a.tar.xz
   local GMP_SHA1="1aaf78358ab9e34aeb61f3ae08174ee9118ece98"
   local MPC="mpc-1.0.3"
   local MPC_SRC_FILE="$MPC".tar.gz
   local MPC_SHA1="b8be66396c726fdc36ebb0f692ed8a8cca3bcc66"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   get_check_extract_src \
      "$MPFR_SRC_FILE" \
      "$MPFR_SHA1"
   mv -v "$LFS"/sources/"$MPFR" "$SRC_DIR_PATH"/mpfr

   get_check_extract_src \
      "$GMP_SRC_FILE" \
      "$GMP_SHA1"
   mv -v "$LFS"/sources/"$GMP" "$SRC_DIR_PATH"/gmp

   get_check_extract_src \
      "$MPC_SRC_FILE" \
      "$MPC_SHA1"
   mv -v "$LFS"/sources/"$MPC" "$SRC_DIR_PATH"/mpc

   pushd "$SRC_DIR_PATH"
   for file in \
      $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
   do
      cp -uv $file{,.orig}
      sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
         -e 's@/usr@/tools@g' $file.orig > $file
      echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
      touch $file.orig
   done

   mkdir -v "$BUILD_DIR_PATH"
   pushd "$BUILD_DIR_PATH"
   "$SRC_DIR_PATH"/configure                         \
      --target="$LFS_TGT"                            \
      --prefix=/tools                                \
      --with-glibc-version=2.11                      \
      --with-sysroot="$LFS"                          \
      --with-newlib                                  \
      --without-headers                              \
      --with-local-prefix=/tools                     \
      --with-native-system-header-dir=/tools/include \
      --disable-nls                                  \
      --disable-shared                               \
      --disable-multilib                             \
      --disable-decimal-float                        \
      --disable-threads                              \
      --disable-libatomic                            \
      --disable-libgomp                              \
      --disable-libitm                               \
      --disable-libquadmath                          \
      --disable-libsanitizer                         \
      --disable-libssp                               \
      --disable-libvtv                               \
      --disable-libcilkrts                           \
      --disable-libstdc++-v3                         \
      --enable-languages=c,c++
   make -j"$STREAM"
   make install
   make clean
   popd
   popd

   rm -rf "$BUILD_DIR_PATH"
   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
