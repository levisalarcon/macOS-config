#!/bin/zsh

# install and configure git
brew install git
git config --global user.name "Gareth Jones"
git config --global user.email "garjones@gmail.com"
git config --global credential.helper osxkeychain
git config --global mergetool.sublime.cmd "subl -w \$MERGED"
git config --global mergetool.sublime.trustExitCode false 
git config --global merge.tool sublime
git mergetool -y

# use home as the working directory from now on  
#cd ~/.
# point home folders to iCloud Drive
# hope by now these folders have synched!
sudo rm -rf ~/Movies/
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Movies/ ~/
