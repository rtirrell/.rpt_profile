if [ ! -f ~/.bashrc ]; then
    echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
else 
    if [ $(grep .rpt_profile ~/.bashrc | wc -l ) -eq 0 ]; then
        echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
        echo "set -o vi" >> ~/.bashrc
    fi
fi

echo "set editing-mode vi" > ~/.inputrc
echo "set keymap vi" >> ~/.inputrc

echo "source $HOME/.rpt_profile/etc/screenrc" >> ~/.screenrc

if [ ! -f ~/.vimrc ]; then
    echo "source ~/.rpt_profile/etc/vimrc" >> ~/.vimrc
fi

source ~/.bashrc


