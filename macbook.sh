#!/bin/zsh

VERSION="v1.0.0"
#===============================================================================
# title           macbook.sh
# author          Chema Lopez
#                 https://github.com/chemalopezp
#===============================================================================
xcode-select --install && \
        read -n 1 -r -s -p $'\n\nWhen Xcode cli tools are installed, press ANY KEY to continue...\n\n' || \
            printDivider && echo "✔ Xcode cli tools already installed. Skipping"
printDivider


# Install Brew
printHeading "Installing Homebrew"
printDivider
    git config --global url."https://github.com/".insteadOf git@github.com:
    git config --global url."https://".insteadOf git://
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
printDivider
    echo "✔ Setting Path to /usr/local/bin:\$PATH"
        export PATH=/usr/local/bin:$PATH
printDivider


# Install Utilities
printHeading "Installing Brew Packages"
    printStep "Git"                         "brew install git"
printDivider


# Install  Apps
printHeading "Installing Applications"
    printStep "Slack"                       "brew install --cask slack"
    printStep "Firefox"                     "brew install --cask firefox"
    printStep "Google Chrome"               "brew install --cask google-chrome"
    printStep "Docker for Mac"              "brew install --cask docker"
    printStep "Postman"                     "brew install --cask postman"
    printStep "Visual Studio Code"          "brew install --cask visual-studio-code"
    printStep "Android Studio"              "brew install --cask android-studio"
    printStep "MongoDB Compass"             "brew install --cask mongodb-compass"
    printStep "Zoom"                        "brew install --cask zoom"
    printStep "Spotify"                     "brew install --cask spotify"
printDivider


# Install Mac OS Python Pip and Packages
# Run this before "Homebrew Python 3" to make sure "Homebrew Python 3" will overwrite pip3
printHeading "Installing Mac OS Python"
    printDivider
        echo "Installing Pip for MacOS Python..."
            sudo -H /usr/bin/easy_install pip==20.3.4
    printDivider
        echo "Upgrading Pip for MacOS Python..."
            sudo -H pip install --upgrade "pip < 21.0"
    printStep "Invoke for MacOS Python"          "sudo -H pip install --quiet invoke"
    printStep "Requests for MacOS Python"        "sudo -H pip install --quiet requests"
    printStep "lxml for MacOS Python"            "sudo -H pip install --quiet lxml"
    printStep "pyCrypto for MacOS Python"        "sudo -H pip install --quiet pyCrypto"
    printStep "Virtualenv for MacOS Python"      "sudo -H pip install --quiet virtualenv"
printDivider


# Install Homebrew Python 3
printHeading "Installing Homebrew Python 3"
    printStep "Homebrew Python 3 with Pip"       "brew reinstall python"
printDivider


# Install Node
printHeading "Installing Node through NVM"
    printDivider
        getLastestNVM() {
            # From https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
            # Get latest release from GitHub api | Get tag line | Pluck JSON value
            curl --silent "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | 
                grep '"tag_name":' |
                sed -E 's/.*"([^"]+)".*/\1/'
        }
        echo "✔ Current NVM is $(getLastestNVM)"
    printDivider
        echo "Installing NVM (Node Version Manager) $(getLastestNVM)..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(getLastestNVM)/install.sh | bash
    printDivider
        echo "✔ Loading NVM into PATH"
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    printDivider
        echo "Installing LTS Node..."
        nvm install --lts
    printStep "Husky"                   "npm install -g husky"
    printDivider
        echo "✔ Touch ~/.huskyrc"
            touch ~/.huskyrc
    printDivider
        # Husky profile
        if grep --quiet "nvm" ~/.huskyrc; then
            echo "✔ .huskyrc already includes nvm. Skipping"
        else
            writetoHuskrc
            echo "✔ Add nvm to .huskyrc"
        fi
printDivider


