# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# setopt INC_APPEND_HISTORY SHARE_HISTORY
# Some options to share history between zsh shells immediately
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
# Auto correct
setopt CORRECT
setopt EXTENDED_HISTORY
# setopt MENUCOMPLETE
unsetopt BG_NICE
setopt NO_BEEP
setopt AUTO_CD
setopt nonomatch

# Color and autocompletion junk and vcs_info for git
precmd() {
    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        PROMPT='%{$fg[red]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg[yellow]%}%~%{$fg[magenta]%} ${vcs_info_msg_0_}%f %# %{$reset_color%}% '
    else
        PROMPT='%{$fg[red]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% '
    fi
}

autoload -U compinit promptinit
compinit
promptinit

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
autoload -U colors && colors
# Enable substitution in the prompt.
setopt prompt_subst

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

#### Variables ####
# The only right choice for EDITOR
export EDITOR='/usr/bin/vi'
# Still use emacs bindings with editor set to vi
bindkey -e

# Fix broken ssl lib path bullshit
# export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH

# Bind ctrl u to get the same behavior as in bash
bindkey \^U backward-kill-line
export GIT_EDITOR='/usr/bin/vi'
export PATH=$HOME/bin:/usr/local/sbin:$PATH
export HISTFILE=$HOME/.zhistory
export HISTSIZE=100000
export SAVEHIST=100000
export PAGER='less'
umask 077

#### Aliases ####
alias ls='ls -GFh'
alias grep='grep --color=auto'
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
alias h='history -i 1'
alias watch='watch -c'
alias trm='rm ~/Downloads/*.torrent'
alias techbooks='cd ~/Documents/ebooks/techbooks'

# mikro 
alias mikro='mosh rsf@mikro'
alias rtor='mosh rsf@rtor'
alias bees='ssh rsf@bees'
alias freebsd-vm='ssh rsf@freebsd-vm'

# Some autofs dir aliases for mikro
alias anime='cd /net/mikro/mnt/data/anime'
alias data='cd /net/mikro/mnt/data'
alias scratch='cd /net/mikro/scratch'
alias tv='cd /net/mikro/mnt/data/tv'
alias movies='cd /net/mikro/mnt/data/movies'
alias music='cd /net/mikro/mnt/data/music'
alias backup='cd /net/mikro/mnt/data/backup'
alias flair='cd /net/mikro/misc/game_vids/quake/matches/that_flair_guy'
alias misc='cd /net/mikro/misc'

# kub cluster
alias kub='ssh ubuntu@kubadmin'
alias kub1='ssh ubuntu@kub1'
alias kub2='ssh ubuntu@kub2'
alias kub3='ssh ubuntu@kub3'
alias kub4='ssh ubuntu@kub4'

# non-cluster pis
alias pi='ssh ubuntu@pi'
alias pi2='ssh rsf@pi2'

# remote
alias rpi='ssh -p 2222 ubuntu@208.110.238.68'

alias rpi2='ssh -p 2223 rsf@73.228.189.253'

alias whatbox='mosh rsf@mercury.whatbox.ca'

# ubnt
alias ubnt='ssh ubnt@192.168.0.1'
alias unifi=' ssh rfitzgerald@192.168.0.237'

# open vscode by typing code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# Some handy docker functions
function clean_containers() {
  docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm
}
function clean_volumes() {
  docker volume rm $(docker volume ls -qf dangling=true)
}
function clean_images() {
  docker rmi $(docker images -f "dangling=true" -q)
}

# AWS programatic CLI stub
function aws() {
  export AWS_ACCESS_KEY_ID="XXXXXXXXXX"
  export AWS_SECRET_ACCESS_KEY="XXXXXXXXXXXXXXXXXXXX"
  unset  AWS_SESSION_TOKEN
}

#### Colored man pages ####
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# export PATH="/usr/local/opt/icu4c/bin:$PATH"
# export PATH="/usr/local/opt/icu4c/sbin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# kubectl
source <(kubectl completion zsh)
alias ctx='kubectl config current-context'
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/p10k/.p10k.zsh.
[[ ! -f ~/dotfiles/p10k/.p10k.zsh ]] || source ~/dotfiles/p10k/.p10k.zsh
