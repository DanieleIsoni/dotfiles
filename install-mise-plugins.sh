#!/bin/zsh

echo "Installing tools with mise"
mise install

pythonLatest=$(mise where python)
if [ $pythonLatest ]; then
    echo "Installing virtualenvwrapper"
    $pythonLatest/bin/pip install --upgrade pip
    $pythonLatest/bin/pip install virtualenvwrapper
fi
