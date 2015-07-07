#!/bin/bash
step_2_prepare_disk()
{
   logger "Start: $FUNCNAME"
   local PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   fdisk /dev/"$DISK_LFS" << EOF

n
p
1


a
w
EOF
   mkfs -v -t ext4 /dev/"$DISK_LFS_PARTITION_1"
   mkdir -pv "$LFS"
   mount -v -t ext4 /dev/"$DISK_LFS_PARTITION_1" "$LFS"
   logger "End: $FUNCNAME"
}
