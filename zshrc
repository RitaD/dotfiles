# Add ~/.zsh/completion to the functions path
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

# automatically enter directories without cd
setopt auto_cd
cdpath=($HOME $HOME/Code)

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# ignore duplicate history entries
setopt histignoredups

# keep more history
export HISTSIZE=200

# Theme configurations
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[red]%}%~%{$reset_color%}]$(git_prompt_info) '

# vimrc
export MYVIMRC="$HOME/.vimrc"

# Bacward search in the shell history with <C-r>
bindkey ^r  history-incremental-search-backward
setopt hist_ignore_all_dups

# 10ms for key sequences
KEYTIMEOUT=1

# Use zsh like vim
function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Powerline
# . '/opt/boxen/homebrew/Cellar/python/2.7.3-boxen2/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh'

# Fix for vim in tmux
export TERM="xterm-256color"

# @see
# http://vim.1045645.n5.nabble.com/MacVim-and-PATH-tt3388705.html#a3392363
# # Ensure MacVim has same shell as Terminal
if [[ -a /etc/zshenv ]]; then
  sudo mv /etc/zshenv /etc/zprofile
fi

# Boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

typeset -aU path
path=( $path )
