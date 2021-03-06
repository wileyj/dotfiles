sudo -v

source .echo.sh

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

bot "ensuring build/install tools are available"
if ! xcode-select --print-path &> /dev/null; then
  # Prompt user to install the XCode Command Line Tools
  xcode-select --install &> /dev/null
  # Wait until the XCode Command Line Tools are installed
  until xcode-select --print-path &> /dev/null; do
    sleep 5
  done
  print_result $? ' XCode Command Line Tools Installed'
  # Prompt user to agree to the terms of the Xcode license
  # https://github.com/alrra/dotfiles/issues/10
  sudo xcodebuild -license
  print_result $? 'Agree with the XCode Command Line Tools licence'
fi

# running "checking homebrew..."
# brew_bin=$(which brew) 2>&1 > /dev/null
# if [[ $? != 0 ]]; then
#   action "installing homebrew"
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#   if [[ $? != 0 ]]; then
#     error "unable to install homebrew, script $0 abort!"
#     exit 2
#   fi
#   brew analytics off
# else
#   ok
#   bot "Homebrew"
#   read -r -p "run brew update && upgrade? [y|N] " response
#   if [[ $response =~ (y|yes|Y) ]]; then
#     action "updating homebrew..."
#     # brew update
#     ok "homebrew updated"
#     action "upgrading brew packages..."
#     # brew upgrade
#     ok "brews upgraded"
#   else
#     ok "skipped brew package upgrades."
#   fi
# fi

# # Just to avoid a potential bug
# mkdir -p ~/Library/Caches/Homebrew/Formula
# brew doctor
