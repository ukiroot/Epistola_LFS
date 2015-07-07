#!/bin/bash
step_11_install_tcl ()
{
   logger "Start: $FUNCNAME"
   local SRC_DIR="tcl8.6.4"
   local SRC_FILE_FULL_NAME="$SRC_DIR"-src.tar.gz
   local SRC_FILE_SHA1="33c5a083a23cf54f15e25a9e787dc39ef3fa0a2b"
   local SRC_DIR_PATH="$LFS"/sources/"$SRC_DIR"

   get_check_extract_src \
      "$SRC_FILE_FULL_NAME" \
      "$SRC_FILE_SHA1"

   pushd "$SRC_DIR_PATH"/unix/
   "$SRC_DIR_PATH"/unix/configure --prefix=/tools
   make -j"$STREAM"
   if [ "$1" == "test" ] ; then
      TZ=UTC make test
   fi
   make install
   chmod -v u+w /tools/lib/libtcl8.6.so
   make install-private-headers
   ln -sv tclsh8.6 /tools/bin/tclsh
   popd

   rm -rf "$SRC_DIR_PATH"
   logger "End: $FUNCNAME"
}
