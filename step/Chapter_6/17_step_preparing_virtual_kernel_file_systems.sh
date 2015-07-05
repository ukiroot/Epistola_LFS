#!/bin/bash
#########
#########Seventeenth step. Preparing Virtual Kernel File Systems.
#########
#6.2. Preparing Virtual Kernel File Systems
step_17_preparing_virtual_kernel_file_systems ()
{
echo 'step_17_preparing_virtual_kernel_file_systems' >> /tmp/log
mkdir -pv $LFS/{dev,proc,sys,run}
#6.2.1. Creating Initial Device Nodes
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3
#6.2.2. Mounting and Populating /dev
mount -v --bind /dev $LFS/dev
#6.2.3. Mounting Virtual Kernel File Systems
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
 mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
}