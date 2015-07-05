#!/bin/bash
#########
#########Eighteenth step. Run second scipt in chroot. 
#########
#
step_18_run_second_scipt_in_chroot ()
{
#6.4. Entering the Chroot Environment
echo 'step_18_run_second_scipt_in_chroot' >> /tmp/log
/usr/sbin/chroot "$LFS" /tools/bin/env -i \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='\u:\w\$ '              \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h /root_tmp/main_chroot.sh $1  $2
}
