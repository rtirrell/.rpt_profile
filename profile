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

rm-svn() {
  find . -name ".svn" -type d -exec rm -rf {} \;
}


