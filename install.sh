#!/bin/zsh

echo "export DOTFILES_DIR=$(dirname $(realpath "$0"))" > $HOME/.dotfiles-dir
source $HOME/.dotfiles-dir
source $DOTFILES_DIR/utils.sh

export USERNAME=$(whoami)

if is_linux; then
    sudo apt update
    sudo apt -y install --no-install-recommends apt-utils dialog 2>&1

    sudo apt install -y \
        zsh \
        gcc pkg-config libxml2-dev libxmlsec1-dev libxmlsec1-openssl \
        libffi-dev build-essential zlib1g-dev libreadline-dev libsqlite3-dev liblzma-dev libbz2-dev
    which brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
elif is_macos; then
    which brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Unsupported OS"
    exit 1
fi

# oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if IS_WORK && [ ! -f ~/.work-plugins.zshrc ]; then
    ln -sf $DOTFILES_DIR/.work-plugins.zshrc ~/.work-plugins.zshrc
fi

if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.old
fi
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
if is_linux; then sudo chsh -s /usr/bin/zsh $USERNAME; fi

source ~/.zshrc

OMZ_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# install fonts
if is_macos; then
    brew install --cask font-jetbrains-mono-nerd-font
fi

# oh-my-zsh plugins
OMZ_CUSTOM_PLUGINS=$OMZ_CUSTOM/plugins
ZSH_AUTOSUGGESTIONS_DIR=$OMZ_CUSTOM_PLUGINS/zsh-autosuggestions
if [ ! -d $ZSH_AUTOSUGGESTIONS_DIR ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTIONS_DIR
fi
ZSH_SYNTAX_HIGHLIGHTING_DIR=$OMZ_CUSTOM_PLUGINS/zsh-syntax-highlighting
if [ ! -d $ZSH_SYNTAX_HIGHLIGHTING_DIR ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHTING_DIR
fi
ZSH_VI_MODE_DIR=$OMZ_CUSTOM_PLUGINS/zsh-vi-mode
if [ ! -d $ZSH_VI_MODE_DIR ]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_VI_MODE_DIR
fi
FZF_TAB_DIR=$OMZ_CUSTOM_PLUGINS/fzf-tab
if [ ! -d $FZF_TAB_DIR ]; then
    git clone https://github.com/Aloxaf/fzf-tab $FZF_TAB_DIR
fi
GIT_AUTO_STATUS_DIR=$OMZ_CUSTOM_PLUGINS/git-auto-status
if [ ! -d $GIT_AUTO_STATUS_DIR ]; then
    ln -sf $DOTFILES_DIR/oh-my-zsh/custom/plugins/git-auto-status $GIT_AUTO_STATUS_DIR
fi
if IS_WORK; then
    AWS_VAULT_DIR=$OMZ_CUSTOM_PLUGINS/aws-vault
    if [ ! -d $AWS_VAULT_DIR ]; then
        mkdir $AWS_VAULT_DIR
        curl -o $AWS_VAULT_DIR/aws-vault.plugin.zsh https://raw.githubusercontent.com/99designs/aws-vault/master/contrib/completions/zsh/aws-vault.zsh
    fi
fi

# install some things
which asdf >/dev/null || brew install asdf
which atuin >/dev/null || brew install atuin
which bat >/dev/null || brew install bat
which bw >/dev/null || brew install bitwarden-cli
which bytop >/dev/null || brew install bytop
which delta >/dev/null || brew install git-delta
which fd >/dev/null || brew install fd
which fzf >/dev/null || (brew install fzf && $(brew --prefix)/opt/fzf/install --key-bindings --completion --update-rc)
which ghostty >/dev/null || brew install --cask ghostty
which git >/dev/null || brew install git
which git-flow >/dev/null || brew install git-flow-avh
which gum >/dev/null || brew install gum
which jq >/dev/null || brew install jq
which lazydocker >/dev/null || brew install lazydocker
which lazygit >/dev/null || brew install lazygit
which lazysql >/dev/null || brew install lazysql
which mosh >/dev/null || brew install mosh
# which nu >/dev/null || brew install nushell
which nvim >/dev/null || brew install neovim
which rich >/dev/null || brew install rich-cli
which rg >/dev/null || brew install ripgrep
which visidata >/dev/null || brew install saulpw/vd/visidata
which sesh >/dev/null || brew install joshmedeski/sesh/sesh
which speedtest >/dev/null || brew install speedtest-cli
which starship >/dev/null || brew install starship
which tmux >/dev/null || brew install tmux
which uv >/dev/null || brew install uv
which wget >/dev/null || brew install wget
which yazi >/dev/null || brew install yazi ffmpegthumbnailer ffmpeg sevenzip poppler imagemagick
which zoxide >/dev/null || brew install zoxide

if IS_WORK; then
    which aws >/dev/null || brew install awscli
    which aws-vault >/dev/null || brew install --cask aws-vault
    which copier >/dev/null || brew install copier
    which git-lfs >/dev/null || brew install git-lfs
    which glab >/dev/null || brew install glab
    brew tap hashicorp/tap
    which vault >/dev/null || brew install hashicorp/tap/vault
    which watchman >/dev/null || brew install watchman
fi

if is_macos; then
    which arc >/dev/null || brew install arc
    which orb >/dev/null || brew install orbstack

    brew install rocket
    brew install shortcat
    # brew install --cask TheBoredTeam/boring-notch/boring-notch --no-quarantine
    brew install --cask jordanbaird-ice
    brew install --cask karabiner-elements
    brew install --cask logi-options-plus
    brew install --cask raycast
    brew install --cask rectangle
    brew install --cask stats

    if IS_WORK; then true; else
        command -v mas >/dev/null
        if [ $? -ne 0 ]; then
            if [ $(uname -p) = i386 ]; then
                echo "\033[0;31mInstall mas from https://github.com/mas-cli/mas/releases since you are on an Intel Mac\033[0m";
                exit 1;
            else
                which mas >/dev/null || brew install mas
            fi
        fi
        mas install 1352778147 # Bitwarden
        mas install 1429033973 # RunCat
        mas install 1475387142 # Tailscale
        mas install 747648890  # Telegram
        mas install 1607635845 # Velja
        mas install 310633997 # WhatsApp
    fi
fi

if is_linux; then
    which tailscale >/dev/null || curl -fsSL https://tailscale.com/install.sh | sh
fi

if [ ! -d "$HOME/.virtualenvs" ]; then
    mkdir ~/.virtualenvs
fi

# Configs

CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG_DIR="$DOTFILES_DIR/config"

mkdir -p $CONFIG_DIR

## Ghostty
GHOSTTY_CONFIG_DIR="$CONFIG_DIR/ghostty"
if [ ! -d $GHOSTTY_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/ghostty $GHOSTTY_CONFIG_DIR
fi

## KarabinerElements
KARABINER_CONFIG_DIR="$CONFIG_DIR/karabiner"
if [ ! -d $KARABINER_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/karabiner $KARABINER_CONFIG_DIR
fi

## Nushell
# NUSHELL_CONFIG_DIR="$HOME/Library/Application Support/nushell"
# NUSHELL_XDG_CONFIG_DIR="$CONFIG_DIR/nushell"
# if [ ! -d $NUSHELL_XDG_CONFIG_DIR ]; then
#     ln -sf $DOTFILES_CONFIG_DIR/nushell $NUSHELL_XDG_CONFIG_DIR
#     ln -sf $NUSHELL_XDG_CONFIG_DIR $NUSHELL_CONFIG_DIR
# fi

## Starship
STARSHIP_CONFIG="$CONFIG_DIR/starship.toml"
if [ ! -f $STARSHIP_CONFIG ]; then
    ln -sf $DOTFILES_CONFIG_DIR/starship.toml $STARSHIP_CONFIG
fi

## Tmux
TMUX_CONFIG_DIR="$CONFIG_DIR/tmux"
if [ ! -d $TMUX_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/tmux $TMUX_CONFIG_DIR
fi

### TPM
TPM_DIR="$TMUX_CONFIG_DIR/plugins/tpm"
if [ ! -d $TPM_DIR ]; then
    git clone https://github.com/tmux-plugins/tpm $TPM_DIR
fi

### Tmux-Powerline
TMUX_P10K_CONFIG_DIR="$CONFIG_DIR/tmux-powerline"
if [ ! -d $TMUX_P10K_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/tmux-powerline $TMUX_P10K_CONFIG_DIR
fi

### Sesh
SESH_CONFIG_DIR="$CONFIG_DIR/sesh"
if [ ! -d $SESH_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/sesh $SESH_CONFIG_DIR
fi

## Atuin
ATUIN_CONFIG="$CONFIG_DIR/atuin/config.toml"
if [ -f $ATUIN_CONFIG ]; then
    mv $ATUIN_CONFIG "${ATUIN_CONFIG}.old"
fi
ln -sf $DOTFILES_CONFIG_DIR/atuin/config.toml $ATUIN_CONFIG

## Neovim
NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"
if [ ! -d $NVIM_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/nvim $NVIM_CONFIG_DIR
fi

## LazyGit
LAZYGIT_CONFIG_DIR="$CONFIG_DIR/lazygit"
if [ ! -d $LAZYGIT_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/lazygit $LAZYGIT_CONFIG_DIR
fi

## YamlFmt
YAMLFMT_CONFIG_DIR="$CONFIG_DIR/yamlfmt"
if [ ! -d $YAMLFMT_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/yamlfmt $YAMLFMT_CONFIG_DIR
fi


source ~/.zshrc

zsh $HOME/.asdf/asdf.sh

WORK=$WORK zsh $DOTFILES_DIR/install-asdf-plugins.sh
