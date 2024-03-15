if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set the locale so all the fonts work right
set -x LC_ALL C.UTF-8
set -x LANG C.UTF-8

# CrackTunes random APIs
set -x VIRUSTOTAL_API_KEY ...

# Set the path for fnm, the node version manager
set -x PATH /home/lothrop/.local/share/fnm $PATH

# set -x PATH /usr/local/cuda/bin $PATH
# set -x LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH

# Set the path for cargo, the rust package manager

# Use Nerdfonts so things look nice
set -g theme_nerd_fonts yes

#
# My aliases
#
# tmux
alias tma='tmux a'
alias tmat='tmux a -t'
alias tml='tmux ls'
alias tmn='tmux new -s'
# vim
alias vim='nvim'
alias v='vim'
# apt
alias sai='sudo apt install'
alias saiy='sudo apt install -y'
alias ssi='sudo snap install'
# ls
alias ls='ls -alF --color=auto'
# python
alias ve='python3 -m venv ./venv'
# alias va='source ./venv/bin/activate'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/lothrop/anaconda3/bin/conda
    eval /home/lothrop/anaconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/home/lothrop/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/lothrop/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /home/lothrop/anaconda3/bin $PATH
    end
end
# <<< conda initialize <<<
