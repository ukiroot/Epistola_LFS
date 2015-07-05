#!/bin/bash
#########
#########92 step. Final Systemd Usage and Config. 
#########
#7.10. Systemd Usage and Configuration
step_92_final_systemd_usage_and_config ()
{
#7.10.2. Disabling Screen Clearing at Boot Time
mkdir -pv /etc/systemd/system/getty@tty1.service.d

cat > /etc/systemd/system/getty@tty1.service.d/noclear.conf << EOF
[Service]
TTYVTDisallocate=no
EOF

#7.10.3. Disabling tmpfs for /tmp
ln -sfv /dev/null /etc/systemd/system/tmp.mount

#7.10.5. Overriding Default Services Behavior
mkdir -pv /etc/systemd/system/foobar.service.d

cat > /etc/systemd/system/foobar.service.d/foobar.conf << EOF
[Service]
Restart=always
RestartSec=30
EOF
}
