#!/bin/zsh

# settings

# ask for the administrator password upfront.
sudo -v

# keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# set hostname
echo "Setting hostname"
myname="theKnife"
sudo scutil --set ComputerName $myname
sudo scutil --set HostName $myname
sudo scutil --set LocalHostName $myname
hostname -f
echo

# set dock preferences - size, delete default entries, restart
defaults write com.apple.dock tilesize -int 32
defaults delete com.apple.dock persistent-apps
launchctl stop com.apple.Dock.agent

# set finder preferences
defaults write com.apple.finder ShowPathbar -boolean true
defaults write com.apple.finder ShowStatusBar -boolean true
defaults write com.apple.finder ShowTabView -boolean true
defaults write com.apple.finder ShowHardDrivesOnDesktop -boolean false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -boolean false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -boolean false
defaults write com.apple.finder ShowMountedServersOnDesktop -boolean false
defaults write com.apple.finder NewWindowTarget PfHm
defaults write com.apple.finder NewWindowTargetPath 'file:///Users/garjones'
killall Finder
echo

# kill the terminal otherwise it will overwrite changes
read -p "About to kill the terminal ... "
killall Terminal

# download command line utils
open https://developer.apple.com/download/more/
open https://aka.ms/mac
