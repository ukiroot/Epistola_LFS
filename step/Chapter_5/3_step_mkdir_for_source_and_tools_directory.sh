#!/bin/bash
step_3_mkdir_for_source_and_tools_directory ()
{
   logger "Start: $FUNCNAME"
   mkdir -v "$LFS"/sources
   chmod -v a+wt "$LFS"/sources
   mkdir -v "$LFS"/tools
   ln -sv "$LFS"/tools /
   logger "End: $FUNCNAME"
}
