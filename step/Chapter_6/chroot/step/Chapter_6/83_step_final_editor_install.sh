#!/bin/bash
#########
#########83 step. Final Vim install. 
#########
#6.69. Vim-7.4
step_83_final_editor_install ()
{
if [ "$1" == "vim" ];then
cd /sources
tar xjf vim-7.4.tar.bz2
cd vim74
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make -j$STREAM
if [ "$1" == "test" ] ; then
	make -j1 test
fi
make install

ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done
ln -sv ../vim/vim74/doc /usr/share/doc/vim-7.4
cd ..
rm -rf vim74

elif [ "$1" == "nano" ];then

NANO="nano-2.3.99pre1"
NANO_SRC_FILE="$NANO.tar.gz"

if [ ! -f /sources/$NANO_SRC_FILE ]; then
   wget -O /sources/$NANO_SRC_FILE $REPOSITORY/$NANO_SRC_FILE
fi

cd /sources
tar xzf $NANO_SRC_FILE
cd $NANO
./configure --prefix=/usr
make
make install
cd ..
rm -rf $NANO
fi
}