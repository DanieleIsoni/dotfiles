export USERNAME=$(whoami)

rcho $(uname -s)

if [ $(uname -s) == "Linux" ]; then
    is_linux=true
    is_macos=false
elif [ $(uname -s) == "Darwin" ]; then
    is_linux=false
    is_macos=true
else
    echo "Unsupported OS"
    exit 1
fi

if $CODESPACES; then
    DOTFILES_DIR="/workspaces/.codespaces/.persistedshare/dotfiles"
else
    DOTFILES_DIR="$HOME/dotfiles"
fi

mkdir dev
mkdir .virtualenvs

if $is_linux; then
    sudo apt-get update
    sudo apt-get -y install --no-install-recommends apt-utils dialog 2>&1

    sudo apt-get install -y \
    zsh;
elif $is_macos; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Unsupported OS"
    exit 1
fi

ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.tool-versions ~/.tool-versions
ln -sf $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh
if $is_linux; then sudo chsh -s /usr/bin/zsh $USERNAME; fi

# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# oh-my-zsh powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# install fonts
mkdir -p ~/.local/share/fonts 
wget -O ~/.local/share/fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -O ~/.local/share/fonts/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -O ~/.local/share/fonts/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -O ~/.local/share/fonts/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

fc-cache -f -v

# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
ln -sf $DOTFILES_DIR/oh-my-zsh/custom/plugins/git-auto-status ~/.oh-my-zsh/custom/plugins/git-auto-status

# install some things
if $is_linux; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf;
    sudo apt-get install -y fzf;
    sudo apt-get install git-flow;
elif $is_macos; then
    brew install asdf;
    brew install fzf;
    brew install git-flow-avh;
    brew install micro;
else
    echo "Unsupported OS"
    exit 1
fi

. $HOME/.asdf/asdf.sh;

asdf plugin add python
asdf install python 3.7.12
asdf install python 3.9.9

asdf plugin add go
asdf install go 1.15.15
asdf install go 1.16.12
asdf install go 1.17.5

asdf pulgin add nodejs
asdf install nodejs 16.8.0

asdf plugin add poetry
asdf install poetry 1.1.12

pip install --upgrade pip
pip install virtualenvwrapper