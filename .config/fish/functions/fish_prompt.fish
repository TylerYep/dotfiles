function fish_prompt
    test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"
    
    set -l git_branch ' ['(git branch 2>/dev/null | sed -n '/\* /s///p')']'
    test -z $git_branch; and set -l git_branch ""

    # Main
    echo -n -s (set_color -o blue)"$USER "
    echo -n (set_color cyan)(prompt_pwd)
    echo -n (set_color green)"$git_branch"
    echo -n (set_color red)' ❯'(set_color yellow)'❯'(set_color green)'❯ '
end
