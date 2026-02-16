# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Appending History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory


source $HOME/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $HOME/.dotfiles/.alias

# Command suggestions based on history
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 

# Basic auto/tab complete:
autoload -U compinit
# for all completions: menuselection
zstyle ':completion:*' menu select
# for all completions: color
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
# for all completions: grouping the output
zstyle ':completion:*' group-name ''
# for all completions: show comments when present
zstyle ':completion:*' verbose yes
# ssh: reorder output sorting: user over hosts
zstyle ':completion::*:ssh:*:*' tag-order "users hosts"
# kill: advanced kill completion
zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# colored syntax highlighting
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ "$OSTYPE" == "darwin"* ]];then
        export PATH=$PATH:/usr/local/Cellar/openvpn/2.5.3/sbin
fi

# Adding KubeFlow Path
export PATH=$PATH:~/bin

## Adding Datapath for working with multiple data science projects
export data_dir=~/data




. "$HOME/.local/bin/env"
