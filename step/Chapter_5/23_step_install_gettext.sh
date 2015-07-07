#!/bin/bash
step_23_install_gettext ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="gettext-0.19.4"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="16c90342f3a59c7df364ebb3209a48be42b7ffd9"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"/gettext-tools

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   EMACS="no" "$SRC_DIR_PATH"/configure --prefix=/tools --disable-shared
   make -C gnulib-lib
   make -C intl pluralx.c
   make -C src msgfmt
   make -C src msgmerge
   make -C src xgettext
   cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
