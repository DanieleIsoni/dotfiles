# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

is_linux() { [ $(uname -s) -eq "Linux" ]; }
is_macos() { [ $(uname -s) -eq "Darwin" ]; }

plugins=(
	fzf-tab
	asdf
	command-not-found
	docker
	docker-compose
	git
	git-auto-fetch
	git-auto-status
	git-flow
	kubectl
	poetry
	terraform
	# virtualenvwrapper
	zsh-syntax-highlighting
	zsh-autosuggestions
)

if is_macos;
then
	plugins+=(
		brew
		macos
		pimento
	)
else

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# For virtual env to work
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
source $HOME/.asdf/installs/python/3.9.9/bin/virtualenvwrapper.sh;

# gettext
export PATH="/usr/local/opt/gettext/bin:$PATH"

export PATH="$HOME/dev/bin:$PATH"

####### ALIASES and FUNCTIONS

ntfsmnt(){
	/usr/local/bin/ntfs-3g $1 /Volume/NTFS -olocal -oallow_other
};

portToProcess() { 
	lsof -nP -i4TCP:${1}
}

# Python Virtualenvwrapper
alias wo=workon
alias dvenv=deactivate

mkvenv() {
	if [ $# -gt 1 ];
	then
		mkvirtualenv -p ${1}/bin/python ${2};
	else
		mkvirtualenv ${1};
	fi
};

alias rmvenv=rmvirtualenv
alias lsvenv='lsvirtualenv -b'

# git
alias gacp='{ IFS= read -r d && gaa && gcam "$d" && gp; } <<<'
alias glo="git log --oneline --decorate --pretty='%C(yellow)%h%Creset %C(auto)%d%Creset %s %Cgreen(%ai) %C(bold blue)<%an>%Creset'"

# Run programs
if is_macos;
then
	alias safari='open /Applications/Safari.app';
fi

CUSTOM_RC=~/.custom-rc
if [-f "$CUSTOM_RC"];
then 
	source $CUSTOM_RC;
fi

# Created by `userpath` on 2020-06-10 07:30:04
export PATH="$PATH:$HOME/.local/bin"

autoload -U +X bashcompinit && bashcompinit