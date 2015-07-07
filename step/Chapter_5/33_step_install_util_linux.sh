#!/bin/bash
step_33_install_util_linux ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="util-linux-2.26.2"
   local SRC_FILE_FULL_NAME="$SRC_DIR".tar.xz
   local SRC_FILE_SHA1="ac0b880a12392b2cbbe12239ab7613c25349093d"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"
   "$SRC_DIR_PATH"/configure --prefix=/tools                \
      --without-python               \
      --disable-makeinstall-chown    \
      --without-systemdsystemunitdir \
      PKG_CONFIG=""
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      make install
   fi
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
