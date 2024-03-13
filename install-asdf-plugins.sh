#!/bin/zsh

echo "Installing python with asdf"
asdf plugin add python
asdf install python latest
asdf global python latest

echo "Installing go with asdf"
asdf plugin add golang
asdf install golang latest
asdf global golang latest

echo "Installing nodejs with asdf"
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

echo "Installing poetry with asdf"
asdf plugin add poetry
asdf install poetry latest
asdf global poetry latest

echo "Installing kubectl with asdf"
asdf plugin add kubectl
asdf install kubectl latest:1.24
asdf global kubectl latest:1.24

pythonLatest=$(asdf where python)
if [ $pythonLatest ]; then
    echo "Installing virtualenvwrapper"
    $pythonLatest/bin/pip install --upgrade pip
    $pythonLatest/bin/pip install virtualenvwrapper
fi
