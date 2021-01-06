# fisher
function setup_fisher
    eval (curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher)
    eval (fisher install \
        oh-my-fish/theme-bobthefish \
        oh-my-fish/plugin-peco \
        rafaelrinaldi/pure \
        matchai/spacefish \
        edc/bass \
        oh-my-fish/plugin-foreign-env \
        jorgebucaran/nvm.fish)
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
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
eval (pyenv init - | source)

# nvm
# set -x NVM_DIR $HOME/.nvm
# set -x NVM_PATH (brew --prefix nvm)
# eval ($NVM_PATH/nvm.sh | source)

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

