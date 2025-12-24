#!/bin/zsh

source $(dirname "$0")/utils.sh

echo "Installing python with asdf"
asdf plugin add python
LASTEST_PY=$(asdf latest python)
if [[ "$LASTEST_PY" = *t ]]; then
    LASTEST_PY="${LASTEST_PY::-1}"
fi
asdf set -u python $LASTEST_PY
asdf install python

echo "Installing go with asdf"
asdf plugin add golang
asdf set -u golang latest
asdf install golang

echo "Installing nodejs with asdf"
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf set -u nodejs latest
asdf install nodejs

echo "Installing poetry with asdf"
asdf plugin add poetry
asdf set -u poetry latest
asdf install poetry

if IS_WORK; then
    echo "Installing kubectl with asdf"
    asdf plugin add kubectl
    asdf set -u kubectl latest:1.24
    asdf install kubectl

    echo "Installing teleport with asdf"
    asdf plugin add teleport https://github.com/jorpilo/asdf-teleport.git
    asdf set -u teleport 16.4.9
    asdf install teleport
fi

pythonLatest=$(asdf where python)
if [ $pythonLatest ]; then
    echo "Installing virtualenvwrapper"
    $pythonLatest/bin/pip install --upgrade pip
    $pythonLatest/bin/pip install virtualenvwrapper
fi
