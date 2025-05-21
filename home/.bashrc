#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL="erasedups:ignorespace"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

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
	red_raw="\033[0;31m"
	green_raw="\033[0;32m"
	white_b_raw="\033[1;37m"
	reset_color_raw="\033[0m"

	red_b="\[\033[1;31m\]"
	green_b="\[\033[1;32m\]"
	yellow_b="\[\033[1;33m\]"
	blue_b="\[\033[1;34m\]"
	purple="\[\033[0;35m\]"
	teal="\[\033[0;36m\]"
	white="\[\033[0;37m\]"
	reset_color="\[\033[0m\]"

	if [ $EUID == 0 ]; then
		user_color=$red_b
	else
		user_color=$green_b
	fi
fi
unset color_prompt force_color_prompt

print_exit_code() {
	local status=$?
	local status_color
	if [[ $status == 0 ]]; then
		status_color=${green_raw}
	else
		status_color=${red_raw}
	fi

	echo -en "$status_color$(printf "%03d" $status)$reset_color_raw"
}

print_jobs='`if [ -n "$(jobs -p)" ]; then echo "'$purple'jobs:\j "; fi`'

print_git_branch() {
	local output branch untracked unstaged staged

	output=$(git status --porcelain --branch 2>/dev/null) || return

	while IFS= read -r line; do
		if [[ "$line" == "##"* ]]; then
			branch=${line#\#\# }
			branch=${branch%%...*}
		elif [[ "$line" == "??"* ]]; then
			untracked=1
		elif [[ "${line:1:1}" != " " ]]; then
			unstaged=1
		elif [[ "${line:0:1}" != " " ]]; then
			staged=1
		fi
	done <<< "$output"

	if [[ -n $branch ]]; then
		echo -en "$white_b_raw$branch"
		if [[ $untracked ]]; then
			echo -en "$red_raw?"
		fi
		if [[ $unstaged ]]; then
			echo -en "$red_raw*"
		fi
		if [[ $staged ]]; then
			echo -en "$green_raw+"
		fi
		echo -en $reset_color_raw
	fi
}

PS1="\n"
PS1+="\$(print_exit_code) ${teal}\D{%FT%T%z} ${print_jobs}${blue_b}\w${reset_color} \$(print_git_branch)\n"
PS1+="${user_color}\u${white}@${yellow_b}\H${user_color}\$$reset_color "

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

# SDKMAN
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# Rust
PATH=$PATH:${HOME}/.cargo/bin

# Node Version Manager
[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source /usr/share/nvm/init-nvm.sh

# k9s
export EDITOR=vim

# vi mode
set -o vi
alias evcxr='evcxr --edit-mode vi'

# NAS
export HELM_STARTERS="${HOME}/.local/share/helm/starters"

# Print uptime at the start of the session
uptime
