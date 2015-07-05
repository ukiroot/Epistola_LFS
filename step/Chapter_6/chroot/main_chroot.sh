#!/tools/bin/bash
#ls -1 | while read file;do grep "^step" $file | grep -o ".*\ " ; done | while read lol ; do echo 'echo '\"$lol\"' >> /root_tmp/log' ; echo $lol; done

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

rm -rf /root_tmp/log

. $DIR_MAIN/step/Chapter_6/19_step_creating_directories_in_chroot.sh
. $DIR_MAIN/step/Chapter_6/20_step_creating_essential_files_and_symlinks.sh
. $DIR_MAIN/step/Chapter_6/21_step_kernel_api_headers.sh
. $DIR_MAIN/step/Chapter_6/22_step_man_pages_install.sh
. $DIR_MAIN/step/Chapter_6/23_step_glibc_install_and_config.sh
. $DIR_MAIN/step/Chapter_6/24_adjusting_the_toolchain.sh
. $DIR_MAIN/step/Chapter_6/25_step_final_zlib_install.sh
. $DIR_MAIN/step/Chapter_6/26_step_final_file_install.sh
. $DIR_MAIN/step/Chapter_6/27_step_final_binutils_install.sh
. $DIR_MAIN/step/Chapter_6/28_step_final_gmp_install.sh
. $DIR_MAIN/step/Chapter_6/29_step_finall_mpfr_install.sh
. $DIR_MAIN/step/Chapter_6/30_step_final_mpc_install.sh
. $DIR_MAIN/step/Chapter_6/31_step_final_gcc_install.sh
. $DIR_MAIN/step/Chapter_6/32_step_final_bzip2_install.sh
. $DIR_MAIN/step/Chapter_6/33_step_final_pkg_config_install.sh
. $DIR_MAIN/step/Chapter_6/34_step_ncurses_install.sh
. $DIR_MAIN/step/Chapter_6/35_step_final_attr_install.sh
. $DIR_MAIN/step/Chapter_6/36_step_final_acl_install.sh
. $DIR_MAIN/step/Chapter_6/37_step_final_libcap_install.sh
. $DIR_MAIN/step/Chapter_6/38_step_final_sed_install.sh
. $DIR_MAIN/step/Chapter_6/39_step_final_shadow_install.sh
. $DIR_MAIN/step/Chapter_6/40_step_final_psmisc_install.sh
. $DIR_MAIN/step/Chapter_6/41_step_final_procps_ng_install.sh
. $DIR_MAIN/step/Chapter_6/42_step_final_e2fsprogs_install.sh
. $DIR_MAIN/step/Chapter_6/43_step_final_coreutils_install.sh
. $DIR_MAIN/step/Chapter_6/44_step_final_iana_etc_install.sh
. $DIR_MAIN/step/Chapter_6/45_step_final_m4_install.sh
. $DIR_MAIN/step/Chapter_6/46_step_final_flex_install.sh
. $DIR_MAIN/step/Chapter_6/47_step_final_bison_install.sh
. $DIR_MAIN/step/Chapter_6/48_step_final_grep_install.sh
. $DIR_MAIN/step/Chapter_6/49_step_final_readline_install.sh
. $DIR_MAIN/step/Chapter_6/50_step_final_bash_install.sh
. $DIR_MAIN/step/Chapter_6/51_step_final_bc_install.sh
. $DIR_MAIN/step/Chapter_6/52_step_final_libtool_install.sh
. $DIR_MAIN/step/Chapter_6/53_step_final_gdbm_install.sh
. $DIR_MAIN/step/Chapter_6/54_step_final_expat_install.sh
. $DIR_MAIN/step/Chapter_6/55_step_filal_inetutils_install.sh
. $DIR_MAIN/step/Chapter_6/56_step_final_perl_install.sh
. $DIR_MAIN/step/Chapter_6/57_step_finall_xml_parser_install.sh
. $DIR_MAIN/step/Chapter_6/58_step_final_autoconf_install.sh
. $DIR_MAIN/step/Chapter_6/59_step_final_automake_install.sh
. $DIR_MAIN/step/Chapter_6/60_step_final_diffutils_install.sh
. $DIR_MAIN/step/Chapter_6/61_step_final_gawk_install.sh
. $DIR_MAIN/step/Chapter_6/62_step_final_findutils_install.sh
. $DIR_MAIN/step/Chapter_6/63_step_final_gettext_install.sh
. $DIR_MAIN/step/Chapter_6/64_step_final_inttool_install.sh
. $DIR_MAIN/step/Chapter_6/65_step_final_gperf_install.sh
. $DIR_MAIN/step/Chapter_6/66_step_final_groff_install.sh
. $DIR_MAIN/step/Chapter_6/67_step_final_xz_install.sh
. $DIR_MAIN/step/Chapter_6/68_step_final_grub2_install.sh
. $DIR_MAIN/step/Chapter_6/69_step_final_less_install.sh
. $DIR_MAIN/step/Chapter_6/70_step_final_gzip_install.sh
. $DIR_MAIN/step/Chapter_6/71_step_final_iproute_install.sh
. $DIR_MAIN/step/Chapter_6/72_step_final_kdb_install.sh
. $DIR_MAIN/step/Chapter_6/73_step_final_kmod_install.sh
. $DIR_MAIN/step/Chapter_6/74_step_final_libpipeline_install.sh
#. $DIR_MAIN/step/Chapter_6/75_step_final_make_install.sh
#. $DIR_MAIN/step/Chapter_6/76_step_final_patch_install.sh
. $DIR_MAIN/step/Chapter_6/77_step_final_systemd_install.sh
. $DIR_MAIN/step/Chapter_6/78_step_final_d_bus_install.sh
. $DIR_MAIN/step/Chapter_6/79_step_final_util_linux_install.sh
. $DIR_MAIN/step/Chapter_6/80_step_final_man_db_install.sh
. $DIR_MAIN/step/Chapter_6/81_step_final_tar_install.sh
. $DIR_MAIN/step/Chapter_6/82_step_final_text_info_install.sh
. $DIR_MAIN/step/Chapter_6/83_step_final_editor_install.sh

