set -U fish_greeting

if [ ! -d ~/.cache/wal ]
    wal -f dracula
    chmod +x ~/.cache/wal/colors.sh
    chmod +x ~/.cache/wal/colors-tty.sh
end

~/.config/tmux/scripts/clear-unattached-sessions

if status is-interactive
    if [ -z $TMUX ]
        ~/.cache/wal/colors-tty.sh
        ~/.config/tmux/scripts/initialization
        clear
    else if [ $TERM != xterm-256color ]
        fortune -s
        echo
        fastfetch
    end

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

    function lg
        set -x LAZYGIT_NEW_DIR_FILE ~/.lazygit/newdir

        lazygit $argv

        if [ -f $LAZYGIT_NEW_DIR_FILE ]
            cd (cat $LAZYGIT_NEW_DIR_FILE)
            rm -f $LAZYGIT_NEW_DIR_FILE >/dev/null
        end

        return 0
    end

    alias 'cp'='cp --interactive --verbose'
    alias 'ln'='ln --interactive --verbose'
    alias 'mv'='mv --interactive --verbose'
    alias 'rm'='echo Use either `trash` or `command rm` instead.; false'
    alias 'remove'='command rm --interactive=once --verbose'
    alias 'trash'='trash --verbose'

    alias 'info'='info --vi-keys'
    alias 'ls'='exa --classify --icons --all --header'
    alias 'neofetch'='echo neofetch: aliased to fastfetch; echo; fastfetch'
    alias 'plz'='sudo'

    # TODO: Tmux Actions
    abbr ':q!' exit
    abbr ':q' exit
end
