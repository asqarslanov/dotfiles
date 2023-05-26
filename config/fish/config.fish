set -U fish_greeting

# function fish_prompt
#     echo
#     echo \
#         (set_color blue)(prompt_pwd) \
#         (set_color normal)took (set_color yellow)(echo $CMD_DURATION)ms
#     set_color green
#     echo '$ '
#     # printf '\n%s%s %s%s%s\n$ ' \
#     #     (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
# end

if status is-interactive
    alias 'cp'='cp --interactive --verbose'
    alias 'ln'='ln --interactive --verbose'
    alias 'mv'='mv --interactive --verbose'
    alias 'rm'='echo Use either `trash` or `command rm` instead.; false'
    alias 'remove'='command rm --interactive=once --verbose'
    alias 'trash'='trash --verbose'

    alias ':q!'='exit'
    alias ':q'='exit'
    alias 'info'='info --vi-keys'
    alias 'ls'='exa --classify --icons --all --header'
    alias 'neofetch'='echo neofetch: aliased to fastfetch; echo; fastfetch'
    alias 'plz'='sudo'
end
