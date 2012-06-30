if [[ $(grep rpt_profile ~rpt/.bashrc | wc -l) == 0 ]]; then
    echo 'source ~rpt/.rpt_profile/etc/bashrc' >> ~rpt/.bashrc
fi

filenames='screenrc pylintrc vimrc.before vimrc.after'
for filename in $filenames; do
    ln -sf ~rpt/.rpt_profile/etc/$filename ~rpt/.$filename
done

mkdir -p ~/.byobu
for f in $(ls .rpt/.rpt_profile/etc/byobu); do
    cp $f ~rpt/.byobu
done

pip install --user flake8 pylint ipython

if [[ -f ~rpt/.vim/Rakefile ]]; then
    cd ~rpt/.vim && rake
fi

source ~rpt/.bashrc
