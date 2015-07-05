#!/bin/bash
#########
#########89 step. Final System Locale Config. 
#########
#7.7. Configuring the System Locale
step_89_final_system_locale_config ()
{
LC_ALL=en_US.utf8 locale charmap
LC_ALL=en_US.utf8 locale language
LC_ALL=en_US.utf8 locale charmap
LC_ALL=en_US.utf8 locale int_curr_symbol
LC_ALL=en_US.utf8 locale int_prefix

cat > /etc/locale.conf << "EOF"
LOCALE=en_US.UTF-8
LANG=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
EOF
}