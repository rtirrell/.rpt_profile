#!/bin/bash
if [[ $(hostname | grep dazzle) ]]; then
    echo "Should not be run from dazzle, will kill local changes."
    exit 1
fi

cd
wget --no-check-certificate https://github.com/rtirrell/.rpt_profile/tarball/master
tar -xzf master
rm -fr master
rm -fr .rpt_profile
# Named by username, plus repo name and a bunch of junk.
mv rtirrell* .rpt_profile


if [[ $(grep .rpt_profile ~/.bashrc | wc -l) == 0 ]]; then
    echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
fi

filenames="screenrc pylintrc vimrc.before vimrc.after"
for filename in $filenames; do
    ln -sf ~/.rpt_profile/etc/$filename ~/.$filename
done

pip install --user flake8 pylint ipython
source ~/.bashrc
