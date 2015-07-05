#!/bin/bash
#########
#########Fifth step. Adding the LFS User. 
#########
step_5_adding_user ()
{
echo 'step_5_adding_user' >> /tmp/log

#4.3. Adding the LFS User
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

passwd lfs << EOF
lfs
lfs
EOF
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources
su - lfs
	
#4.4. Setting Up the Environment
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

source ~/.bash_profile
}