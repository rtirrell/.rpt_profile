#!/bin/bash
# Setup for use.

if [[ $(pwd) != $HOME ]]; then
    echo "Run from $HOME."
fi

if [[ -e .rpt_profile/.git ]]; then
    echo "Should not be run on a system with a repository."
    exit 1
fi

if [[ -d .rpt_profile ]]; then
    rm -fr .rpt_profile.bak
    mv .rpt_profile .rpt_profile.bak
fi

wget --no-check-certificate \
    https://github.com/rtirrell/.rpt_profile/tarball/master

tar -xzf master
rm -fr master

# Named by username, plus repo name and a bunch of junk (commit ID, etc.).
mv rtirrell* .rpt_profile

curl -Lo- https://bit.ly/janus-bootstrap | bash
.rpt_profile/install.sh
