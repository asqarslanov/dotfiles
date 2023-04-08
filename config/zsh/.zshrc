if [[ $TERM = linux ]]; then
    tmux

else if [[ $TERM = xterm-kitty ]]
    (cat ~/.cache/wal/sequences &)

    if [[ $XDG_CURRENT_DESKTOP = Hyprland ]]; then
        echo "\n~ $(hyprctl splash) ~\n"
    fi
    echo && fastfetch

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
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

bindkey '^h' backward-char
bindkey '^j' down-line-or-history
bindkey '^k' up-line-or-history
bindkey '^l' forward-char

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
    wal -f dracula
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
alias info='info --vi-keys'
alias neofetch='echo "\n~ It’s Fastfetch, not Neofetch ~\n" && fastfetch'
alias please=sudo
