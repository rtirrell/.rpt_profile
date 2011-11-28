set -o vi
export EDITOR="vim"
export PS1="[\[\e[28;1m\]\h \[\e[0m\]\W]\$ "

# Launch screen.
s() {
  if [[ -d $1 ]]; then
    cd $1
    screen -SDR $(basename $(pwd))
  else
    screen -SDR $1
  fi;
}

# grep, ignoring anything in .svn.
grepws() {
    grep -Ir $1 $2 | grep -v .svn
}

# rm all .svn dirs.
rm_svn() {
    find . -name ".svn" -type d -exec rm -rf {} \;
}

# Do something to all directories immediately in the current one.
do_children() {
    find . -maxdepth 1 -mindepth 1 -type d -exec $1 {} \;
}

svnupall() {
    do_children 'svn up'
}

svnstall() {
    do_children 'svn st'
}


for f in $(find ~/.rpt_profile/etc/sites -type f); do source $f; done
source ~/.rpt_profile/etc/bash_aliases.sh

# Use bash completion on Macports. Should already be installed on Linux.
if [ -f /opt/local/etc/bash_completion ]; then
    source /opt/local/etc/bash_completion
else
    if [[ `uname` == "Darwin" ]]; then
        echo "bash-completion is not installed!"
    fi
fi
