#!/usr/bin/env bash
# Put all files in place. Run this on a dev machine.

if [[ $(pwd) != $HOME ]]; then
    echo "Run from $HOME."
fi

if [[ $(grep rpt_profile .bashrc | wc -l) == 0 ]]; then
    echo 'source .rpt_profile/etc/bashrc' >> .bashrc
fi

filenames='screenrc pylintrc vimrc.before vimrc.after'
for filename in $filenames; do
    ln -sf .rpt_profile/etc/$filename .$filename
done

mkdir -p .byobu
for f in $(find .rpt_profile/etc/byobu -type f); do
    cp $f .byobu
done

if [[ -e /usr/bin/byobu-launcher-install ]]; then
    byobu-launcher-install
    byobu-ctrl-a screen
fi

pip install --user flake8 pylint ipython

if [[ -f .vim/Rakefile ]]; then
    cd .vim && rake
fi

source .bashrc
