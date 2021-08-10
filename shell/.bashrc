# .bashrc by Alexander Olzem

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] \
    && . /usr/share/bash-completion/bash_completion

__ps1() {
    #colors
    local x='\e[0m'     # reset
    local r='\e[0;91m'  # red
    local g='\e[0;92m'  # green
    local b='\e[0;94m'  # blue
    local w='\e[0;97m'  # white
    
    # check if user is root
    local U
    [ $(id -u) -eq 0 ] && U='#'; b=$r || U='$'

    local gitinfo
    # Check if current dir is a git repo
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ ! -z "$branch" ]; then
        # Get state of local repo
        case "$(git status --ahead-behind 2>/dev/null | awk 'FNR==2{print $4}')" in
            behind) gitinfo='-' ;;
            ahead) gitinfo='+' ;;
            *) gitinfo='' ;;
        esac
    
        # Check for uncommited changes
        [ ! -z "$(git diff 2>/dev/null)" ] && gitinfo="$gitinfo*"
       
        # Display Branch indicating red when on master/main or else green
        case "$branch" in
            master|main)
                [ -z "$gitinfo" ] && gitinfo="$r$branch" \
                    || gitinfo="$r$branch $gitinfo" ;;
            *)
                [ -z "$gitinfo" ] && gitinfo="$g$branch" \
                    || gitinfo="$g$branch $gitinfo" ;;
        esac
        gitinfo="$b($gitinfo$b) "
    fi

    # Final arrangement for prompt
    PS1="$b\u@\h $w\w $gitinfo$b$U $x"
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

