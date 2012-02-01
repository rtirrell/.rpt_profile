#!/bin/bash
cd
wget https://github.com/rtirrell/.rpt_profile/tarball/master

tar -xzf master
rm -fr master .rpt_profile
mv rtirrell* .rpt_profile

for fn in bashrc inputrc screenrc pylintrc vimrc.before vimrc.after; do 
    if [[ -f ~/.$fn ]]; then
        echo "File $fn already exists."
        if [[ $f == bashrc ]]; then
            if [[ $(grep .rpt_profile ~/.bashrc | wc -l) == 0 ]]; then
                echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
            fi
        elif [[ -f ~/.rpt_profile/etc/$fn ]]; then
            echo "Copying $f..."
            ln -sf ~/.rpt_profile/etc/$fn ~/.$fn
        fi
    fi
done


source ~/.bashrc
