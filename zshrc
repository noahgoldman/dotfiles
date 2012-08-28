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

PATH="$HOME/.bin:$HOME/.cabal/bin:$HOME/local/libmaple/arm/bin:${PATH}"
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
alias dltorrent='scp -r "torrent@adam.phaaze.com:*" .'
alias -g "backlight"="/bin/bash /usr/local/share/backlight"
alias -g "kbd_backlight"="/bin/bash /usr/local/share/kbd_backlight"

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
export LIB_MAPLE_HOME=$HOME/local/libmaple
# The following lines were added by compinstall

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
compinit
# End of lines added by compinstall

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
