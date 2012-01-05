#
# ~/.zshrc
#

autoload -U compinit
autoload colors; colors;

PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%} %{$fg[blue]%}%~>%{$reset_color%} "

setopt correct_all

#
# Binds
#

bindkey -v

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
alias rezsh='source ~/.zshrc'
alias webserver='python -m SimpleHTTPServer 8080'
alias _='sudo'
alias __='sudo !!'
alias xrec="xmonad --recompile"

function pro {
	cd ~/projects/$1
	ls
	source ~/projects/$1/.pro
}

# Git
alias gs='git status'
alias gc='git commit -a'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gd='git diff'
alias gp='git push'

# Virtualenvwrapper settings
export WORKON_HOME=~/.envs

if [ -f /usr/local/bin/virtualenvwrapper.sh ] 
    then 
        source /usr/local/bin/virtualenvwrapper.sh 
fi

# Go settings
export GOROOT=$HOME/local/go

export EDITOR='vim'
# The following lines were added by compinstall

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
compinit
# End of lines added by compinstall
