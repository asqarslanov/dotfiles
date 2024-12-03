set -U fish_greeting
set -gx DOTFILES_DIR $HOME/.local/share/chezmoi
set -gx PATH $PATH $DOTFILES_DIR/bin $HOME/.local/bin $HOME/.cargo/bin
set -gx XDG_DATA_DIRS $XDG_DATA_DIRS $HOME/.nix-profile/share
set -gx EDITOR hx
set -gx LESS '--raw-control-chars --use-color -Dd+r$Du+b$'
set -gx MANROFFOPT '-P -c'

~/.config/tmux/bin/clear-unattached-sessions

if status is-interactive
    # TODO: Check Wallust Presence.

    function fish_user_key_bindings
        fish_default_key_bindings --mode insert
        fish_vi_key_bindings --no-erase insert
    end

    cat ~/.cache/wallust/sequences & sh ~/.cache/wal/tty.sh
    if set -q DISPLAY
        # fortune -s
        # echo
        # fastfetch
    else if [ -z $TMUX ]
        ~/.config/tmux/bin/initialization
        clear
    else if [ $TERM != xterm-256color ]
        fortune -s
        echo
        fastfetch
    end

    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace underscore blink
    set fish_cursor_visual block

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

    # function edit
    #     if set -q DISPLAY
    #         neovide -- $argv
    #     else
    #         hx $argv
    #     end
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

    function yy
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd -- "$cwd"
        end
        command rm -f -- "$tmp"
    end

    alias cz=chezmoi

    alias cp="cp --interactive --recursive --verbose"
    alias ln="ln --interactive --verbose"
    alias mv="mv --interactive --verbose"
    alias mkdir="mkdir --parents --verbose"
    alias rm="rm --interactive=once --verbose"
    alias trash="trash --verbose"

    alias cat="bat"
    alias info="info --vi-keys"
    alias ls="eza --icons --all --header"
    alias neofetch="echo neofetch: aliased to fastfetch; echo; fastfetch"
    alias plz="sudo"

    abbr -a b --function projectdo_build
    abbr -a r --function projectdo_run
    abbr -a t --function projectdo_test
    abbr -a p --function projectdo_tool

    abbr helix hx
    abbr zeditor zed

    abbr :q! exit
    abbr :q exit

    abbr cd.. cd ../

    starship init fish | source

    zoxide init fish | source
end
