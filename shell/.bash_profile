#!/bin/sh

export GOPATH="$HOME/.local/bin/go"
export PATH="$HOME/.scripts:$GOPATH/bin:$PATH"
export EDITOR=vim

[ ! -d $GOPATH ] && mkdir -p $GOPATH
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
