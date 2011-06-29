#!/bin/bash
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


