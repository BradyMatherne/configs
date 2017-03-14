#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

exec fish

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias srn='shutdown -r now'
