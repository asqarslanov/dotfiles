if [[ -z $TMUX ]]; then
    (cat ~/.cache/wal/sequences &)
    ~/.cache/wal/colors-tty.sh
    ~/.config/tmux/scripts/initialization
    clear
else
    if [[ $TERM != xterm-256color ]]; then
        echo "\n~ $(fortune -s) ~\n"
        echo && fastfetch
    fi
fi

~/.config/tmux/scripts/clear-unattached-sessions

if [ ! -d ~/.cache/wal ]; then
    wal -f dracula
    chmod +x ~/.cache/wal/colors.sh
    chmod +x ~/.cache/wal/colors-tty.sh
fi

ZINIT_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git
[ ! -d $ZINIT_HOME ] && mkdir -p $(dirname $ZINIT_HOME)
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME
source ${ZINIT_HOME}/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode

# bindkey '^h' backward-char
# bindkey '^j' down-line-or-history
# bindkey '^k' up-line-or-history
# bindkey '^l' forward-char

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


lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit $@

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd $(cat $LAZYGIT_NEW_DIR_FILE)
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

alias ':q!'=exit
alias 'command rm'='command rm --interactive=once --preserve-root --verbose'
alias :q=exit
alias cp='cp --interactive --verbose'
alias info='info --vi-keys'
alias ln='ln --interactive --verbose'
alias ls='exa --classify --icons --all --header'
alias mv='mv --interactive --verbose'
alias neofetch='echo "neofetch: aliased to fastfetch\n"; fastfetch'
alias plz=sudo
alias rm='echo Use either \`trash\` or \`command rm\` instead.; false'
alias trash='trash --interactive --verbose'
