# macOS-config
Scripts to rebuild my mac


/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/garjones/macOS-config/main/

https://raw.githubusercontent.com/garjones/gareth.com/master/xxx.sh)"

---

### Notes:  

Currently Terminal is configured by replacing the com.apple.plist file, which is a bit of a hack.  
I have been trying to implement this solution, however I currently can not get it working in a script (works in a command line).  
https://apple.stackexchange.com/questions/344401/how-to-programatically-set-terminal-theme-profile  

I have previously modified the terminal PRO theme to my personal settings and then exported it using ..  
`code` plutil -extract Window\ Settings.Pro xml1 -o - ~/Library/Preferences/com.apple.Terminal.plist > terminal-pro.xml  

Now import those settings and set PRO to be the default & startup themes  
`code` terminalpro=$(curl -fsSL https://raw.githubusercontent.com/garjones/macOS-config/main/terminal-pro.xml)  
`code` plutil -replace Window\ Settings.Pro -xml "$terminalpro" ~/Library/Preferences/com.apple.Terminal.plist  
`code` defaults write com.apple.Terminal "Default Window Settings" -string "Pro"  
`code` defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"  
