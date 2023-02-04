# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/askarbink/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
~/.cache/wal/colors.sh

alias :q=exit
alias :wq=exit
alias :x=exit

PROMPT=$'%F{7}\n%~\n%F{14}>%F{15} '
# antigen bundle zsh-users/zsh-completions

