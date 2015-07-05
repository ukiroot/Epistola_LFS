#!/bin/bash
#########
#########95 step. Grub config. 
#########
#8.4. Using GRUB to Set Up the Boot Process
step_95_grub_config ()
{

grub-install /dev/$DISK_LFS --modules="biosdisk part_msdos normal"

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,1)

menuentry "GNU/Linux, Linux 4.0.1-epistola" {
        linux   /boot/vmlinuz-4.0.1-epistola root=/dev/sda1 ro net.ifnames=0
}
EOF
}
