# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
# setopt HASH_CMDS		# turns on hashing
#
setopt MENUCOMPLETE
setopt ALL_EXPORT

setopt AUTO_CD
setopt PRINT_EXIT_VALUE
setopt HIST_IGNORE_ALL_DUPS

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

source ~/PROJECTS/zsh-git-prompt/zshrc.sh
source ~/PROJECTS/cfengine/masterfiles/files/scripts/git-helpers.source

#
# Environment variables
#  
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:~/bin

EDITOR=emacsclient
BLOCKSIZE=K
PAGER=less
#TERM=rxvt

CVSROOT=:pserver:mra@cvs.tess.elex.be:/var/cvsit

TZ="Europe/Sofia"
HISTFILE=$HOME/.zhistory
HISTSIZE=1500
SAVEHIST=1500
HOSTNAME="`hostname`"
#    autoload colors zsh/terminfo
#    if [[ "$terminfo[colors]" -ge 8 ]]; then
#   colors
#    fi
#    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
#   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
#   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
#   (( count = $count + 1 ))
#    done
#    PR_NO_COLOR="%{$terminfo[sgr0]%}"
#PS1="[$PR_BLUE%n$PR_WHITE@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
#RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
#LANGUAGE=

autoload -U colors && colors

#PROMPT="%n:%{$fg[yellow]%}(%~)%{$reset_color%}> "
PROMPT='%n:%{$fg[yellow]%}(%~)%b$(git_super_status) %# '
RPROMPT=" <%{$bg[white]%}%{$fg[black]%}[%h][%T]%{$reset_color%}]"

LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C

unsetopt ALL_EXPORT
# # --------------------------------------------------------------------
# # aliases
# # --------------------------------------------------------------------

alias man='LC_ALL=C LANG=C man'
alias ls='ls -G '

# set ls colors
export LS_COLORS='di=01;93:*.sh=01;35'

# color grep
export GREP_COLORS=32
alias grep='grep --color -E'

# various useful aliases
alias h='history'
alias c='clear'
alias ssh='ssh -2'
alias vim='vim -i NONE'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ll='ls -l'
alias tagold='cvs rtag -F -r STABLE OLD_STABLE_$(date +%Y%m%d)'
alias e='emacsclient'

autoload -Uz compinit
compinit
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

bindkey '^a' beginning-of-line
bindkey '^d' delete-char
bindkey '^e' end-of-line
bindkey '^[[5~' beginning-of-history
bindkey '^[[6~' end-of-history

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps -A -o pid,user,command'
zstyle ':completion:*:processes-names' command 'ps axho command' 

# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show
