#!/bin/bash
step_1_prepare_parent_system ()
{
   logger "Start: $FUNCNAME"
   local PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#   apt-get update
#   apt-get install -y ca-certificates bison bzip2 gcc make texinfo g++ gawk libclass-std-perl patch
   rm /bin/sh
   ln -s /bin/bash /bin/sh
   logger "End: $FUNCNAME"
}
