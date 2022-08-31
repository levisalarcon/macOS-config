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
myname="theKnife"
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

# install azure cli
brew install azure-cli

# install homebrew casks - microsoft applications
#brew install intune-company-portal
brew install microsoft-edge
brew install microsoft-office
brew install microsoft-teams
brew install microsoft-remote-desktop
brew install microsoft-azure-storage-explorer
brew install visual-studio-code
brew install visual-studio-code-insiders
brew install powershell

# install homebrew casks - adobe creative cloud
brew install adobe-creative-cloud

# install homebrew casks - other web browsers
brew install google-chrome
brew install firefox

# install homebrew casks - developer tools
brew install beyond-compare
brew install postman
brew install sf-symbols
#brew install arduino
#brew install flutter
#manycam?


# install homebrew casks - utilities
brew install 1password
brew install aerial
brew install elgato-stream-deck
brew install sonos
brew install logitech-camera-settings
brew install vlc
brew install webex
brew install zoom
brew install slack
brew install soundsource
brew install rectangle
#brew install synergy

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

# install powerlevel10k theme and omz plugins 
brew install romkatv/powerlevel10k/powerlevel10k
brew install zsh-syntax-highlighting
brew install zsh-history-substring-search

# configure oh-me-zsh to use powerlevel10k theme and plugins
echo '# omz theme and plugins'                                                                      >> ~/.zshrc
echo 'source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme'                            >> ~/.zshrc
echo 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'            >> ~/.zshrc
echo 'source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh'  >> ~/.zshrc
echo ''                                                                                             >> ~/.zshrc

# add support for az cli command line completion
echo '# az cli completion'                                                                          >> ~/.zshrc
echo 'autoload -Uz compinit'                                                                        >> ~/.zshrc
echo 'autoload -Uz bashcompinit'                                                                    >> ~/.zshrc
echo 'compinit'                                                                                     >> ~/.zshrc
echo 'bashcompinit'                                                                                 >> ~/.zshrc
echo 'source /opt/homebrew/etc/bash_completion.d/az'                                                >> ~/.zshrc
echo ''                                                                                             >> ~/.zshrc

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
wget https://raw.githubusercontent.com/garjones/macOS-config/main/GJPro.terminal
open GJPro.terminal
rm GJPro.terminal

# set the defaults and kill the terminal otherwise it will overwrite changes
read -p "Installation complete. About to kill the terminal ... "
defaults write com.apple.terminal "Default Window Settings" "GJPro"
defaults write com.apple.terminal "Startup Window Settings" "GJPro"
killall Terminal

# download command line utils
# open https://developer.apple.com/download/more/
