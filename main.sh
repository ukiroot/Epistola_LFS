#!/bin/bash
#mount -t tmpfs -o size=7G tmpfs /mnt/tmpfs
#time bash main.sh sdb no http://lfs.clineos.ru
#time bash main.sh sdb http://lfs.clineos.ru/stage1.tar.gz http://lfs.clineos.ru
#scp root@192.168.1.24:/var/www/clineOS/public_html/cline-os/777_LFS/LFS_7_systemd/Debian_lfs.tar.gz ./
#Erradata
#77 four sed

set -o xtrace
set -o verbose
set -o errexit
umask 022

modprobe nbd max_part=15

#export STREAM=1
export STREAM=`cat /proc/cpuinfo | grep 'processor' | wc -l | (read core; let core=$core-1; echo $core)`
export DIR_MAIN=$(dirname `readlink -e "$0"`)
export LFS=/mnt/lfs
export LC_ALL=POSIX
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=/tools/bin:/bin:/usr/bin:/usr/sbin/
export REPOSITORY=$3
export DISK_LFS=$1

DEV_DISK_NAME=`echo $1 | grep -o "..."`

if [ "$DEV_DISK_NAME" == "nbd" ]; then
   export DISK_LFS_PARTITION_1="$DISK_LFS"p1

   rm -rf /root/lfs.img
   qemu-img create /root/lfs.img 4G
   qemu-nbd  -c /dev/$DISK_LFS /root/lfs.img
else
   export DISK_LFS_PARTITION_1="$DISK_LFS"1
fi



#Chapter_5_func
. step/Chapter_5/1_step_prepare_parent_system.sh
. step/Chapter_5/2_step_prepare_disk.sh
. step/Chapter_5/3_step_mkdir_for_source.sh
. step/Chapter_5/4_creating_tools_directory.sh
. step/Chapter_5/6_step_install_binutils.sh
. step/Chapter_5/7_step_install_gcc.sh
. step/Chapter_5/8_step_install_linux_api_headers.sh
. step/Chapter_5/9_step_install_glibc.sh
. step/Chapter_5/10_step_install_libstdc.sh
. step/Chapter_5/11_step_install_binutils_pass_two.sh
. step/Chapter_5/12_step_install_gcc_pass_two.sh
. step/Chapter_5/13_step_install_tcl.sh
. step/Chapter_5/14_step_install_expect.sh
. step/Chapter_5/15_step_install_dejagnu.sh
. step/Chapter_5/16_step_install_check.sh
. step/Chapter_5/17_step_install_ncurses.sh
. step/Chapter_5/18_step_install_bash.sh
. step/Chapter_5/19_step_install_bzip.sh
. step/Chapter_5/20_step_install_coreutils.sh
. step/Chapter_5/21_step_install_diffutils.sh
. step/Chapter_5/22_step_install_file.sh
. step/Chapter_5/23_step_install_findutils.sh
. step/Chapter_5/24_step_install_gawk.sh
. step/Chapter_5/25_step_install_gettext.sh
. step/Chapter_5/26_step_install_grep.sh
. step/Chapter_5/27_step_install_gzip.sh
. step/Chapter_5/28_step_install_mfour.sh
. step/Chapter_5/29_step_install_make.sh
. step/Chapter_5/30_step_install_patch.sh
. step/Chapter_5/31_step_install_perl.sh
. step/Chapter_5/32_step_install_sed.sh
. step/Chapter_5/33_step_install_tar.sh
. step/Chapter_5/34_step_install_texinfo.sh
. step/Chapter_5/35_step_install_util_linux.sh
. step/Chapter_5/37_step_install_xz.sh
. step/Chapter_5/38_step_install_wget.sh


#Chapter_6_func
. step/Chapter_6/17_step_preparing_virtual_kernel_file_systems.sh
. step/Chapter_6/18_step_run_second_scipt_in_chroot.sh

#Chapter_5_do
step_1_prepare_parent_system
step_2_prepare_disk
step_3_mkdir_for_source
if [ "`echo $2 | grep -o http:`" == "http:" ] ; then
wget -O $LFS/sources/stage1.tar.gz $2
tar zxf $LFS/sources/stage1.tar.gz -C $LFS
elif [  "$2" == "no" ]; then
step_4_creating_tools_directory
step_6_install_binutils
step_7_install_gcc
step_8_install_linux_api_headers
step_9_install_glibc
step_10_install_libstdc
step_11_install_binutils_pass_two
step_12_install_gcc_pass_two
step_13_install_tcl "notest"
step_14_install_expect "notest"
step_15_install_dejagnu "notest"
step_16_install_check "notest"
step_17_install_ncurses "notest"
step_18_install_bash "notest"
step_19_install_bzip "notest"
step_20_install_coreutils "notest"
step_21_install_diffutils "notest"
step_22_install_file "notest"
step_23_install_findutils "notest"
step_24_install_gawk "notest"
step_25_install_gettext "notest"
step_26_install_grep "notest"
step_27_install_gzip "notest"
step_28_install_mfour "notest"
step_29_install_make "notest"
step_30_install_patch "notest"
step_31_install_perl "notest"
step_32_install_sed "notest"
step_33_install_tar "notest"
step_34_install_texinfo "notest"
step_35_install_util_linux "notest"
step_37_install_xz "notest"
step_38_install_wget "notest"
set +o errexit
/tools/bin/find /tools/ -type f -exec /tools/bin/strip --strip-debug '{}' ';'
cd $LFS
tar czf stage1.tar.gz ./tools
cd $DIR_MAIN
set -o errexit
else
tar zxf $LFS/stage1.tar.gz -C $LFS
fi
#Chapter_6_do
step_17_preparing_virtual_kernel_file_systems
#Copy_second_main_chroot_script
mkdir -pv $LFS/root_tmp/
cp -rv $DIR_MAIN/step/Chapter_6/chroot/* $LFS/root_tmp/
step_18_run_second_scipt_in_chroot $DISK_LFS $REPOSITORY
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
cd /

umount -v $LFS/dev/pts
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys


LFSF="/root/`date +%F`"
rm -rf $LFSF
qemu-img create $LFSF 1G
qemu-nbd -c /dev/nbd14 $LFSF
fdisk /dev/nbd14 << "EOF"
n
p
1


a
w
EOF


mkfs.ext4 /dev/nbd14p1

if [ ! -f  /media/release ]; then
  mkdir -p /media/release
fi


mount /dev/nbd14p1 /media/release


#Copy Epistola in images
set +o errexit
mv $LFS/* /media/release/
set -o errexit
umount -v $LFS

mount -v --bind /dev /media/release/dev
mount -vt devpts devpts /media/release/dev/pts
mount -vt proc proc /media/release/proc
mount -vt sysfs sysfs /media/release/sys
mount -vt tmpfs tmpfs /media/release/run


/usr/sbin/chroot  /media/release /bin/bash -c '/sbin/grub-install -v /dev/nbd14 --modules="biosdisk part_msdos normal"'

umount -v /media/release/dev/pts
umount -v /media/release/dev
umount -v /media/release/proc
umount -v /media/release/sys
umount -v /media/release/run
umount -v /media/release


qemu-nbd -d /dev/nbd14

if [ "$DEV_DISK_NAME" == "nbd" ]; then
   qemu-nbd -d /dev/$DISK_LFS
fi

rm -rf $LFS
rm -rf /tools
sync
sleep 1
rmmod nbd
