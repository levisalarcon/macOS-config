# macOS-config
Scripts to rebuild my mac




#
# i have previously modified the terminal PRO theme to my personal settings and then exported it using ..
# plutil -extract Window\ Settings.Pro xml1 -o - ~/Library/Preferences/com.apple.Terminal.plist > terminal-pro.xml
#
# now import those settings and set PRO to be the default & startup themes
#terminalpro=$(curl -fsSL https://raw.githubusercontent.com/garjones/macOS-config/main/terminal-pro.xml)
#plutil -replace Window\ Settings.Pro -xml "$terminalpro" ~/Library/Preferences/com.apple.Terminal.plist
#defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
#defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"
