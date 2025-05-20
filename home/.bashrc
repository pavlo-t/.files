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
HISTSIZE=10000
HISTFILESIZE=10000
HISTTIMEFORMAT='%FT%T%z '

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
	red="\[\033[1;31m\]"
	green="\[\033[1;32m\]"
	yellow="\[\033[1;33m\]"
	blue="\[\033[1;34m\]"
	purple="\[\033[0;35m\]"
	teal="\[\033[0;36m\]"
	white="\[\033[0;37m\]"
	reset="\[\033[0m\]"

	red_raw="\033[0;31m"
	green_raw="\033[0;32m"
	white_b_raw="\033[1;37m"
	reset_raw="\033[0m"

	if [ $EUID == 0 ]; then
		user_color=$red
	else
		user_color=$green
	fi

	print_exit_code() {
		local status=$?
		local status_color
		if [[ $status == 0 ]]; then
			status_color=${green_raw}
		else
			status_color=${red_raw}
		fi

		echo -en "$status_color$(printf "%03d" $status)$reset_raw"
	}

	print_git_branch() {
		local branch=$(git branch --show-current 2>/dev/null)
		if [[ -n $branch ]]; then
			echo -en " $white_b_raw$branch"
			if ! git diff --quiet 2>/dev/null || [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
				echo -en "$red_raw*"
			elif ! git diff --cached --quiet 2>/dev/null; then
				echo -en "$green_raw*"
			fi
			echo -en $reset_raw
		fi
	}

	PS1="\n"
	PS1+='$(print_exit_code)'
	PS1+=" ${teal}\D{%FT%T%z}"
	PS1+='`if [ -n "$(jobs -p)" ]; then echo " '$purple'jobs:\j"; fi`'
	PS1+=" ${blue}\w${reset}"
	PS1+='$(print_git_branch)'
	PS1+=$reset"\n"
	PS1+="${user_color}\u${white}@${yellow}\H${user_color}\\$"
	PS1+=$reset' '
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

# vi mode
set -o vi
alias evcxr='evcxr --edit-mode vi'
