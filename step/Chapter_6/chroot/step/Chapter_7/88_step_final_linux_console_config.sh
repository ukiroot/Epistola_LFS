#!/bin/bash
#########
#########88 step. Final Linux Console Config. 
#########
#7.6. Configuring the Linux Console
step_88_final_linux_console_config ()
{
cat > /etc/vconsole.conf << "EOF"
KEYMAP=ruwin_ct_sh-UTF-8
FONT=cyr-sun16
EOF
}