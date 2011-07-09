#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[0;32m\]\u\[\e[m\]@\[\e[0;35m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ \[\e[0m\]'

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
# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -A'
alias de='deactivate'
alias pro='cd ~/projects; ls'
alias rebash='source ~/.bashrc'
alias webserver='python -m SimpleHTTPServer 8080'

# Git
alias gs='git status'
alias gc='git commit -a'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gd='git diff'
alias gp='git push'

# Virtualenvwrapper settings
export WORKON_HOME=~/.envs

# Go settings
export GOROOT=$HOME/local/go

export EDITOR='vim'
