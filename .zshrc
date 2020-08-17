setopt NO_CASE_GLOB
setopt AUTOCD
setopt CORRECT
setopt CORRECT_ALL
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
alias golocal="cd /Applications/mampstack-7.4.8-0/apache2/htdocs"
alias goerrors="open /Applications/mampstack-7.4.8-0/apache2/logs/error_log"
alias editprof="open ~/.zshrc"
alias rldprof="source ~/.zshrc"

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
autoload -Uz compinit && compinit

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT="%F{117}%1~%f\$vcs_info_msg_0_ %F{223}->%F{114} "
zstyle ':vcs_info:git:*' formats ': %F{131}(%b) %u%f'
zstyle ':vcs_info:*' enable git
