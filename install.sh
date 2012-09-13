#!/usr/bin/env bash
# Put all files in place. Run this on a dev machine.

if [[ ! $(grep rpt_profile $HOME/.bash_profile) ]]; then
    echo "source $HOME/.rpt_profile/etc/bashrc" >> $HOME/.bash_profile
fi

filenames='pylintrc vimrc.before vimrc.after'
for filename in $filenames; do
    ln -sf $HOME/.rpt_profile/etc/$filename $HOME/.$filename
done

source $HOME/.bash_profile


if [[ $(uname) != 'Darwin' ]]; then 
    mkdir -p $HOME/.byobu
    for f in $(find $HOME/.rpt_profile/etc/byobu -type f); do
        cp $f $HOME/.byobu
    done

    if [[ -e /usr/bin/byobu-launcher-install ]]; then
        byobu-launcher-install
        byobu-ctrl-a screen
    fi
fi

pip install --user flake8 pylint ipython

if [[ -f $HOME/.vim/Rakefile ]]; then
    cd $HOME/.vim && rake
fi
