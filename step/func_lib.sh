#!/bin/bash
########################################################################

get_src () {
   local SRC_FILE_FULL_NAME="$1"
   if [ ! -f "$LFS"/sources/"$SRC_FILE_FULL_NAME" ]; then
      wget -O\
         "$LFS"/sources/"$SRC_FILE_FULL_NAME"\
         "$REPOSITORY"/"$SRC_FILE_FULL_NAME"
   fi
}

########################################################################

check_src () {
   local SRC_FILE_FULL_NAME="$LFS"/sources/"$1"
   local SRC_FILE_SHA1="$2"
   local SHA1=`sha1sum $SRC_FILE_FULL_NAME | awk '{print $1}'`
   if [ "$SHA1" != "$SRC_FILE_SHA1" ]; then
      echo "Error: broken file $SRC_FILE_FULL_NAME"
   fi
}

########################################################################

extract_src () {
   local SRC_FILE_FULL_NAME="$LFS"/sources/"$1"
   pushd "$LFS"/sources
   case $1 in
      *.tar.bz2)   tar xvjf "$SRC_FILE_FULL_NAME"    ;;
      *.tar.gz)    tar xvzf "$SRC_FILE_FULL_NAME"    ;;
      *.tar.xz)    tar xvJf "$SRC_FILE_FULL_NAME"    ;;
      *.bz2)       bunzip2 "$SRC_FILE_FULL_NAME"     ;;
      *.rar)       unrar x "$SRC_FILE_FULL_NAME"     ;;
      *.gz)        gunzip "$SRC_FILE_FULL_NAME"      ;;
      *.tar)       tar xvf "$SRC_FILE_FULL_NAME"     ;;
      *.tbz2)      tar xvjf "$SRC_FILE_FULL_NAME"    ;;
      *.tgz)       tar xvzf "$SRC_FILE_FULL_NAME"    ;;
      *.zip)       unzip "$SRC_FILE_FULL_NAME"       ;;
      *.Z)         uncompress "$SRC_FILE_FULL_NAME"  ;;
      *.7z)        7z x "$SRC_FILE_FULL_NAME"        ;;
      *.xz)        unxz "$SRC_FILE_FULL_NAME"        ;;
      *.exe)       cabextract "$SRC_FILE_FULL_NAME"  ;;
      *.patch)     true                              ;;
      *)           echo "\`$1': Unsupport tar file"  ;;
   esac
   popd
}

########################################################################

get_check_extract_src () {
   local SRC_FILE_FULL_NAME="$1"
   local SRC_FILE_SHA1="$2"

   get_src "$SRC_FILE_FULL_NAME"
   check_src "$SRC_FILE_FULL_NAME" "$SRC_FILE_SHA1"
   extract_src "$SRC_FILE_FULL_NAME"
}

########################################################################
