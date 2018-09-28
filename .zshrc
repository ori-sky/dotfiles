# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/david/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=50000
setopt appendhistory extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# prompt
fpath=( "$HOME/.zprompts" $fpath )
autoload -Uz promptinit
promptinit
prompt shk
# end of prompt
