#!/bin/bash
cd
wget https://github.com/rtirrell/.rpt_profile/tarball/master

tar -xzf master
rm -fr master 
mv rtirrell* .rpt_profile

for fn in bashrc inputrc screenrc pylintrc vimrc.before vimrc.after; do 
    if [[ -f ~/.$fn ]]; then
        echo "File $fn already exists."
        if [[ $f == bashrc ]]; then
            if [[ $(grep .rpt_profile ~/.bashrc | wc -l) == 0 ]]; then
                echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
            fi
        else
            ln -sf ~/.rpt_profile/etc/$fn ~/.$fn
        fi
    else
        ln -sf ~/.rpt_profile/etc/$fn ~/.$fn
    fi
done


source ~/.bashrc
