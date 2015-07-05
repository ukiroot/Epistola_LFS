#!/bin/bash
#########
#########Third step. Download and check source for 'lfs'.
#########
#3.1. Introduction
step_3_mkdir_for_source ()
{
echo 'step_3_mkdir_for_source' >> /tmp/log

local PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

}
