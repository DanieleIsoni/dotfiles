#!/bin/zsh

if [ -n "$CODESPACES" ]; then
    DOTFILES_DIR="/workspaces/.codespaces/.persistedshare/dotfiles"
else
    DOTFILES_DIR="$HOME/dotfiles"
fi

export USERNAME=$(whoami)

is_linux() { [ $(uname -s) = "Linux" ]; };
is_macos() { [ $(uname -s) = "Darwin" ]; };

if is_linux; then
    sudo apt update
    sudo apt -y install --no-install-recommends apt-utils dialog 2>&1

    sudo apt install -y \
        zsh \
        gcc pkg-config libxml2-dev libxmlsec1-dev libxmlsec1-openssl \
        libffi-dev build-essential zlib1g-dev libreadline-dev libsqlite3-dev liblzma-dev libbz2-dev;
    which brew > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
elif is_macos; then
    which brew > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Unsupported OS"
    exit 1
fi

# oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.old
fi

ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh
if is_linux; then sudo chsh -s /usr/bin/zsh $USERNAME; fi

source ~/.zshrc

OMZ_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# oh-my-zsh powerlevel10k theme
P10K_DIR=$OMZ_CUSTOM/themes/powerlevel10k
if [ ! -d $P10K_DIR ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10K_DIR
fi

# install fonts
if is_macos; then
    brew tap homebrew/cask-fonts
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
FZF_TAB_DIR=$OMZ_CUSTOM_PLUGINS/fzf-tab
if [ ! -d $FZF_TAB_DIR ]; then
    git clone https://github.com/Aloxaf/fzf-tab $FZF_TAB_DIR
fi
GIT_AUTO_STATUS_DIR=$OMZ_CUSTOM_PLUGINS/git-auto-status
if [ ! -d $GIT_AUTO_STATUS_DIR ]; then
    ln -sf $DOTFILES_DIR/oh-my-zsh/custom/plugins/git-auto-status $GIT_AUTO_STATUS_DIR
fi
AWS_VAULT_DIR=$OMZ_CUSTOM_PLUGINS/aws-vault
if [ ! -d $AWS_VAULT_DIR ]; then
    mkdir $AWS_VAULT_DIR
    curl -o $AWS_VAULT_DIR/aws-vault.plugin.zsh https://raw.githubusercontent.com/99designs/aws-vault/master/contrib/completions/zsh/aws-vault.zsh
fi

# install some things
brew tap hashicorp/tap;

which asdf > /dev/null || brew install asdf;
which aws > /dev/null || brew install awscli;
which bat > /dev/null || brew install bat;
which bw > /dev/null || brew install bitwarden-cli;
which delta > /dev/null || brew install git-delta;
which fd > /dev/null || brew install fd;
which fzf > /dev/null || (brew install fzf && $(brew --prefix)/opt/fzf/install --key-bindings --completion --update-rc);
which git > /dev/null || brew install git;
which git-flow > /dev/null || brew install git-flow-avh;
which jq > /dev/null || brew install jq
which lazygit > /dev/null || brew install lazygit;
which nvim > /dev/null || brew install neovim;
which rich > /dev/null || brew install rich-cli;
which rg > /dev/null || brew install ripgrep;
which vault > /dev/null || brew install hashicorp/tap/vault;
which visidata > /dev/null || brew install saulpw/vd/visidata;
which speedtest > /dev/null || brew install speedtest-cli;
which teleport > /dev/null || brew install teleport;
which tmux > /dev/null || brew install tmux;
which watchman > /dev/null || brew install watchman;
which wget > /dev/null || brew install wget;
which yazi > /dev/null || brew install yazi ffmpegthumbnailer ffmpeg sevenzip poppler imagemagick;
which zoxide > /dev/null || brew install zoxide;

which aws-vault > /dev/null || brew install --cask aws-vault;

if is_macos; then
    which arc > /dev/null || brew install arc;
    which mas > /dev/null || brew install mas;
    which orb > /dev/null || brew install orbstack;
    which tailscale > /dev/null || brew install tailscale;

    brew install --cask logi-options-plus;
    brew install --cask raycast;
    brew install --cask rectangle;
    brew install --cask stats;

    mas install 1352778147; # Bitwarden
    mas install 1438243180; # Dark Reader for Safari
    mas install 905953485; # NordVPN
    mas install 1429033973; # RunCat
    mas install 803453959; # Slack
    mas install 1475387142; # Tailscale
    mas install 747648890; # Telegram
    mas install 1607635845; # Velja
    mas install 1147396723; # WhatsApp
fi

if is_linux; then
    which tailscale > /dev/null || curl -fsSL https://tailscale.com/install.sh | sh
fi

mkdir .virtualenvs

# Configs

CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG_DIR="$DOTFILES_DIR/config"

mkdir -p $CONFIG_DIR

## Ghostty
GHOSTTY_CONFIG_DIR="$CONFIG_DIR/ghostty"
if [ ! -d $GHOSTTY_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/ghostty $GHOSTTY_CONFIG_DIR
fi

## Neovim

NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"
if [ ! -d $NVIM_CONFIG_DIR ]; then
    ln -sf $DOTFILES_CONFIG_DIR/nvim $NVIM_CONFIG_DIR
fi

source ~/.zshrc;

zsh $HOME/.asdf/asdf.sh;

zsh $DOTFILES_DIR/install-asdf-plugins.sh
