#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PS1='\[\e[0;32m\]\u\[\e[m\]@\[\e[0;35m\]\h\[\e[m\] \e[0;34m\]\w\[\e[m\]> \[\e[0m\]'
PS1="\[\033[G\]$PS1"

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
alias activate='source env/bin/activate'
alias de='deactivate'
alias webserver='python -m SimpleHTTPServer 8080'
alias rebash='source ~/.bashrc'
alias vibash='vim ~/.bashrc'
alias json='python -mjson.tool'
alias xrec='xmonad --recompile'
alias fics='xboard -ics -icshost freechess.org'

function pro {
	cd ~/projects/$1
    if [ -f ~/projects/$1/.pro ] 
        then
            source ~/projects/$1/.pro
    fi
    ls
}

# Git
alias gs='git status'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# Virtualenvwrapper settings
export WORKON_HOME=~/.envs
if [ -f /usr/local/bin/virtualenvwrapper.sh ] 
    then 
        source /usr/local/bin/virtualenvwrapper.sh 
fi

# Go settings
export GOROOT=$HOME/local/go

export EDITOR='vim'
