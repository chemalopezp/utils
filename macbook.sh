#!/bin/zsh
# Install updates

# Show bluetooth and audio buttons on menu bar
# Sync mouse and keyboard

# Install xcode CLI
xcode-select --install

# Install HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=/usr/local/bin:$PATH

brew install git
brew install pyenv
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask android-studio
brew install --cask docker
brew install --cask firefox
brew install --cask slack
brew install --cask android-studio
brew install --cask spotify
brew install --cask android-file-transfer beekeeper-studio buttercup discord disk-inventory-x figma gimp kap ngrok notion pgadmin4 postman prisma-studio vlc warp 

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts

# General: Expand save and print panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Finder
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
chflags nohidden ~/Library
defaults write com.apple.Finder AppleShowAllFiles true

# Taskbar
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.screencapture "location" -string "~/Pictures" && killall SystemUIServer
defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""

# Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Chrome
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# Git
git config --global credential.helper osxkeychain
git config

# Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Keygen
ssh-keygen -t rsa -b 4096 -C "chema.lopezp@gmail.com"

eval "$(ssh-agent -s)"

 ~/.ssh/config >> Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519

ssh-add -K ~/.ssh/id_ed25519

# Corepack
corepack enable