. $DIR_MAIN/step/Chapter_7/86_step_final_network_config.sh
. $DIR_MAIN/step/Chapter_7/87_step_final_system_clock_config.sh
. $DIR_MAIN/step/Chapter_7/88_step_final_linux_console_config.sh
. $DIR_MAIN/step/Chapter_7/89_step_final_system_locale_config.sh
. $DIR_MAIN/step/Chapter_7/90_step_creating_inputrc.sh
. $DIR_MAIN/step/Chapter_7/91_step_creating_shells_file.sh
. $DIR_MAIN/step/Chapter_7/92_step_final_systemd_usage_and_config.sh

. $DIR_MAIN/step/Chapter_8/93_step_create_fstab_file.sh
. $DIR_MAIN/step/Chapter_8/94_step_kernel_install.sh
. $DIR_MAIN/step/Chapter_8/95_step_grub_config.sh

. $DIR_MAIN/step/Chapter_9/97_step_the_end.sh

. $DIR_MAIN/step/Chapter_10/101_step_install_libressl.sh
. $DIR_MAIN/step/Chapter_10/102_step_install_ca.sh
. $DIR_MAIN/step/Chapter_10/103_step_install_curl.sh
. $DIR_MAIN/step/Chapter_10/104_step_install_mysql.sh
. $DIR_MAIN/step/Chapter_10/105_step_install_db.sh
. $DIR_MAIN/step/Chapter_10/106_step_install_postfix.sh
. $DIR_MAIN/step/Chapter_10/107_step_install_dovecot.sh
. $DIR_MAIN/step/Chapter_10/108_step_install_openssh.sh
. $DIR_MAIN/step/Chapter_10/109_step_install_nginx.sh
. $DIR_MAIN/step/Chapter_10/111_step_install_php.sh
. $DIR_MAIN/step/Chapter_10/112_step_install_roundcube.sh


echo "step_19_creating_directories_in_chroot" >> /root_tmp/log
step_19_creating_directories_in_chroot
echo "step_20_creating_essential_files_and_symlinks" >> /root_tmp/log
step_20_creating_essential_files_and_symlinks

echo "nameserver 8.8.8.8" > /etc/resolv.conf


