#!/bin/bash

cd ~rpt

if [[ $(hostname | grep dazzle) && ! $FORCE_SETUP ]]; then
    echo "Should not be run from dazzle, will kill local changes."
    exit 1
fi

if [[ -d ~rpt/.rpt_profile ]]; then
    mv .rpt_profile .rpt_profile.bak
fi

wget --no-check-certificate \
    https://github.com/rtirrell/.rpt_profile/tarball/master

tar -xzf master
rm -fr master

# Named by username, plus repo name and a bunch of junk.
mv rtirrell* .rpt_profile

# rc files in place before installing Janus.
bash .rpt_profile/update.sh
curl -Lo- https://bit.ly/janus-bootstrap | bash
