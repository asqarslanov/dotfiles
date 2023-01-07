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

alias nv=neovide --multigrid
alias google-chrome-stable="flatpak run com.google.Chrome"
alias telegram-desktop="flatpak run org.telegram.desktop"

PROMPT=$'%F{7}\n%~\n%F{14}>%F{15} '
# antigen bundle zsh-users/zsh-completions

