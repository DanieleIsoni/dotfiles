export USERNAME=`daniso`

is_linux() { [ $(uname -s) -eq "Linux" ]; }
is_macos() { [ $(uname -s) -eq "Darwin" ]; }

mkdir dev
mkdir .virtualenvs

if is_linux;
then
    sudo apt-get update
    sudo apt-get -y install --no-install-recommends apt-utils dialog 2>&1

    sudo apt-get install -y \
    zsh \
    snapd;
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tool-versions ~/.tool-versions
if is_linux; then chsh -s /usr/bin/zsh $USERNAME; fi

# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
ln -s ~/dotfiles/oh-my-zsh/custom/plugins/git-auto-status ~/.oh-my-zsh/custom/plugins/git-auto-status

# install some things
if is_linux;
then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf;
    sudo apt-get install -y fzf;
    apt-get install git-flow;
else
    brew install asdf;
    brew install fzf;
    brew install git-flow-avh;
    brew install micro;
fi

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

pip install virtualenvwrapper