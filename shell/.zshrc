# Use powerline
USE_POWERLINE="true"

# enable colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# enable some aliases
source ~/.aliases

# enable vim mode
bindkey -v

# pfetch
if [ -e /bin/pfetch ] ; then
    PF_INFO="ascii title os kernel uptime wm shell memory" PF_COL2=2 pfetch
fi

# start the starship prompt
eval "$(starship init zsh)"

