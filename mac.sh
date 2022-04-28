#!/bin/bash

set -E

SCRIPT_DIR=$(cd $(dirname $0); pwd)
PYTHON_V="3.8.0"

# brew install
xcode-select —install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install macvim
brew install tmux
brew install reattach-to-user-namespace
brew install git
brew install tig
brew install hub
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
brew install fontforge
brew install --cask fontforge
brew install direnv

# env
brew install pyenv
brew install jenv

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# git
git config --global user.name "urapico"
git config --global user.email "urapico@gmail.com"
git config --global core.editor 'vim -c "set fenc=utf-8"'
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global core.precomposeunicode true
git config --global core.quotepath false
git config --global alias.st status

# font
brew tap homebrew/cask-fonts
brew cask install font-ricty-diminished
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
mkdir $HOME/.config/fish
ln -s $SCRIPT_DIR/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $SCRIPT_DIR/dotfiles/.config/fish/config.fish $HOME/.config/fish/config.fish

# login shell
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# vim
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugInstall --sync' +qa

# pyenv
sudo xcode-select --switch /Library/Developer/CommandLineTools
# CFLAeS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include" \
# LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib" \
export CFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include -I$(brew --prefix ncurses)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib -L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix ncurses)/lib -L$(xcrun --show-sdk-path)/usr/lib"
pyenv install -f --patch $PYTHON_V < <(curl -sSL https://github.com/python/cpython/commit/8ea6353.patch\?full_index\=1)

# powerline
pip install --upgrade pip
pip install powerline-status
git clone https://github.com/powerline/fonts.git
fonts/install.sh
rm -rf fonts
mkdir -p $HOME/.config/powerline
cp -r $HOME/.pyenv/versions/3.8.0/lib/python3.8/site-packages/powerline/config_files/* $HOME/.config/powerline
rm -rf $HOME/.config/powerline/colorschemes/tmux/default.json
ln -s $SCRIPT_DIR/tmux-color.json $HOME/.config/powerline/colorschemes/tmux/default.json
