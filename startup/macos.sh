#!/bin/bash

# turn off cursor acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# turn off scroll wheel acceleration
defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1

# turn off accent picker when holding down keys restoring key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# turn off desktop icons
defaults write com.apple.finder CreateDesktop false

