#!/bin/bash
#########
#########86 step. Final Network Config. 
#########
#7.2. General Network Configuration
step_86_final_network_config ()
{
cat > /etc/systemd/network/10-dhcp-eth0.network << "EOF"
[Match]
Name=eth0

[Network]
DHCP=yes
EOF

cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf


# End /etc/resolv.conf
EOF

#When using systemd-networkd for network configuration, another daemon, systemd-resolved, is responsible for creating the /etc/resolv.conf file. It is, however, placed in a non-standard location which is writable since early boot, so it is necessary to create a symlink to it by running the following command:
ln -sfv /run/systemd/resolve/resolv.conf /etc/resolv.conf

#7.2.3. Configuring the system hostname
echo "epistola" > /etc/hostname

#7.2.4. Customizing the /etc/hosts File
cat > /etc/hosts << "EOF"
# Begin /etc/hosts (network card version)

127.0.0.1 localhost
::1       localhost

# End /etc/hosts (network card version)
EOF
}
