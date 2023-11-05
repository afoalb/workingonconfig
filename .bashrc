
# Only execute the rest of the file if running interactively
[[ $- == *i* ]] || return


# ======================================================================
# General 

PATH=~/bin:$PATH

export EDITOR="vim"
export VIMINIT="source ~/.vim/vimrc"
export HISTCONTROL=ignoredups

# Enable colors in xterm
if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

# ======================================================================
# Aliases

alias conf='/usr/bin/git --git-dir=$HOME/.dotconfig/ --work-tree=$HOME'

alias repo="cd ~/repo"
alias downloads="cd ~/Downloads"

alias ll="ls --group-directories-first --color -laFX"
alias lr="ls -laFR --color"  # list recursively dirs
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias open="xdg-open"
alias vimb="vim --noplugin"


# ======================================================================
# Prompt

# Define colours   
dark_green=$(tput setaf 28);
green=$(tput setaf 34);
mint_green=$(tput setaf 46);
orange=$(tput setaf 208);
white=$(tput setaf 15);
bold=$(tput bold);
 
reset=$(tput sgr0);

# Customise PS1
PS1="\[${bold}\]";   
PS1+="\[${green}\]me";   # for username enter \u
PS1+="\[${dark_green}\] at";
PS1+="\[${green}\] \h";    # hostname of local machine without all the trailing domain name thing
PS1+="\[${dark_green}\] ::";   
PS1+="\[${mint_green}\] \w ";   # directory full path
PS1+="\[${dark_green}\]\$ ";   # display $ and when having superuser privileges displays #
PS1+="\[${reset}\]"; 

export PS1; 