# Install System Tweaks
printHeading "System Tweaks"
    printDivider
    echo "✔ General: Expand save and print panel by default"
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
        defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
        defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    echo "✔ General: Save to disk (not to iCloud) by default"
        defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    echo "✔ General: Avoid creating .DS_Store files on network volumes"
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    printDivider
        
    echo "✔ Typing: Disable smart quotes and dashes as they cause problems when typing code"
        defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
        defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    echo "✔ Typing: Disable press-and-hold for keys in favor of key repeat"
        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    printDivider

    echo "✔ Finder: Show status bar and path bar"
        defaults write com.apple.finder ShowStatusBar -bool true
        defaults write com.apple.finder ShowPathbar -bool true
    echo "✔ Finder: Disable the warning when changing a file extension"
        defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    echo "✔ Finder: Show the ~/Library folder"
        chflags nohidden ~/Library
    echo "✔ Finder: Show hidden files"
        defaults write com.apple.Finder AppleShowAllFiles true
	echo "✔ Finder: Set task bar on the right side"
	defaults write com.apple.dock "orientation" -string "right"

    echo "✔ Screenshots: Set location in ~/Pictures folder"
    defaults write com.apple.screencapture "location" -string "~/Pictures" && killall SystemUIServer
    defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0
    
    echo "✔ Mouse: Activate right click"
    defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton

    echo "✔ Clock: Set to 24h"
    defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""
    printDivider
        
    echo "✔ Safari: Enable Safari’s Developer Settings"
        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
        defaults write com.apple.Safari IncludeDevelopMenu -bool true
        defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
        defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
        defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
    printDivider
    
    echo "✔ Chrome: Disable the all too sensitive backswipe on Trackpads and Magic Mice"
        defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
        defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
        defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
        defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
    printDivider

    echo "✔ Chrome: Use the system print dialog and expand dialog by default"
        defaults write com.google.Chrome DisablePrintPreview -bool true
        defaults write com.google.Chrome.canary DisablePrintPreview -bool true
        defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
        defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
    printDivider
printDivider



#===============================================================================
#  Installer: Git
#===============================================================================


# Set up Git
printHeading "Set Up Git"

# Configure git to always ssh when dealing with https github repos
# git config --global url."git@github.com:".insteadOf https://github.com/

printDivider
    echo "✔ Set Git to store credentials in Keychain"
    git config --global credential.helper osxkeychain
printDivider
    if [ -n "$(git config --global user.email)" ]; then
        echo "✔ Git email is set to $(git config --global user.email)"
    else
        read -p 'What is your Git email address?: ' gitEmail
        git config --global user.email "$gitEmail"
    fi
printDivider
    if [ -n "$(git config --global user.name)" ]; then
        echo "✔ Git display name is set to $(git config --global user.name)"
    else
        read -p 'What is your Git display name (Firstname Lastname)?: ' gitName
        git config --global user.name "$gitName"
    fi
    git config --global init.defaultBranch main
printDivider

#===============================================================================
#  Installer: OhMyZsh
#===============================================================================

printHeading "Set Up OhMyZsh"
printStep "oh-my-zsh"                   "sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)""

#===============================================================================
#  Installer: Complete
#===============================================================================

printHeading "Script Complete"
printDivider

tput setaf 2 # set text color to green
cat << "EOT"

   ╭─────────────────────────────────────────────────────────────────╮
   │░░░░░░░░░░░░░░░░░░░░░░░░░░░ Next Steps ░░░░░░░░░░░░░░░░░░░░░░░░░░│
   ├─────────────────────────────────────────────────────────────────┤
   │                                                                 │
   │   There are still a few steps you need to do to finish setup.   │
   │                                                                 │
   │        The link below has Post Installation Instructions        │
   │                                                                 │
   └─────────────────────────────────────────────────────────────────┘

EOT
tput sgr0 # reset text
echo "Link:"
echo $README
echo ""
echo ""
tput bold # bold text
read -n 1 -r -s -p $'             Press any key to to open the link in a browser...\n\n'
open $README
tput sgr0 # reset text

echo ""
echo ""
echo "Please open a new terminal window to continue your setup steps"


exit



 ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

 eval "$(ssh-agent -s)"

 ~/.ssh/config >> Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519

  ssh-add -K ~/.ssh/id_ed25519


  pOWRLINE

  git clone https://github.com/powerline/fonts.git --depth=1 &&
cd fonts &&
./install.sh &&