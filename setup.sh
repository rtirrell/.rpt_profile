#!/bin/bash
cd
wget https://github.com/rtirrell/.rpt_profile/tarball/master
tar -xzf master 

mv -f *.rpt_profile* .rpt_profile

if [ ! -f ~/.bashrc ]; then
    echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
else 
    if [ $(grep .rpt_profile ~/.bashrc | wc -l ) -eq 0 ]; then
        echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
    fi
fi

echo "set editing-mode vi" > ~/.inputrc
echo "set keymap vi" >> ~/.inputrc

echo "source $HOME/.rpt_profile/etc/screenrc" > ~/.screenrc
echo "source ~/.rpt_profile/etc/vimrc" > ~/.vimrc


