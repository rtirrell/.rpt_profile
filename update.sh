if [[ $(grep rpt_profile .bashrc | wc -l) == 0 ]]; then
    echo 'source ~rpt/.rpt_profile/etc/bashrc' >> ~/.bashrc
fi

filenames='screenrc pylintrc vimrc.before vimrc.after'
for filename in $filenames; do
    ln -sf .rpt_profile/etc/$filename .$filename
done

mkdir -p .byobu
cp etc/byobu .byobu/status

pip install --user flake8 pylint ipython

if [[ -f .vim/Rakefile ]]; then
    cd .vim && rake
fi

source .bashrc