echo "step_21_kernel_api_headers" >> /root_tmp/log
step_21_kernel_api_headers
#echo "step_22_man_pages_install" >> /root_tmp/log
#step_22_man_pages_install
echo "step_23_glibc_install_and_config" >> /root_tmp/log
step_23_glibc_install_and_config
echo "step_24_adjusting_the_toolchain" >> /root_tmp/log
step_24_adjusting_the_toolchain
echo "step_25_final_zlib_install" >> /root_tmp/log
step_25_final_zlib_install
echo "step_26_final_file_install" >> /root_tmp/log
step_26_final_file_install
echo "step_27_final_binutils_install" >> /root_tmp/log
step_27_final_binutils_install
echo "step_28_final_gmp_install" >> /root_tmp/log
#need php gmp.h
step_28_final_gmp_install
#echo "step_29_finall_mpfr_install" >> /root_tmp/log
#step_29_finall_mpfr_install
#echo "step_30_final_mpc_install" >> /root_tmp/log
#step_30_final_mpc_install
#echo "step_31_final_gcc_install" >> /root_tmp/log
#step_31_final_gcc_install
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
echo "step_32_final_bzip2_install" >> /root_tmp/log
step_32_final_bzip2_install
echo "step_33_final_pkg_config_install" >> /root_tmp/log
step_33_final_pkg_config_install
echo "step_34_ncurses_install" >> /root_tmp/log
step_34_ncurses_install
#Need libcap
echo "step_35_final_attr_install" >> /root_tmp/log
step_35_final_attr_install
echo "step_36_final_acl_install" >> /root_tmp/log
step_36_final_acl_install
echo "step_37_final_libcap_install" >> /root_tmp/log
step_37_final_libcap_install
#Need postfix
echo "step_38_final_sed_install" >> /root_tmp/log
step_38_final_sed_install
echo "step_39_final_shadow_install.sh" >> /root_tmp/log
step_39_final_shadow_install
echo "step_40_final_psmisc_install" >> /root_tmp/log
step_40_final_psmisc_install
echo "step_41_final_procps_ng_install" >> /root_tmp/log
step_41_final_procps_ng_install
#!!!!!!
echo "step_79_final_util_linux_install" >> /root_tmp/log
step_79_final_util_linux_install
#!!!!!!
echo "step_42_final_e2fsprogs_install" >> /root_tmp/log
step_42_final_e2fsprogs_install
echo "step_43_final_coreutils_install" >> /root_tmp/log
step_43_final_coreutils_install
echo "step_44_final_iana_etc_install" >> /root_tmp/log
step_44_final_iana_etc_install
#echo "step_45_final_m4_install" >> /root_tmp/log
#step_45_final_m4_install
echo "step_46_final_flex_install" >> /root_tmp/log
step_46_final_flex_install
echo "step_47_final_bison_install" >> /root_tmp/log
step_47_final_bison_install
echo "step_48_final_grep_install" >> /root_tmp/log
step_48_final_grep_install
echo "step_49_final_readline_install" >> /root_tmp/log
step_49_final_readline_install
echo "step_50_final_bash_install.sh" >> /root_tmp/log
step_50_final_bash_install
echo "step_51_final_bc_install" >> /root_tmp/log
step_51_final_bc_install
echo "step_52_final_libtool_install" >> /root_tmp/log
step_52_final_libtool_install
echo "step_53_final_gdbm_install" >> /root_tmp/log
step_53_final_gdbm_install
echo "step_54_final_expat_install" >> /root_tmp/log
step_54_final_expat_install
echo "step_55_filal_inetutils_install" >> /root_tmp/log
step_55_filal_inetutils_install
echo "step_56_final_perl_install" >> /root_tmp/log
step_56_final_perl_install
echo "step_57_finall_xml_parser_install" >> /root_tmp/log
step_57_finall_xml_parser_install
#echo "step_58_final_autoconf_install" >> /root_tmp/log
#step_58_final_autoconf_install
#echo "step_59_final_automake_install" >> /root_tmp/log
#step_59_final_automake_install
echo "step_60_final_diffutils_install" >> /root_tmp/log
step_60_final_diffutils_install
echo "step_61_final_gawk_install" >> /root_tmp/log
step_61_final_gawk_install
echo "step_62_final_findutils_install" >> /root_tmp/log
step_62_final_findutils_install
echo "step_63_final_gettext_install" >> /root_tmp/log
step_63_final_gettext_install
echo "step_64_final_inttool_install" >> /root_tmp/log
step_64_final_inttool_install
echo "step_65_final_gperf_install" >> /root_tmp/log
#Need systemd
step_65_final_gperf_install
#echo "step_66_final_groff_install" >> /root_tmp/log
#step_66_final_groff_install
echo "step_67_final_xz_install" >> /root_tmp/log
step_67_final_xz_install
echo "step_68_final_grub2_install" >> /root_tmp/log
step_68_final_grub2_install
echo "step_69_final_less_install" >> /root_tmp/log
step_69_final_less_install
echo "step_70_final_gzip_install" >> /root_tmp/log
step_70_final_gzip_install
echo "step_71_final_iproute_install" >> /root_tmp/log
step_71_final_iproute_install
echo "step_72_final_kdb_install" >> /root_tmp/log
step_72_final_kdb_install
echo "step_73_final_kmod_install" >> /root_tmp/log
step_73_final_kmod_install
echo "step_74_final_libpipeline_install" >> /root_tmp/log
step_74_final_libpipeline_install
#echo "step_75_final_make_install" >> /root_tmp/log
#step_75_final_make_install
#echo "step_76_final_patch_install" >> /root_tmp/log
#step_76_final_patch_install
echo "step_77_final_systemd_install" >> /root_tmp/log
step_77_final_systemd_install
echo "step_78_final_d_bus_install" >> /root_tmp/log
step_78_final_d_bus_install
#
#
#echo "step_80_final_man_db_install" >> /root_tmp/log
#step_80_final_man_db_install
echo "step_81_final_tar_install" >> /root_tmp/log
step_81_final_tar_install
#echo "step_82_final_text_info_install" >> /root_tmp/log
#step_82_final_text_info_install
echo "step_83_final_editor_install" >> /root_tmp/log
step_83_final_editor_install nano


