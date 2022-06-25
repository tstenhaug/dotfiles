# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/bin:$HOME/go/bin:$PATH

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt autocd
unsetopt LIST_BEEP

# Path to your oh-my-zsh installation.
#export ZSH=$HOME/.oh-my-zsh

export LIBVIRT_DEFAULT_URI="qemu:///system"

ZINIT_HOME=~/.local/share/zinit/zinit.git
source "$ZINIT_HOME/zinit.zsh"

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k
zinit light olets/zsh-abbr
zinit light mfaerevaag/wd
zinit light zsh-users/zsh-completions

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Key bindings

bindkey -e

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Variables

export rn="zh1885@zh1885.rsync.net"
export rnb="zh1885s1@zh1885s1.rsync.net"
DOOMDIR=${DOOMDIR:-${HOME}/emacs/doom.d/ke}


# If we don't have a "route" to an SSH agent, assume that agent is started, e.g.
# as a systemd user service.
SSH_AUTH_SOCK=${SSH_AUTH_SOCK:-${XDG_RUNTIME_DIR}/ssh-agent.socket}

# In an interactive shell, prompt for ssh passwords, if none are unlocked yet.
if [[ -o interactive ]] ; then
  if [ -S $SSH_AUTH_SOCK ] ; then
    export SSH_AUTH_SOCK
    if ssh-add -l | grep "The agent has no identities" > /dev/null ; then
      ssh-add
    fi
  fi
fi


zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/thomas/.zshrc'

autoload -Uz compinit
compinit

# Load powerlevel10k theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
