#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] \
    && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
    xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
	;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
	;;
esac

use_color=true
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] \
    && use_color=true

if ${use_color}
then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null
    then
	if [[ -f ~/.dir_colors ]]
        then
	    eval $(dircolors -b ~/.dir_colors)
	elif [[ -f /etc/DIR_COLORS ]]
        then
	    eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    blue="\e[0;94m"
    white="\e[0;97m"
    reset="\e[0m"

    PS1="${blue}\u@\h ${white}\w ${blue}\$ ${reset}"
else
    PS1='\u@\h \w \$ '
fi

unset use_color safe_term match_lhs sh blue white reset

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
[ -e /bin/pfetch ] \
    && PF_INFO="ascii title os kernel uptime wm shell memory" PF_COL2=2 pfetch

