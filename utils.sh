#!/bin/zsh

IS_WORK() { [ "${WORK:-0}" != "0" ]; }
is_linux() { [ $(uname -s) = "Linux" ]; }
is_macos() { [ $(uname -s) = "Darwin" ]; }
