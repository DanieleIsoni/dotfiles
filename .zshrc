# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

is_linux() { [ $(uname -s) = "Linux" ]; }
is_macos() { [ $(uname -s) = "Darwin" ]; }

plugins=()

if is_macos; then
    plugins+=(
        brew
        macos
    )
fi

plugins+=(
    asdf
    aws-vault
    command-not-found
    docker
    docker-compose
    dotenv
    fzf-tab
    git
    git-flow
    git-auto-fetch
    git-auto-status
    kubectl
    poetry
    terraform
    # vi-mode
    zsh-syntax-highlighting
    zsh-autosuggestions
)


CUSTOM_PLUGINS_RC=~/.custom-plugins-rc
if [ -f $CUSTOM_PLUGINS_RC ]; then
    source $CUSTOM_PLUGINS_RC;
fi

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true
ZSH_DISABLE_COMPFIX=true
# VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ ! -f ~/.p10k.zsh ] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# For virtual env to work
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev

# Python Virtualenvwrapper
pythonVersion=$(python --version)
# this is for python 2 which prints version in stderr
if [[ $pythonVersion == "" ]]; then
    pythonVersion=$(python --version 2>&1)
fi

pythonVersion=$(echo $pythonVersion | sed 's/Python //')

source $HOME/.asdf/installs/python/$pythonVersion/bin/virtualenvwrapper.sh

alias wo=workon
alias dvenv=deactivate

mkvenv() {
    if [ $# -gt 1 ]; then
        mkvirtualenv -p ${1}/bin/python ${2};
    else
        mkvirtualenv ${1};
    fi
};

alias rmvenv=rmvirtualenv
alias lsvenv='lsvirtualenv -b'

# gettext
export PATH="/usr/local/opt/gettext/bin:$PATH"

export PATH="$HOME/dev/bin:$PATH"

####### ALIASES and FUNCTIONS

ntfsmnt(){
    /usr/local/bin/ntfs-3g $1 /Volume/NTFS -olocal -oallow_other
};

portToProcess() {
    lsof -nP -i :${1}
}

# git
alias gacp='{ IFS= read -r d && gaa && gcam "$d" && gp; } <<<'
alias glo="git log --oneline --decorate --pretty='%C(yellow)%h%Creset %C(auto)%d%Creset %s %Cgreen(%ai) %C(bold blue)<%an>%Creset'"
alias gl="git pull --rebase"
alias lg="lazygit"

# Run programs
if is_macos; then
    alias feature_name="pbpaste | tr '[:upper:]' '[:lower:]' | tr ' _' '-' | tr -cd '[:alnum:]-' | sed 's/zebra/ZEBRA/' | sed 's/kiwi/KIWI/'"
    alias gfs='gflfs $(feature_name)'
    alias safari='open /Applications/Safari.app';
fi

# make
alias m="make"

# Modify files
alias zrc='cd ~/dotfiles/ && vim .zshrc'

# Vim
alias vim="nvim"
export VISUAL="nvim --cmd 'let g:flatten_wait=1'"
export MANPAGER="nvim +Man!"
alias nv-conf="cd ~/.config/nvim && nvim"

# ssh
alias raspi="ssh raspberrypi"

# python
alias prun="poetry run"

# process-compose
alias pc="process-compose"

# if [ -z "$BW_SESSION" ]; then
#     export BW_SESSION=$(bw unlock --raw)
# fi
function bw_get_password() {
    bw sync > /dev/null
    local query=$1

    ERR_COUNT=0
    until PASSWORD=$(bw get password $query);
    do
        let ERR_COUNT++
        if [ $ERR_COUNT -ge 3 ]
        then
            echo "Too many attempts for bitwarden master password"
            return 1;
        fi
    done
    echo $PASSWORD
}

CUSTOM_RC=~/.custom-rc
if [ -f $CUSTOM_RC ]; then
    source $CUSTOM_RC;
fi

# Created by `userpath` on 2020-06-10 07:30:04
export PATH="$PATH:$HOME/.local/bin"

autoload -U +X bashcompinit && bashcompinit
