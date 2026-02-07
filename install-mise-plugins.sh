#!/bin/zsh

source $(dirname "$0")/utils.sh

echo "Installing python with mise"
mise use --global python

echo "Installing go with mise"
mise use --global golang

echo "Installing nodejs with mise"
mise use --global nodejs

echo "Installing poetry with mise"
mise use --global poetry

if IS_WORK; then
    echo "Installing kubectl with mise"
    mise --use global kubectl@1.28

    echo "Installing process-compose with mise"
    mise use --global process-compose

    echo "Installing teleport-community with mise"
    mise use --global teleport-community
fi

pythonLatest=$(mise where python)
if [ $pythonLatest ]; then
    echo "Installing virtualenvwrapper"
    $pythonLatest/bin/pip install --upgrade pip
    $pythonLatest/bin/pip install virtualenvwrapper
fi
