#!/bin/bash
#########
#########91 step. Creating shells. 
#########
#7.9. Creating the /etc/shells File
step_91_creating_shells_file ()
{
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF
}