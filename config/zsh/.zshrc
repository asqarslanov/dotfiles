eval "$(starship init zsh)"

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

if [ ! -d ~/.cache/wal ]; then
    wal -f base16-dracula
    chmod +x ~/.cache/wal/colors.sh
fi
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
~/.cache/wal/colors.sh

alias :q=exit
alias :wq=exit
alias :x=exit
alias info='info --vi-keys'

if [ -z $TMUX ]; then
    tmux a -t tmux ||
    tmux new -s tmux
fi
