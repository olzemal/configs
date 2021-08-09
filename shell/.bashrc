# .bashrc by Alexander Olzem

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] \
    && . /usr/share/bash-completion/bash_completion

__ps1() {
    #colors
    local x='\e[0m'     # reset
    local r='\e[0;91m'  # red
    local g='\e[0;92m'  # green
    local b='\e[0;36m'  # blue
    local w='\e[0;97m'  # white

    # Check if current dir is a git repo
    if [ -d .git ]; then
        # Get state of local repo
        local s=$(git status --ahead-behind 2>/dev/null | awk 'FNR==2{print $4}')
        case $s in
            up) s="=" ;;
            behind) s="-" ;;
            ahead) s="+" ;;
            *) s= "" ;;
        esac
    
        # Check for uncommited changes
        local d=$(git diff 2>/dev/null)
        [ ! -z "$d" ] && d='*'
        
        # Display current branch
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [ -z "$branch" ]; then
            PS1="$b\u@\h $w\w $b\$ $x"
        else
            if [ "$branch" = "master" ] || [ "$branch" = "main" ]; then
                PS1="$b\u@\h $w\w $b($r$branch $s$d$b) \$ $x"
            else
                PS1="$b\u@\h $w\w $b($g$branch $s$d$b) \$ $x"
            fi
        fi
    else
        PS1="$b\u@\h $w\w $b\$ $x"
    fi
}

PROMPT_COMMAND="__ps1"

xhost +local:root > /dev/null 2>&1

complete -cf sudo # Complete commands after sudo

# Options
shopt -s checkwinsize
shopt -s expand_aliases     # Aliases in scripts 
shopt -s autocd             # '..' -> 'cd ..'
shopt -s histappend         # Enable history appending instead of overwriting.

# VI mode with ctrl-l
set -o vi                   
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# enable some aliases
[ -e ~/.aliases ] && source ~/.aliases

# pfetch
[ ! -z "$(command -v pfetch)" ] \
    && PF_INFO="ascii title os kernel uptime wm shell memory" pfetch

