#!/bin/bash
#########
#########Fourth step. Creating tools Directory.
#########
#4.2. Creating the $LFS/tools Directory
step_4_creating_tools_directory ()
{
echo 'step_4_creating_tools_directory' >> /tmp/log

mkdir -v $LFS/tools
ln -sv $LFS/tools /
}