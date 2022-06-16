#! /bin/bash

alias gpbranch='bash $HOME/shell/safe_merge_branch.sh `pwd`'
alias gpmaster='bash $HOME/shell/safe_merge_branch.sh `pwd` master'
alias gcbranch='bash $HOME/shell/safe_co_branch.sh'
alias gcmaster='bash $HOME/shell/safe_co_branch.sh master'
alias mgotidy='go version && make tidy'
alias gotidy='go version && go mod tidy'
alias modinit='go version && go mod init'
alias gt='git'
alias ll='ls -l'
