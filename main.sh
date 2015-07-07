#!/bin/bash

set -o xtrace
set -o verbose
set -o errexit
umask 022

STREAM=`cat /proc/cpuinfo | grep 'processor' | wc -l | (read core; let core=$core-1; echo $core)`
DIR_MAIN=$(dirname `readlink -e "$0"`)
LFS="/mnt/lfs"
LC_ALL=POSIX
LFS_TGT="$(uname -m)-lfs-linux-gnu"
PATH="/tools/bin:/bin:/usr/bin:/usr/sbin/:/sbin"
REPOSITORY="$3"
DISK_LFS="$1"
TEST="$4"
DEV_DISK_NAME=`echo $1 | grep -o "..."`

if [ "$DEV_DISK_NAME" == "nbd" ]; then
   DISK_LFS_PARTITION_1="$DISK_LFS"p1

   modprobe nbd max_part=15
   rm -rf /root/lfs.img
   qemu-img create /root/lfs.img 4G
   qemu-nbd -c /dev/"$DISK_LFS" /root/lfs.img
else
   DISK_LFS_PARTITION_1="$DISK_LFS"1
fi

. step/func_lib.sh
#Chapter_5_func
. step/Chapter_5/1_step_prepare_parent_system.sh
. step/Chapter_5/2_step_prepare_disk.sh
. step/Chapter_5/3_step_mkdir_for_source_and_tools_directory.sh
. step/Chapter_5/4_step_install_binutils.sh
. step/Chapter_5/5_step_install_gcc.sh
. step/Chapter_5/6_step_install_linux_api_headers.sh
. step/Chapter_5/7_step_install_glibc.sh
. step/Chapter_5/8_step_install_libstdc.sh
. step/Chapter_5/9_step_install_binutils_pass_two.sh
. step/Chapter_5/10_step_install_gcc_pass_two.sh
. step/Chapter_5/11_step_install_tcl.sh
. step/Chapter_5/12_step_install_expect.sh
. step/Chapter_5/13_step_install_dejagnu.sh
. step/Chapter_5/14_step_install_check.sh
. step/Chapter_5/15_step_install_ncurses.sh
. step/Chapter_5/16_step_install_bash.sh
. step/Chapter_5/17_step_install_bzip.sh
. step/Chapter_5/18_step_install_coreutils.sh
. step/Chapter_5/19_step_install_diffutils.sh
. step/Chapter_5/20_step_install_file.sh
. step/Chapter_5/21_step_install_findutils.sh
. step/Chapter_5/22_step_install_gawk.sh
. step/Chapter_5/23_step_install_gettext.sh
. step/Chapter_5/24_step_install_grep.sh
. step/Chapter_5/25_step_install_gzip.sh
. step/Chapter_5/26_step_install_mfour.sh
. step/Chapter_5/27_step_install_make.sh
. step/Chapter_5/28_step_install_patch.sh
. step/Chapter_5/29_step_install_perl.sh
. step/Chapter_5/30_step_install_sed.sh
. step/Chapter_5/31_step_install_tar.sh
. step/Chapter_5/32_step_install_texinfo.sh
. step/Chapter_5/33_step_install_util_linux.sh
. step/Chapter_5/34_step_install_xz.sh
. step/Chapter_5/35_step_install_cmake.sh
. step/Chapter_5/36_step_install_wget.sh

#Chapter_6_func
#. step/Chapter_6/*

#Chapter_5_do
step_1_prepare_parent_system
step_2_prepare_disk
step_3_mkdir_for_source_and_tools_directory
if [ "`echo $2 | grep -o http:`" == "http:" ] ; then
   wget -O "$LFS"/sources/stage1.tar.gz "$2"
   tar zxf "$LFS"/sources/stage1.tar.gz -C "$LFS"
elif [  "$2" == "no" ]; then
   step_4_install_binutils
   step_5_install_gcc
   step_6_install_linux_api_headers
   step_7_install_glibc
   step_8_install_libstdc
   step_9_install_binutils_pass_two
   step_10_install_gcc_pass_two
   step_11_install_tcl "$TEST"
   step_12_install_expect "$TEST"
   step_13_install_dejagnu "$TEST"
   step_14_install_check "$TEST"
   step_15_install_ncurses "$TEST"
   step_16_install_bash "$TEST"
   step_17_install_bzip "$TEST"
   step_18_install_coreutils "$TEST"
   step_19_install_diffutils "$TEST"
   step_20_install_file "$TEST"
   step_21_install_findutils "$TEST"
   step_22_install_gawk "$TEST"
   step_23_install_gettext "$TEST"
   step_24_install_grep "$TEST"
   step_25_install_gzip "$TEST"
   step_26_install_mfour "$TEST"
   step_27_install_make "$TEST"
   step_28_install_patch "$TEST"
   step_29_install_perl "$TEST"
   step_30_install_sed "$TEST"
   step_31_install_tar "$TEST"
   step_32_install_texinfo "$TEST"
   step_33_install_util_linux "$TEST"
   step_34_install_xz "$TEST"
   step_35_install_cmake "$TEST"
   step_36_install_wget "$TEST"

   set +o errexit
   /tools/bin/find /tools/ -type f -exec /tools/bin/strip --strip-debug '{}' ';'
   cd "$LFS"
   tar czf stage1.tar.gz ./tools
   cd "$DIR_MAIN"
   set -o errexit
