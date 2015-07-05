#!/bin/bash
#########
#########93 step. Create /etc/fstab file. 
#########
step_93_create_fstab_file ()
{
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/sda1     /            ext4    defaults            1     1
#/dev/<yyy>     swap         swap     pri=1               0     0

# End /etc/fstab
EOF
}
