#!/bin/bash
if [[ $(hostname | grep dazzle) && ! $FORCE_SETUP ]]; then
    echo "Should not be run from dazzle, will kill local changes."
    exit 1
fi

cd
mv .rpt_profile .rpt_profile.bak

wget --no-check-certificate \
    https://github.com/rtirrell/.rpt_profile/tarball/master

tar -xzf master
rm -fr master

# Named by username, plus repo name and a bunch of junk.
mv rtirrell* .rpt_profile

bash update.sh
