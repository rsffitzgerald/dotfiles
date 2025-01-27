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

autoload -U compinit promptinit
compinit
promptinit

#### Variables ####
# The only right choice for EDITOR
export EDITOR='/usr/bin/vi'
# Still use emacs bindings with editor set to vi
bindkey -e

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
#alias ls='ls -GFh'
alias ls='ls -Fh --color=auto'
alias grep='grep --color=auto'
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
alias h='history -i 1'
alias unrar='unrar e *.rar'
alias watch='watch -c'
alias trm='rm ~/Downloads/*.torrent'
alias techbooks='cd ~/Documents/ebooks/techbooks'

# project aliases
alias rsf-server='cd ~/src/ansible/rsf-server'

# mikro 
alias mikro='ssh rsf@mikro'
alias mmikro='mosh rsf@mikro'

# virsh connection 
export LIBVIRT_DEFAULT_URI=qemu+ssh://mikro/system

# Some autofs dir aliases for mikro
alias anime='cd /net/mikro/mnt/data/anime'
alias data='cd /net/mikro/mnt/data'
alias scratch='cd /net/mikro/scratch'
alias tv='cd /net/mikro/mnt/data/tv'
alias movies='cd /net/mikro/mnt/data/movies'
alias music='cd /net/mikro/mnt/data/music'
alias backup='cd /net/mikro/mnt/data/misc_backup'
alias flair='cd /net/mikro/misc/game_vids/quake/matches/that_flair_guy'
alias misc='cd /net/mikro/misc'


# non-cluster pis
alias pi='ssh ubuntu@pi'
alias cherry='ssh rsf@cherry'

# remote
alias rpi='ssh -p 2222 ubuntu@208.110.226.200'
alias whatbox='mosh rsf@galileo.whatbox.ca'

# ubnt
alias ubnt='ssh ubnt@192.168.0.1'
alias unifi='ssh rfitzgerald@192.168.0.194'

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

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# kubectl
source <(kubectl completion zsh)
alias ctx='kubectl config current-context'

# Source p10k based on OS type
if [ $(uname) = "Darwin" ]; then
    source "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme"
elif [ "$(uname)" = "Linux" ] || [ "$(uname)" = "FreeBSD" ]; then
    source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
else
    echo "Unsupported operating system: $OSTYPE"
fi

# source ~/powerlevel10k/powerlevel10k.zsh-theme
# source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/p10k/.p10k.zsh.
[[ ! -f ~/dotfiles/p10k/.p10k.zsh ]] || source ~/dotfiles/p10k/.p10k.zsh
