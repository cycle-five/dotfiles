# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
# My custom aliases
source "$HOME/.aliases"

# Anaconda (Python)
export PATH=/usr/local/anaconda3/bin:$PATH
export PATH=/opt/homebrew/anaconda3/bin:$PATH
export PATH="$HOME/go/bin:$PATH"

# For gpt signing git commits
export GPG_TTY=$(tty)

source "$HOME/.cargo/env"

autoload -Uz vcs_info
precmd() { vcs_info }

# Define an array containing the Greek alphabet
greek_alphabet=('α' 'β' 'γ' 'δ' 'ε' 'ζ' 'η' 'θ' 'ι' 'κ' 'λ' 'μ' 'ν' 'ξ' 'ο' 'π' 'ρ' 'σ' 'τ' 'υ' 'φ' 'χ' 'ψ' 'ω')

# Initialize an index variable
greek_index=0

# Function to cycle through the Greek alphabet
function cycle_greek_alphabet() {
    # Print the current Greek letter
    ret="${greek_alphabet[$greek_index]}"

    # Increment the index
    ((greek_index++))

    # Reset the index if it reaches the end of the array
    if ((greek_index >= ${#greek_alphabet[@]})); then
        greek_index=0
    fi

    ret
}

# Update your prompt command to call this function
# For example:
# PROMPT='$(cycle_greek_alphabet) '

setopt PROMPT_SUBST

# export PROMPT='%n%F{green}%*%f %@{purple}%m%f %1~{red}${vcs_info_msg_0_}% '
# export PS1='%F{green}%n%f%F{white}\U5350%f%F{blue}%m%f %F{blue}%1~%f '
# export PS1=$'%F{green}%n%f%F{white}\u5350%f%F{blue}%m%f %F{blue}%1~%f '
export PS1='%F{green}%n%f%F{white}$(cycle_greek_alphabet)%f%F{blue}%m%f %F{blue}%1~%f '
#if [[ ${EUID} == 0 ]] ; then
#	PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
#else
#	PS1=$'\\[\\033[01;32m\\][\\u\u5350\\h\\[\\033[01;37m\\] \\W\\[\\033[01;32m\\]]\\$\\[\\033[00m\\] '
#fi

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
export OPENAI_API_KEY="..."

#
# Spotify
#
export SPOTIFY_CLIENT_ID="..."
export SPOTIFY_CLIENT_SECRET="..."

# old gcc
# export PATH=$PATH:/opt/gcc-arm-none-eabi/bin

# Go
export PATH="${PATH}:/usr/local/go/bin"

# Personal bins, these go last in the file and first in the path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
