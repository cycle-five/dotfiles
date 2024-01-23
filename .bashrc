#!/bin/bash
# cycle-five .bashrc
#
# I mostly stole this from the default Ubuntu one, which I find mostly
# has some sane defaults and things I find necessary. Mainly infinite
# (almost) history, aliases, and path configs for stuff I install all
# the time.
#

#
# This section is basically entirely ripped from the ubuntu .bashrc
#

#
# ~/.bashrc
#

[[ $- != *i* ]] && return

greek_alphabet=('α' 'β' 'γ' 'δ' 'ε' 'ζ' 'η' 'θ' 'ι' 'κ' 'λ' 'μ' 'ν' 'ξ' 'ο' 'π' 'ρ' 'σ' 'τ' 'υ' 'φ' 'χ' 'ψ' 'ω')
greek_index=0

cycle_greek_alphabet() {
    echo -n "${greek_alphabet[greek_index]}"

    ((greek_index++))

    # Reset the index if it reaches the end of the array
    if ((greek_index >= ${#greek_alphabet[@]})); then
        greek_index=0
    fi
}

# Function to pick a random Greek letter based on the current time
random_greek_letter() {
    # Get the current time in seconds
    local current_time=$(date +%s)

    # Use the current time to seed the random number generator
    RANDOM=$current_time

    # Compute the index of the Greek letter
    local index=$((RANDOM % ${#greek_alphabet[@]}))

    # Print the selected Greek letter
    echo -n "${greek_alphabet[index]}"
}




colors() {
        local fgc bgc vals seq0

        # shellcheck disable=SC2016
        printf "Color escapes are %s\n" '\e[${value};...;${value}m'
        printf "Values 30..37 are \e[33mforeground colors\e[m\n"
        printf "Values 40..47 are \e[43mbackground colors\e[m\n"
        printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

        # foreground colors
        for fgc in {30..37}; do
                # background colors
                for bgc in {40..47}; do
                        fgc=${fgc#37} # white
                        bgc=${bgc#40} # black

                        vals="${fgc:+$fgc;}${bgc}"
                        vals=${vals%%;}

                        seq0="${vals:+\e[${vals}m}"
                        printf "  %-9s" "${seq0:-(default)}"
                        printf " ${seq0}TEXT\e[m"
                        # printf " %sTEXT\e[m" "${seq0}"
                        printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
                        # printf " \e[%s1mBOLD\e[m" "${vals:+${vals+$vals;}}"
                done
                echo; echo
        done
}

# shellcheck source=/dev/null
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
        xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
                PROMPT_COMMAND='echo -ne "\033]0;${USER}\\u5350${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
                ;;
        screen*)
                PROMPT_COMMAND='echo -ne "\033_${USER}\\u5350${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033"'
                ;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval "$(dircolors -b ~/.dir_colors)"
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval "$(dircolors -b /etc/DIR_COLORS)"
                fi
        fi

        if [[ ${EUID} == 0 ]] ; then
                PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
        else
                PS1=$'\\[\\033[01;32m\\][\\u\e[33m($(random_greek_letter))\e[m\\h\\[\\033[01;37m\\] \\W\\[\\033[01;32m\\]]\\$\\[\\033[00m\\] '
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
        alias egrep='egrep --colour=auto'
        alias fgrep='fgrep --colour=auto'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1=$'\\u\u5350\\h \\W \\$ '
        else
                PS1=$'\\u\u5350\\h \\w \\$ '
        fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.bash_aliases"
fi

#
# } My stuff
#
export PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin"

# My aliases, I want to use .aliases instead of .bash_aliases because I will
# want to switch to zsh at some point.
if [ -f ~/.aliases ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.aliases"
fi

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTSIZE=1000000000
export HISTFILESIZE=1000000000
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE="$HOME/.bash_eternal_history"
export HISTCONTROL=ignoreboth
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Common user installed bin location
export PATH="$HOME/.local/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
# shellcheck source=/dev/null
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Haskell
# shellcheck source=/dev/null
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env

# old gcc
# export PATH=$PATH:/opt/gcc-arm-none-eabi/bin

# Go
export PATH="${PATH}:/usr/local/go/bin"

# Personal bins, these go last in the file and first in the path
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.bin:${PATH}"

#
# env variables for Twitter API
#
export CLIENT_ID="..."
export CLIENT_SECRET="..."
#export APP_BEARER_TOKEN="..."
export API_ID="..."
export API_SECRET="..."

#
# discord apps
#
export DISCORD_TOKEN="..."
export GUILD_ID="..."

# ChatGPT
export OPENAI_KEY="..."

#
# Spotify
#
export SPOTIFY_CLIENT_ID="..."
export SPOTIFY_CLIENT_SECRET="..."

