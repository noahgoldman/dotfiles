#
# ~/.zshrc
#

include () {
    [[ -f "$1" ]] && source "$1"
}

autoload colors;

for f in ~/.zsh/*.zsh(N); do include "$f"; done
include $HOME/.profile

PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%} %{$fg[blue]%}%~>%{$reset_color%} "
RPS1='%(?..[%?] )$(git_prompt_string)'

setopt correct_all

# Load custom completions
fpath=($HOME/.zsh/completion $fpath)

#
# Binds
#

bindkey -v

# ----------------------------------------------------------------------
# Script to add everything in ~/local to PATH
# ----------------------------------------------------------------------
LOCAL_PATH=$HOME/local
LD_LIBRARY_PATH="/opt/local/lib:/usr/local/lib:/usr/lib"
if [ -d $HOME/local ]; then
    for i in $HOME/local/*; do
        [ -d $i/bin ] && PATH="${i}/bin:${PATH}"
        [ -d $i/sbin ] && PATH="${i}/sbin:${PATH}"
        [ -d $i/include ] && CPATH="${i}/include:${CPATH}"
        [ -d $i/lib ] && LD_LIBRARY_PATH="${i}/lib:${LD_LIBRARY_PATH}"
        [ -d $i/lib/pkgconfig ] && PKG_CONFIG_PATH="${i}/lib/pkgconfig:${PKG_CONFIG_PATH}"
        [ -d $i/share/man ] && MANPATH="${i}/share/man:${MANPATH}"
    done
fi

PATH="$HOME/.bin:$HOME/.cabal/bin:$HOME/local/libmaple/arm/bin:$HOME/local/android/platform-tools:${PATH}"
# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------
alias l='ls'
alias ls='ls --color=auto' # OSX only
alias ll='ls -A'
alias de='deactivate'
alias rezsh='source ~/.zshrc'
alias webserver='python -m SimpleHTTPServer 8080'
alias _='sudo'
alias __='sudo !!'
alias xrec="xmonad --recompile"
alias killspace="for file in *; do mv "$file" `echo $file | tr ' ' '_'` ; done"
alias du-sort="du -h . --human-readable | sort -h"
alias fdupes='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'
alias -g "backlight"="/bin/bash /usr/local/share/backlight"
alias -g "kbd_backlight"="/bin/bash /usr/local/share/kbd_backlight"
alias -g "lessout"="2>&1 | less"
alias -g "json"="python -mjson.tool"
alias -g "sync-music"="rsync -rvhL ~/music"
alias gsync='grive -p ~/gdrive'
alias -g "less"="less -R"
alias gledger="gpg --batch -d -q $LEDGER_FILE | ledger -f - "

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

 #Virtualenvwrapper settings
export WORKON_HOME=~/.envs
include /usr/local/bin/virtualenvwrapper.sh

export EDITOR='vim'
export VISUAL='vim'
export LIB_MAPLE_HOME=$HOME/local/libmaple
export BROWSER='chromium'

# History file setup
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
setopt incappendhistory
setopt hist_ignore_all_dups

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt nohashdirs

autoload -U compinit
compinit
# End of lines added by compinstall

VBOX_USB=usbfs

# Go settings
export GOPATH=$HOME/projects/golang

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
