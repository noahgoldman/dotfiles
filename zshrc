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

# vi mode
bindkey -v
export KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg[red]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_prompt_string) $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# ----------------------------------------------------------------------
# Script to add everything in ~/local to PATH
# ----------------------------------------------------------------------
LOCAL_PATH=$HOME/local
LD_LIBRARY_PATH="/usr/local/lib:/usr/lib"
if [ -d $HOME/local ]; then
    for i in $HOME/local/*; do
        [ -d $i/bin ] && export PATH="${i}/bin:${PATH}"
        [ -d $i/sbin ] && export PATH="${i}/sbin:${PATH}"
        [ -d $i/include ] && export CPATH="${i}/include:${CPATH}"
        [ -d $i/lib ] && export LD_LIBRARY_PATH="${i}/lib:${LD_LIBRARY_PATH}"
        [ -d $i/lib/pkgconfig ] && export PKG_CONFIG_PATH="${i}/lib/pkgconfig:${PKG_CONFIG_PATH}"
        [ -d $i/share/man ] && export MANPATH="${i}/share/man:${MANPATH}"
    done
fi

export PATH="$HOME/.bin:$HOME/.cabal/bin:$HOME/local/libmaple/arm/bin:$HOME/local/android/platform-tools:${PATH}"
# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------
alias l='ls'
alias ls='ls -G'
alias ll='ls -A'
alias de='deactivate'
alias rezsh='source ~/.zshrc'
alias webserver='python -m SimpleHTTPServer 8080'
alias _='sudo'
alias __='sudo !!'
alias xrec="xmonad --recompile"
alias du-sort="du -h . --human-readable | sort -h"
alias fdupes='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'
alias -g "lessout"="2>&1 | less"
alias -g "json"="python -mjson.tool"
alias -g "less"="less -R"
alias gledger="gpg -d -q $LEDGER_FILE | ledger -f - "
alias clip-json="pbpaste | json | pbcopy"
alias docker-kill-all="docker kill \$(docker ps -q)"
alias yaml2json="ruby -ryaml -rjson -e 'puts JSON.pretty_generate(YAML.load(ARGF))'"
alias k="kubectl"
alias kctx="kubectx"
alias kns="kubens"
alias ccat='pygmentize -f terminal256 -O style=native -g'
alias -g stripcolor="$SED_BIN -r \"s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g\""
alias -g uuid2base64="python -c 'import sys, base64, uuid; print(base64.b64encode(uuid.UUID(sys.stdin.read().rstrip()).bytes))'"

# Disable spelling correction for certain commands
alias go='nocorrect go'

function pro {
	cd ~/projects/$1
    if [ -f ~/projects/$1/.pro ]
        then
            source ~/projects/$1/.pro
    fi
	ls
}

export EDITOR='vim'
export VISUAL='vim'
export BROWSER='chromium'

# History file setup
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
setopt incappendhistory
setopt hist_ignore_all_dups
bindkey -v
bindkey '^R' history-incremental-search-backward

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt nohashdirs

autoload -U compinit
compinit
# End of lines added by compinstall

# Go settings
export GOPATH=$HOME/projects/golang
export PATH="$PATH:$GOPATH/bin"

# For tag (https://github.com/aykamko/tag)
if (( $+commands[tag] )); then
  export TAG_SEARCH_PROG=ag
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias ag=tag
fi

function gitignore() { curl -L -s https://www.gitignore.io/api/$@ ;}
function gitignore-repo {
    repo=$(git rev-parse --show-toplevel)
    mkdir -p $repo/.git/info
    echo "$1" >> $repo/.git/info/exclude
}

# Ripgrep configuration file
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Allow clang to find shared libraries at build time.
export LIBRARY_PATH=$LD_LIBRARY_PATH

# Alias shared library lists on OSX
if [[ $OSX ]]; then
    # export DYLD_LIBRARY_PATH=$LD_LIBRARY_PATH
fi
