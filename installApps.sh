#!/bin/zsh

# ask for the administrator password upfront.
sudo -v

# keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# install homebrew 
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update
brew upgrade
echo

# install wget & cask
brew instal wget 

# install utilities
brew cask install google-chrome
brew cask install firefox
brew cask install vlc
brew cask install 1passwo
rd
brew cask install beyond-compare
brew cask install synergy
brew cask install nordvpn
brew cask install zoomus

# office
brew cask install microsoft-office
brew cask install microsoft-teams
brew cask install adobe-creative-cloud
brew cask install intune-company-portal

# install dev tools
brew cask install visual-studio-code
brew cask install arduino 

#GlobalProtect.app
#Sophos Anti-Virus.app
#CalDigit Docking Station Utility
