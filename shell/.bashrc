#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] \
    && . /usr/share/bash-completion/bash_completion

__ps1() {
    local x='\e[0m'

    local r='\e[0;91m'
    local g='\e[0;92m'
    local b='\e[0;36m'
    local w='\e[0;97m'

    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    
    if [ -z "$branch" ]; then
        PS1="$b\u@\h $w\w $b\$ $x"
    else
        if [ "$branch" = "master" ] || [ "$branch" = "main" ]; then
            PS1="$b\u@\h $w\w $b($r$branch$b) \$ $x"
        else
            PS1="$b\u@\h $w\w $b($g$branch$b) \$ $x"
        fi
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

# VI man pages
man() { view <($(which man) "$1"); }

# enable some aliases
[ -e ~/.aliases ] && source ~/.aliases

# pfetch
[ -e /bin/pfetch ] \
    && PF_INFO="ascii title os kernel uptime wm shell memory" PF_COL2=2 pfetch

