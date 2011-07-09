#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\u@\h \w\$ '

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

# Aliases
alias ls='ls --color=auto'
alias ll='ls -A'
alias de='deactivate'
alias pro='cd ~/projects'
alias rebash='source ~/.bashrc'

# Virtualenvwrapper settings
export WORKON_HOME=~/.envs

# Go settings
export GOROOT=$HOME/local/go

export EDITOR='vim'
