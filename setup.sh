#!/bin/bash
# Setup for use.

if [[ -e ~rpt/.rpt_profile/.git ]]; then
    echo "Should not be run on a system with a repository."
    exit 1
fi

if [[ -d ~rpt/.rpt_profile ]]; then
    rm -fr ~rpt/.rpt_profile.bak
    mv ~rpt/.rpt_profile ~rpt/.rpt_profile.bak
fi

wget --no-check-certificate \
    https://github.com/rtirrell/.rpt_profile/tarball/master

tar -xzf master
rm -fr master

# Named by username, plus repo name and a bunch of junk (commit ID, etc.).
mv rtirrell* ~rpt/.rpt_profile

curl -Lo- https://bit.ly/janus-bootstrap | bash
~rpt/.rpt_profile/install.sh
