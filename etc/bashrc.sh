set -o vi
export EDITOR="vim"
export PS1="[\[\e[28;1m\]\h \[\e[0m\]\W]\$ "

s() {
  if [ -d $1 ]; then
    cd $1
    screen -SDR $(basename $(pwd))
  else
    screen -SDR $1
  fi;
}

grepws() {
    grep -Ir $1 $2 | grep -v .svn
}

rmsvn() {
    find . -name ".svn" -type d -exec rm -rf {} \;
}

dochildren() {
    find . -maxdepth 1 -mindepth 1 -type d -exec $1 {} \;
}

svnupall() {
    dochildren 'svn up'
}

svnstall() {
    dochildren 'svn st'
}


for f in $(find ~/.rpt_profile/etc/sites -type f); do . $f; done

source ~/.rpt_profile/etc/bash_aliases.sh