else
   tar zxf "$LFS"/stage1.tar.gz -C $LFS
fi

if false; then
#Chapter_6_do
step_17_preparing_virtual_kernel_file_systems
#Copy_second_main_chroot_script
mkdir -pv "$LFS"/root_tmp/
cp -rv "$DIR_MAIN"/step/Chapter_6/chroot/* "$LFS"/root_tmp/
cat > "$LFS"/root_tmp/main_chroot.sh << "EOF"
#!/tools/bin/bash

set -o xtrace
set -o verbose
set -o errexit

export DIR_MAIN=$(dirname `readlink -e "$0"`)
export STREAM=`cat /proc/cpuinfo | grep 'processor' | wc -l | (read core; let core=$core-1; echo $core)`
export HOME=/root
export TERM="$TERM"
export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin
export DISK_LFS=$1
export REPOSITORY=$2

. $DIR_MAIN/step/Chapter_6/*
. $DIR_MAIN/step/Chapter_10/*


step_19_creating_directories_in_chroot
step_20_creating_essential_files_and_symlinks

echo "nameserver 8.8.8.8" > /etc/resolv.conf

step_21_kernel_api_headers
step_23_glibc_install_and_config
step_24_adjusting_the_toolchain
step_25_final_zlib_install
step_26_final_file_install
step_27_final_binutils_install
#need php gmp.h
step_28_final_gmp_install
#################
#Because gcc not compile
rm -f /usr/lib/libgcc_s.so.1
rm -f /usr/lib/libstdc++.so.6
rm -f /usr/lib/libgcc_s.so
rm -f /usr/lib/libstdc++.so
rm -f /usr/lib/libstdc++.so.6.0.21
 
cp /tools/lib/libgcc_s.so.1 /usr/lib/
cp /tools/lib/libstdc++.so.6 /usr/lib/
cp /tools/lib/libgcc_s.so /usr/lib/
cp /tools/lib/libstdc++.so /usr/lib/
cp /tools/lib/libstdc++.so.6.0.21 /usr/lib/
##########################
step_32_final_bzip2_install
step_33_final_pkg_config_install
step_34_ncurses_install
#Need libcap
step_35_final_attr_install
step_36_final_acl_install
step_37_final_libcap_install
#Need postfix
step_38_final_sed_install
step_39_final_shadow_install
step_40_final_psmisc_install
step_41_final_procps_ng_install
#!!!!!!
step_79_final_util_linux_install
#!!!!!!
step_42_final_e2fsprogs_install
step_43_final_coreutils_install
step_44_final_iana_etc_install
step_46_final_flex_install
step_47_final_bison_install
step_48_final_grep_install
step_49_final_readline_install
step_50_final_bash_install
step_51_final_bc_install
step_52_final_libtool_install
step_53_final_gdbm_install
step_54_final_expat_install
step_55_filal_inetutils_install
step_56_final_perl_install
step_57_finall_xml_parser_install
step_60_final_diffutils_install
step_61_final_gawk_install
step_62_final_findutils_install
step_63_final_gettext_install
step_64_final_inttool_install
#Need systemd
step_65_final_gperf_install
step_67_final_xz_install
step_68_final_grub2_install
step_69_final_less_install
step_70_final_gzip_install
step_71_final_iproute_install
step_72_final_kdb_install
step_73_final_kmod_install
step_74_final_libpipeline_install
step_77_final_systemd_install
step_78_final_d_bus_install
#
#
#step_80_final_man_db_install
step_81_final_tar_install
step_83_final_editor_install nano


#Chapter_10
step_101_install_libressl
step_102_install_ca
step_103_install_curl
step_104_install_mysql
step_105_install_db
step_106_install_postfix
step_107_install_dovecot
step_108_install_openssh
step_110_install_nginx
step_111_install_php

step_112_install_roundcube

#Chapter_7
step_86_final_network_config
step_87_final_system_clock_config
step_88_final_linux_console_config
step_89_final_system_locale_config
step_90_creating_inputrc
step_91_creating_shells_file
step_92_final_systemd_usage_and_config

#Chapter_8
step_93_create_fstab_file
step_94_kernel_install
step_95_grub_config

. $DIR_MAIN/step/Chapter_10/rc.local.first.boot.sh

#Chapter_9
step_97_the_end

EOF

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


/usr/sbin/chroot /media/release /bin/bash -c '/sbin/grub-install -v /dev/nbd14 --modules="biosdisk part_msdos normal"'

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

rm -rf "$LFS"
rm -rf /tools
sync
sleep 1
rmmod nbd
fi
