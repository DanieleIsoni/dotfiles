# kickstart.nvim

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:

* Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
* [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
* Clipboard tool (xclip/xsel/win32yank or other depending on platform)
* A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  * if you have it set `vim.g.have_nerd_font` in `init.lua` to true
* Language Setup:
  * If you want to write Typescript, you need `npm`
  * If you want to write Golang, you will need `go`
  * etc.

> **NOTE**
> See [Install Recipes](#install-recipes) for additional Windows and Linux
> specific notes and quick install snippets
