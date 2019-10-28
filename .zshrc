

# Install and load zplugin
function load_zplugin()
{
    source "${HOME}/.zplugin/bin/zplugin.zsh"
    autoload -Uz _zplugin
    (( ${+_comps} )) && _comps[zplugin]=_zplugin
}

if [ ! -d "${HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
    load_zplugin
    zplugin self-update
else
    load_zplugin
fi


# Plugins
zplugin ice silent pick"history.zsh"
zplugin snippet OMZ::lib/history.zsh

zplugin ice silent pick"completion.zsh"
zplugin snippet OMZ::lib/completion.zsh

zplugin ice blockf
zplugin light zsh-users/zsh-completions

# zplugin ice blockf
# zplugin light greymd/docker-zsh-completion

zplugin snippet OMZ::plugins/extract/extract.plugin.zsh
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zplugin snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zplugin snippet OMZ::plugins/sudo/sudo.plugin.zsh
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/history-search-multi-word
zplugin light knu/z

export PURE_PROMPT_SYMBOL='▶'
export PURE_PROMPT_VICMD_SYMBOL='◀'
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

export VM_LAZY_LOAD=true
zplugin light lukechilds/zsh-nvm

#zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme




# Key Bindings
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

[[ -f $HOME/.zshrc_local ]] &&  . $HOME/.zshrc_local

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'


