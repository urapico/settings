#!/bin/bash

set -E

SCRIPT_DIR=$(cd $(dirname $0); pwd)
PYTHON_V="3.9.13"
COMPANY_GITHUB_ORG="your company org"

# brew install
xcode-select —install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install macvim
brew install tmux
brew install reattach-to-user-namespace
brew install git
brew install tig
brew install gh
brew install ghq
brew install peco
brew install zlib
brew install sqlite
brew install bzip2
brew install libiconv
brew install libzip
brew install exiftool
brew install fish
brew install gcc
brew install wget
brew install php
brew install --cask finicky
brew install fontforge
brew install --cask fontforge
brew install --cask font-hack-nerd-font
brew install direnv
brew install --cask fig
brew install starship
brew install exa
brew install gnupg
brew link --overwrite gnupg
brew install pinentry-mac

echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent

# env
brew install pyenv
brew install jenv

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# git
mkdir ~/my_project
mkdir ~/work
cat <<EOF > ~/.gitconfig
[ghq]
root = ~/my_project

[ghq "https://github.com/$COMPANY_GITHUB_ORG"]
root = ~/work

EOF
git config --global user.name "urapico"
git config --global user.email "urapico@gmail.com"
git config --global core.editor 'vim -c "set fenc=utf-8"'
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global core.precomposeunicode true
git config --global core.quotepath false
git config --global alias.st status
git config --global alias.co checkout
git config --global url.https://github.com/.insteadOf git@github.com:
git config --global --unset gpg.format
git config --global commit.gpgsign true
git config --global gpg.program gpg
git config --global --add --bool push.autoSetupRemote true

cat <<EOF >> ~/.gitconfig
[includeIf "gitdir:~/work/"]
path = ~/.gitconfig_work
EOF

touch ~/.gitconfig_work
cat <<EOF > ~/.gitconfig_work
[user]
        name = <your company name>
        email = <your company e-mail address>
[url "git@github.com:"]
        insteadOf = https://github.com/
EOF


# font
brew tap homebrew/cask-fonts
brew install --cask font-ricty-diminished
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminished-Bold.ttf
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminished-Oblique.ttf
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminishedDiscord-Bold.ttf
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminishedDiscord-Oblique.ttf
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminished-BoldOblique.ttf
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminished-Regular.ttf
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminishedDiscord-BoldOblique.ttf
$SCRIPT_DIR/_re_font.sh $HOME/Library/Fonts/RictyDiminishedDiscord-Regular.ttf

## 源ノ角ゴシック Code JP EL

wget https://github.com/adobe-fonts/source-han-code-jp/archive/refs/tags/2.012R.zip
unzip 2.012R.zip
cd source-han-code-jp-2.012R
mv ./OTF ~/Library/Fonts
cd ..
rm -rf source-han-code-jp-2.012R
rm -f 2.012R.zip

## hackgen

brew tap homebrew/cask-fonts
brew install font-hackgen
brew install font-hackgen-nerd

# symbolic link
ln -s $SCRIPT_DIR/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $SCRIPT_DIR/dotfiles/.vimrc $HOME/.vimrc
ln -s $SCRIPT_DIR/dotfiles/.finicky.js $HOME/.finicky.js
mkdir $HOME/.config/fish
ln -s $SCRIPT_DIR/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $SCRIPT_DIR/dotfiles/.config/fish/config.fish $HOME/.config/fish/config.fish
ln -s $SCRIPT_DIR/dotfiles/.config/starship.toml $HOME/.config/starship.toml

# login shell
if ! grep -q /opt/homebrew/bin/fish /etc/shells; then
    echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
    chsh -s /opt/homebrew/bin/fish
fi

# vim
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugInstall --sync' +qa

# pyenv
sudo xcode-select --switch /Library/Developer/CommandLineTools
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"
export LDFLAGS="-L$(xcrun --show-sdk-path)/usr/lib"
pyenv install $PYTHON_V
pyenv global $PYTHON_V

# powerline
pip install --upgrade pip
pip install powerline-status
git clone https://github.com/powerline/fonts.git
fonts/install.sh
rm -rf fonts
mkdir -p $HOME/.config/powerline
cp -r $HOME/.pyenv/versions/$PYTHON_V/lib/python3.9/site-packages/powerline/config_files/* $HOME/.config/powerline
rm -rf $HOME/.config/powerline/colorschemes/tmux/default.json
ln -s $SCRIPT_DIR/tmux-color.json $HOME/.config/powerline/colorschemes/tmux/default.json
