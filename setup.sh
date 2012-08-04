#!/bin/bash
# Setup for use.

if [[ -e $HOME/.rpt_profile/.git ]]; then
    echo "Should not be run on a system with a repository."
    exit 1
fi

if [[ -d $HOME/.rpt_profile ]]; then
    rm -fr $HOME/.rpt_profile.bak
    mv $HOME/.rpt_profile $HOME/.rpt_profile.bak
fi

wget --no-check-certificate \
    https://github.com/rtirrell/.rpt_profile/tarball/master

tar -xzf master
rm -fr master

# Named by username, plus repo name and a bunch of junk (commit ID, etc.).
mv rtirrell* $HOME/.rpt_profile

curl -Lo- https://bit.ly/janus-bootstrap | bash
$HOME/.rpt_profile/install.sh
