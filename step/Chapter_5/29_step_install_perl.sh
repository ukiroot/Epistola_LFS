#!/bin/bash
step_29_install_perl ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="perl-5.20.2"
   local SRC_VER="5.20.2"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.bz2
   local SRC_FILE_SHA1="63126c683b4c79c35008a47d56f7beae876c569f"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"
   local PATCH_1="perl-5.20.2-gcc5_fixes-1.patch"
   local PATCH_1_SHA1="242c793e0ef18aad4de0cedeb24d3f8fa96b1bea"
   local PATCH_1_WITH_PATH="$LFS"/sources/"$PATCH_1"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"
   get_check_extract_src \
      "$PATCH_1" \
      "$PATCH_1_SHA1"

   pushd "$SRC_DIR_PATH"
   patch -Np1 -i "$PATCH_1_WITH_PATH"
   sh Configure \
      -des \
      -Dprefix=/tools \
      -Dlibs=-lm
   make -j"$STREAM"
   cp -v perl cpan/podlators/pod2man /tools/bin
   mkdir -pv /tools/lib/perl5/"$SRC_VER"
   cp -Rv lib/* /tools/lib/perl5/"$SRC_VER"
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