#Chapter_10
echo "step_101_install_libressl" >> /root_tmp/log
step_101_install_libressl
echo "step_102_install_ca" >> /root_tmp/log
step_102_install_ca
echo "step_103_install_curl" >> /root_tmp/log
step_103_install_curl
echo "step_104_install_mysql" >> /root_tmp/log
step_104_install_mysql
echo "step_105_install_db" >> /root_tmp/log
step_105_install_db
echo "step_106_install_postfix" >> /root_tmp/log
step_106_install_postfix
echo "step_107_install_dovecot" >> /root_tmp/log
step_107_install_dovecot
echo "step_108_install_openssh" >> /root_tmp/log
step_108_install_openssh
echo "step_110_install_nginx" >> /root_tmp/log
step_110_install_nginx
echo "step_111_install_php" >> /root_tmp/log
step_111_install_php

echo "step_112_install_roundcube" >> /root_tmp/log
step_112_install_roundcube

#export HOME=/root
#export TERM=$TERM
#export PS1='\u:\w\$ '
#export PATH=/bin:/usr/bin:/sbin:/usr/sbin


#Chapter_7
echo "step_86_final_network_config" >> /root_tmp/log
step_86_final_network_config
echo "step_87_final_system_clock_config" >> /root_tmp/log
step_87_final_system_clock_config
echo "step_88_final_linux_console_config" >> /root_tmp/log
step_88_final_linux_console_config
echo "step_89_final_system_locale_config" >> /root_tmp/log
step_89_final_system_locale_config
echo "step_90_creating_inputrc" >> /root_tmp/log
step_90_creating_inputrc
echo "step_91_creating_shells_file" >> /root_tmp/log
step_91_creating_shells_file
echo "step_92_final_systemd_usage_and_config" >> /root_tmp/log
step_92_final_systemd_usage_and_config

#Chapter_8
echo "step_93_create_fstab_file" >> /root_tmp/log
step_93_create_fstab_file
echo "step_94_kernel_install" >> /root_tmp/log
step_94_kernel_install
echo "step_95_grub_config" >> /root_tmp/log
step_95_grub_config

. $DIR_MAIN/step/Chapter_10/rc.local.first.boot.sh

#Chapter_9
echo "step_97_the_end" >> /root_tmp/log
step_97_the_end

