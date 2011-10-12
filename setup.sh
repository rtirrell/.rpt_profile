#!/bin/bash
# Also add to bash profile.
if [[ ! -f ~/.bashrc ]]; then
    echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
else 
    if [[ $(grep .rpt_profile ~/.bashrc | wc -l ) -eq 0 ]]; then
        echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
    fi
fi

for fn in inputrc screenrc vimrc pylintrc; do 
    mv ~/.rpt_profile/etc/$fn ~/.$fn
done;


