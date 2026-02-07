# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

HISTSIZE=100000
SAVEHIST=100000

ZSH_THEME=""

source $HOME/.dotfiles-dir
source $DOTFILES_DIR/utils.sh # has is_macos and is_linux funcs

plugins=()

if is_macos; then
    plugins+=(
        macos
    )
fi

plugins+=(
    zerobrew
    brew
    mise
    command-not-found
    docker
    docker-compose
    dotenv
    fzf-tab
    git
    git-flow
    git-auto-fetch
    git-auto-status
    poetry
    uv
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vi-mode
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

DISABLE_AUTO_TITLE="true"

# Function to update the terminal title with the current running command
function update_term_title_with_command() {
    TILDE_PWD="${PWD/#$HOME/~}"
    PRE_COMMAND_PROMPT="$USER : $TILDE_PWD :"
    echo -ne "\033]0;$PRE_COMMAND_PROMPT $1\007"
}

# Preexec hook to capture the running command
preexec() {
    update_term_title_with_command "$1"
}

# Precognition: Ensures the terminal title reverts back to idle after a command finishes
precmd() {
    # TILDE_PWD="${PWD/#$HOME/~}"
    # PRE_COMMAND_PROMPT="$USER : $TILDE_PWD :"
    # echo -ne "\033]0;$PRE_COMMAND_PROMPT zsh\007"
    update_term_title_with_command "zsh"
}

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# For virtual env to work
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev

# Python Virtualenvwrapper
pythonPath=$(dirname "$(mise which python)")
source $pythonPath/virtualenvwrapper.sh

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

export EDITOR=/opt/homebrew/bin/nvim

# gettext
export PATH="/usr/local/opt/gettext/bin:$PATH"

export PATH="$HOME/dev/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"

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

# docker
alias ld="lazydocker"

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
alias vi="nvim"
export VISUAL="nvim --cmd 'let g:flatten_wait=1'"
export MANPAGER="nvim +Man!"
alias nv-conf="cd ~/.config/nvim && nvim"

# ssh
alias raspi="ssh raspberrypi"

# python
alias prun="poetry run"

# process-compose
alias pc="process-compose"

# tmux
alias t="tmux new -A -s default"
alias s='sesh connect "$(sesh list -i | gum filter --limit 1 --placeholder "Pick a sesh" --prompt="⚡")"'

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

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

CUSTOM_RC=~/.custom-rc
if [ -f $CUSTOM_RC ]; then
    source $CUSTOM_RC;
fi

# Created by `userpath` on 2020-06-10 07:30:04
export PATH="$PATH:$HOME/.local/bin"

autoload -U +X bashcompinit && bashcompinit

# Atuin
zvm_after_init_commands+=(eval "$(atuin init zsh)")

# Rust
. $HOME/.cargo/env

# Starship
type starship_zle-keymap-select >/dev/null || eval "$(starship init zsh)"
