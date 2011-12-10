#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PS1='\[\e[0;32m\]\u\[\e[m\]@\[\e[0;35m\]\h\[\e[m\] \[\e[0;34m\]\w\[\e[m\]> \[\e[0m\]'

# ----------------------------------------------------------------------
# Script to add everythin in ~/local to PATH
# ----------------------------------------------------------------------
LOCAL_PATH=$HOME/local
LD_LIBRARY_PATH="/opt/local/lib:/usr/local/lib:/usr/lib"
for i in $HOME/local/*; do
    [ -d $i/bin ] && PATH="${i}/bin:${PATH}"
    [ -d $i/sbin ] && PATH="${i}/sbin:${PATH}"
    [ -d $i/include ] && CPATH="${i}/include:${CPATH}"
    [ -d $i/lib ] && LD_LIBRARY_PATH="${i}/lib:${LD_LIBRARY_PATH}"
    [ -d $i/lib/pkgconfig ] && PKG_CONFIG_PATH="${i}/lib/pkgconfig:${PKG_CONFIG_PATH}"
    [ -d $i/share/man ] && MANPATH="${i}/share/man:${MANPATH}"
done

PATH="$HOME/.bin:${PATH}"
# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------
alias l='ls'
alias ls='ls --color=auto'
alias ll='ls -A'
alias de='deactivate'
alias webserver='python -m SimpleHTTPServer 8080'
alias rebash='source ~/.bashrc'

function p {
	cd ~/projects/$1
    [ -f ~/projects/$1/.p ] && source ~/projects/$1/.p
}

# Git
alias gs='git status'

# Virtualenvwrapper settings
export WORKON_HOME=~/.envs
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# Go settings
export GOROOT=$HOME/local/go

export EDITOR='vim'
