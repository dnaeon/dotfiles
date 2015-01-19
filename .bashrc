# ~/.bashrc - partially based on mitsuhiko's dotfiles:
# https://github.com/mitsuhiko/dotfiles

# Make sure to install vcprompt as well:
# https://bitbucket.org/mitsuhiko/vcprompt

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export EDITOR=emacsclient
export GIT_EDITOR=emacsclient

MNIKOLOVS_DEFAULT_COLOR="[00m"
MNIKOLOVS_GRAY_COLOR="[37m"
MNIKOLOVS_PINK_COLOR="[35m"
MNIKOLOVS_GREEN_COLOR="[32m"
MNIKOLOVS_ORANGE_COLOR="[33m"
MNIKOLOVS_RED_COLOR="[31m"
if [ `id -u` == '0' ]; then
  MNIKOLOVS_USER_COLOR=$MNIKOLOVS_RED_COLOR
else
  MNIKOLOVS_USER_COLOR=$MNIKOLOVS_PINK_COLOR
fi

MNIKOLOVS_VC_PROMPT=$' on \033[34m%n\033[00m:\033[00m%[unknown]b\033[32m'
MNIKOLOVS_VC_PROMPT_EX="$MNIKOLOVS_VC_PROMPT%m%u"

mnikolovs_vcprompt() {
  path=`pwd`
  prompt="$MNIKOLOVS_VC_PROMPT"
  vcprompt -f "$prompt"
}

mnikolovs_lastcommandfailed() {
  code=$?
  if [ $code != 0 ]; then
    echo -n $'\033[37m exited \033[35m'
    echo -n $code
    echo -n $'\033[37m'
  fi
}

mnikolovs_backgroundjobs() {
  jobs|python -c 'if 1:
    import sys
    items = ["\033[36m%s\033[37m" % x.split()[2]
             for x in sys.stdin.read().splitlines()]
    if items:
      if len(items) > 2:
        string = "%s, and %s" % (", ".join(items[:-1]), items[-1])
      else:
        string = ", ".join(items)
      print("\033[37m running %s" % string)
  '
}

mnikolovs_virtualenv() {
  if [ x$VIRTUAL_ENV != x ]; then
    if [[ $VIRTUAL_ENV == *.virtualenvs/* ]]; then
      ENV_NAME=`basename "${VIRTUAL_ENV}"`
    else
      folder=`dirname "${VIRTUAL_ENV}"`
      ENV_NAME=`basename "$folder"`
    fi
    echo -n $' \033[37mworkon \033[35m'
    echo -n $ENV_NAME
    echo -n $'\033[00m'
    # Shell title
    echo -n $'\033]0;venv:'
    echo -n $ENV_NAME
    echo -n $'\007'
  fi
}

export MNIKOLOVS_BASEPROMPT='\e]0;\007\n\e${MNIKOLOVS_USER_COLOR}\u \
\e${MNIKOLOVS_GRAY_COLOR}at \e${MNIKOLOVS_ORANGE_COLOR}\h \
\e${MNIKOLOVS_GRAY_COLOR}in \e${MNIKOLOVS_GREEN_COLOR}\w\
`mnikolovs_lastcommandfailed`\
\e${MNIKOLOVS_GRAY_COLOR}`mnikolovs_vcprompt`\
`mnikolovs_backgroundjobs`\
`mnikolovs_virtualenv`\
\e${MNIKOLOVS_DEFAULT_COLOR}'
export PS1="\[\033[G\]${MNIKOLOVS_BASEPROMPT}
$ "

export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
if [ `uname` == "Darwin" ]; then
  export LSCOLORS=ExGxFxDxCxHxHxCbCeEbEb
  export LC_CTYPE=en_US.utf-8
  export LC_ALL=en_US.utf-8
else
  alias ls='ls --color=auto'
fi

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:~/bin
export LESS=FRSX

shopt -s histappend

# don't let virtualenv show prompts by itself
VIRTUAL_ENV_DISABLE_PROMPT=1

# Make sure window sizes update correctly.
shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias ssh='ssh -2'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias e='emacsclient'
