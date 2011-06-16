if [ !-f ~/.bashrc ]; then
    echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
else if [ $(grep .rpt_profile ~/.bashrc) | wc -l ) -eq 0 ]; then
    echo "source ~/.rpt_profile/etc/bashrc" >> ~/.bashrc
fi

echo "source ~/.rpt_profile/etc/vimrc" >> ~/.vimrc
