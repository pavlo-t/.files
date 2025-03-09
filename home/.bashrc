#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	red="\[\033[01;31m\]"
	green="\[\033[01;32m\]"
	yellow="\[\033[01;33m\]"
	blue="\[\033[01;34m\]"
	purple="\[\033[00;35m\]"
	teal="\[\033[00;36m\]"
	reset="\[\033[00m\]"
	white="\[\033[00;01m\]"
	if [ $EUID == 0 ]; then
		userColor=$red
	else
		userColor=$green
	fi
	II="${userColor}|"

	exitCode()
	{
		st=$?
		if [[ $st == 0 ]]; then
			statusColor="32m"
		else
			statusColor="31m"
		fi

		printf "\033[00;%s%03d\033[00m" $statusColor $st
	}

	info="\n${II}\$(exitCode)${II}${purple}jobs:\j${II}${teal}\D{%F %T %z}${II}${userColor}\u${white}@${yellow}\H${II}${blue}\w"
	prompt="${II}${userColor}\!|\#${II}${userColor}\\$"

		PS1="${info}${reset}\n${prompt} ${reset}"
else
	PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --group-directories-first --time-style="+%F %T %z" --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias l='ls -FlashN'
	alias ll='ls -FlasiQ'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

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

#if [ -f ~/.ascii ]; then
#    . ~/.ascii
#fi

uptime
#printf "\033[00;01mlast -n 10 -w --time-format=iso\033[00m\n"
#last -n10 -w --time-format=iso
#printf "\033[00;01mdf -hTa\t\ttop -S\t\tnetstat\t\thistory\033[00m"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# Rust:
PATH=$PATH:${HOME}/.cargo/bin

# NAS stuff:
export HELM_STARTERS="${HOME}/.local/share/helm/starters"

# Node Version Manager
[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source /usr/share/nvm/init-nvm.sh

# k9s
export EDITOR=vim
