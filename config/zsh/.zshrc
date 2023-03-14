if [ -z $TMUX ] && [[ $TERM == *$TERMINAL* ]]; then
    (cat ~/.cache/wal/sequences &)
    source ~/.cache/wal/colors-tty.sh
    ~/.cache/wal/colors.sh

    tmux a -t tmux || tmux new -s tmux
fi

if [ $TMUX ]; then
    echo && neofetch
fi

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

lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit $@

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd $(cat $LAZYGIT_NEW_DIR_FILE)
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

alias :q=exit
alias :wq=exit
alias :x=exit
alias info='info --vi-keys'
