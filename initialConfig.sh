#!/bin/zsh
echo "MacOS Configuration & Application Installation"
echo "Please enter administrator password:"
echo

# ask for the administrator password upfront.
sudo -v

# keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# set hostname
echo "Setting hostname"
myname="lebis-alarcon"
sudo scutil --set ComputerName $myname
sudo scutil --set HostName $myname
sudo scutil --set LocalHostName $myname
hostname -f
echo

# Install rosetta
sudo softwareupdate --install-rosetta

# install hombrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo

# fix homebrew paths on M1
# need to perform check for Apple silicon
echo "Fix Homebrew paths on Apple Silicon"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile\n
eval "$(/opt/homebrew/bin/brew shellenv)"\n
echo

# enable brew auto completion
echo 'FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"' >> ~/.zprofile\n

# add homebrew cask taps
brew tap homebrew/cask-versions
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts

# install wget
brew instal wget

# install svn
brew install svn

# install tldr
brew install tldr

# brew install and configure git
echo "Enter email for git"
read $gitEmail
brew install git
git config --global user.name "Lebis Alarcon"
git config --global user.email "$gitEmail"
git config --global credential.helper osxkeychain
git config --global mergetool.sublime.cmd "subl -w \$MERGED"
git config --global mergetool.sublime.trustExitCode false 
git config --global merge.tool sublime
git mergetool -y

# install azure cli
brew install azure-cli

# install homebrew casks - microsoft applications
brew install intune-company-portal
brew install microsoft-edge
brew install microsoft-office
brew install microsoft-teams
brew install microsoft-remote-desktop
brew install microsoft-azure-storage-explorer
brew install visual-studio-code
brew install visual-studio-code-insiders
brew install powershell

#install homebrew casks - adobe creative cloud
#brew install adobe-creative-cloud

# install homebrew casks - other web browsers
brew install google-chrome
brew install firefox

# install homebrew casks - developer tools
#brew install beyond-compare
brew install postman
#brew install sf-symbols
#brew install arduino
#brew install flutter
#manycam?


# install homebrew casks - utilities
brew install 1password
brew install zoom
brew install microsoft-teams
#brew install slack

#brew install synergy

# install mac app store command-line interface
brew install mas

# install fonts
brew install font-source-sans-pro
brew install font-montserrat
brew install $( brew search noto | grep font | tr '\n' ' ' )
brew install $( brew search powerline | grep font | tr '\n' ' ' )
# use font Menlo Regular for Powerline 12

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# comment out ZSH_THEME
sed -i.bak "s/ZSH_THEME=\"robbyrussell\"/#ZSH_THEME=\"robbyrussell\"/" .zshrc

# add support for az cli command line completion
echo '# az cli completion'                                                                          >> ~/.zshrc
echo 'autoload -Uz compinit'                                                                        >> ~/.zshrc
echo 'autoload -Uz bashcompinit'                                                                    >> ~/.zshrc
echo 'compinit'                                                                                     >> ~/.zshrc
echo 'bashcompinit'                                                                                 >> ~/.zshrc
echo 'source /opt/homebrew/etc/bash_completion.d/az'                                                >> ~/.zshrc
echo ''                                                                                             >> ~/.zshrc


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


# download command line utils
# open https://developer.apple.com/download/more/
