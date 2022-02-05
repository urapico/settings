# fisher
function setup_fisher
    eval (curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher)
    eval (fisher install \
        oh-my-fish/theme-bobthefish \
        oh-my-fish/plugin-peco \
        rafaelrinaldi/pure \
        matchai/spacefish \
        edc/bass \
        oh-my-fish/plugin-foreign-env)
end
if not type -q fisher
    eval (setup_fisher)
end

set -x EDITOR vim

# custom tool
# set -x PATH $PATH $HOME/my_project/tools/operation/database
# set -x PATH $PATH $HOME/my_project/tools/operation/log_tools

set -x PATH $PATH /usr/local/bin/git
set -x PATH $PATH $HOME/development/flutter/bin

# pyenv
set -x PATH $PATH /usr/local/bin/pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
status is-interactive; and pyenv init --path | source

# nvm
# ~/.config/fish/functions/nvm.fish
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# ~/.config/fish/functions/nvm_find_nvmrc.fish
function nvm_find_nvmrc
  bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
end

# ~/.config/fish/functions/load_nvm.fish
function load_nvm --on-variable="PWD"
  set -l default_node_version (nvm version default)
  set -l node_version (nvm version)
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
    if test "$nvmrc_node_version" = "N/A"
      nvm install (cat $nvmrc_path)
    else if test nvmrc_node_version != node_version
      nvm use $nvmrc_node_version
    end
  else if test "$node_version" != "$default_node_version"
    echo "Reverting to default Node version"
    nvm use default
  end
end

# ~/.config/fish/config.fish
# You must call it on initialization or listening to directory switching won't work
load_nvm

# jenv
set -x JENV_ROOT $HOME/.jenv
if test -d $JENV_ROOT
    set -x PATH $JENV_ROOT/bin $PATH
    eval (jenv init - | source)

    # set -x JAVA_HOME $JENV_ROOT/jenv/versions/1.8
    # set -x JRE_HOME eval(/usr/libexec/java_home -v 1.8)
    # set -x M2_HOME /usr/local/Cellar/maven/3.5.2/libexec
end

# git
eval (hub alias -s)
set -x GET_PAGER "LESSCHARSET=utf-8 less"
alias glog="git --no-pager log -n 20 --oneline | nl"

function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end
  history|peco $peco_flags|read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
function fish_user_key_bindings
  bind \cr 'peco_select_history_order' # Ctrl + R
end

# ghq
set -x PATH $PATH $HOME/Downloads/trang-20181222
alias g='hub browse (ghq list | peco | cut -d "/" -f 2,3)'
alias v='cd (ghq root)/(ghq list | peco)'

alias cb='git symbolic-ref --short HEAD | tr -d "\n" | pbcopy'

