#!/bin/zsh
echo "MacOS Configuration & Application Installation"
echo

# ask for the administrator password upfront.
echo "Please enter administrator password:"
sudo -v

# keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# fix zsh history
echo 'HISTSIZE=99999'              >> ~/.zshrc
echo 'HISTFILESIZE=999999'         >> ~/.zshrc
echo 'SAVEHIST=$HISTSIZE'          >> ~/.zshrc
echo 'alias history="history 1"'   >> ~/.zshrc

# enable alt-left & alt-right to go back and forth a word at a time
echo 'bindkey "^[b" backward-word' >> ~/.zshrc
echo 'bindkey "^[f" forward-word'  >> ~/.zshrc

# set hostname
echo "Setting hostname"
myname="theKnife"
sudo scutil --set ComputerName $myname
sudo scutil --set HostName $myname
sudo scutil --set LocalHostName $myname
hostname -f
echo

# install hombrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo

# fix homebrew paths on M1
# need to perform check for Apple silicon
echo "Fix Homebrew paths on Apple Silicon"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/garjones/.zprofile\n
eval "$(/opt/homebrew/bin/brew shellenv)"\n
echo

# install wget
brew instal wget

# brew install and configure git
brew install git
git config --global user.name "Gareth Jones"
git config --global user.email "gareth@gareth.com"
git config --global credential.helper osxkeychain
git config --global mergetool.sublime.cmd "subl -w \$MERGED"
git config --global mergetool.sublime.trustExitCode false 
git config --global merge.tool sublime
git mergetool -y

# install keyboard driver (personal to gareth)
brew install 1kc-razer

# install mac app store command-line interface
brew install mas

# install app store applications (personal to gareth)
mas install 412529613       #Cinch                 (1.2.4)
mas install 905953485       #NordVPN               (7.0.0)
mas install 403304796       #iNet Network Scanner  (2.8.51)
mas install 1037126344      #Apple Configurator 2  (2.15)
mas install 409201541       #Pages                 (11.2)
mas install 409183694       #Keynote               (11.2)
mas install 1198176727      #Controller            (5.11.0)
mas install 494803304       #WiFi Explorer         (3.3.2)
mas install 1274495053      #Microsoft To Do       (2.59)
mas install 409203825       #Numbers               (11.2)
mas install 497799835       #Xcode                 (13.2.1)

# add homebrew cask taps
brew tap homebrew/cask-versions
brew tap homebrew/cask-drivers

# install homebrew casks - microsoft applications
brew install --cask intune-company-portal
brew install --cask microsoft-edge
brew install --cask microsoft-office
brew install --cask microsoft-teams
brew install --cask microsoft-remote-desktop
brew install --cask microsoft-azure-storage-explorer
brew install --cask visual-studio-code
brew install --cask visual-studio-code-insiders
brew install --cask powershell

# install homebrew casks - adobe creative cloud
brew install --cask adobe-creative-cloud

# install homebrew casks - other web browsers
brew install --cask google-chrome
brew install --cask firefox

# install homebrew casks - developer tools
brew install --cask beyond-compare
brew install --cask postman
brew install --cask sf-symbols
#brew install --cask arduino 

# install homebrew casks - utilities
brew install --cask 1password
brew install --cask aerial
brew install --cask elgato-stream-deck
brew install --cask sonos
brew install --cask logitech-camera-settings
brew install --cask vlc
brew install --cask webex
brew install --cask zoom
#brew install --cask synergy

# create symbolic links for iCloud folders
echo "Creating symbolic links for iCloud"
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/dev ~/dev
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/dev/ssh ~/.ssh
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/install ~/install
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Pictures.Files ~/Pictures/Files
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Movies.Files ~/Movies/Files

# add microsoft teams custom backgrounds folder
rm -rf ~/Library/Application\ Support/Microsoft/Teams/Backgrounds/Uploads
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Pictures.Files/teams ~/Library/Application\ Support/Microsoft/Teams/Backgrounds/Uploads
echo

# set dock preferences - size, delete default entries, add entries we want restart dock
# this command will return the dock back to its default settings
# rm ~/Library/Preferences/com.apple.dock.plist; killall Dock
# if preferences do not get loaded properly
# killall cfprefsd
echo "Setting Dock Preferences"
defaults write com.apple.dock tilesize -int 48
defaults delete com.apple.dock persistent-apps
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Launchpad.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Utilities/Screenshot.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Messages.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Utilities/Terminal.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Microsoft Edge.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Microsoft Teams.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Microsoft Outlook.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/ManyCam/ManyCam.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
# defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
killall Dock
echo

# set finder preferences
defaults write com.apple.finder ShowPathbar -boolean true
defaults write com.apple.finder ShowStatusBar -boolean true
defaults write com.apple.finder ShowTabView -boolean true
defaults write com.apple.finder ShowHardDrivesOnDesktop -boolean false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -boolean false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -boolean false
defaults write com.apple.finder ShowMountedServersOnDesktop -boolean false
defaults write com.apple.finder NewWindowTarget PfHm
defaults write com.apple.finder NewWindowTargetPath $HOME
killall Finder
echo

# set terminal preferences
rm -rf $HOME/Library/Preferences/com.apple.Terminal.plist
wget https://raw.githubusercontent.com/garjones/macOS-config/main/com.apple.Terminal.plist  --directory-prefix=$HOME/Library/Preferences

# kill the terminal otherwise it will overwrite changes
read -p "Installation complete. About to kill the terminal ... "
killall Terminal

# download command line utils
# open https://developer.apple.com/download/more/

