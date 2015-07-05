#!/bin/bash
#########
#########87 step. Final System Clock Config. 
#########
#7.5. Configuring the system clock
step_87_final_system_clock_config ()
{
cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
LOCAL
EOF
#Starting with systemd version 216, the systemd-timesyncd daemon is enabled by default. If you want to disable it, issue the following command:
systemctl disable systemd-timesyncd
}