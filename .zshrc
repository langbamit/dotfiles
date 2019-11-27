

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


_env_init() {
  # init version manager without rehash on startup
  local SHELL_NAME="zsh"
  local init_args=(- --no-rehash zsh)
  local zshrc="$HOME/.zshrc"
  
  # For security on Linux
  [[ -n $XDG_RUNTIME_DIR ]] && local TMPDIR="$XDG_RUNTIME_DIR"

  for i in nodenv; do
    cache_file="${TMPDIR:-/tmp}/${i}-cache.$UID.${SHELL_NAME}"
    if [[ "${commands[$i]}" -nt "$cache_file" \
      || "$zshrc" -nt "$cache_file" \
      || ! -s "$cache_file"  ]]; then

      # Cache init code.
      $i init "${init_args[@]}" >| "$cache_file" 2>/dev/null
    fi

    source "$cache_file"
    unset cache_file
  done

  # pyenv: skip init if a venv is activated by poetry or pipenv
  if [[ -z $POETRY_ACTIVE ]] && [[ -z $PIPENV_ACTIVE ]]; then
    cache_file="${TMPDIR:-/tmp}/pyenv-cache.$UID.${SHELL_NAME}"
    if [[ "${commands[pyenv]}" -nt "$cache_file" \
      || "$zshrc" -nt "$cache_file" \
      || ! -s "$cache_file"  ]]; then

      # Cache init code.
      pyenv init "${init_args[@]}" >| "$cache_file" 2>/dev/null
    fi

    source "$cache_file"
    unset cache_file

    # pyenv-virtualenv init
    init_args=(- zsh)

    cache_file="${TMPDIR:-/tmp}/pyenv-virtualenv-cache.$UID.${SHELL_NAME}"
    if [[ "${commands[pyenv-virtualenv]}" -nt "$cache_file" \
      || "$zshrc" -nt "$cache_file" \
      || ! -s "$cache_file"  ]]; then

      pyenv virtualenv-init "${init_args[@]}" >| "$cache_file" 2>/dev/null
    fi

    source "$cache_file"
    
    # remove _pyenv_virtualenv_hook, cause
    # 1. it's heavy, slow down command execution dramatically
    # 2. `pyenv local <venv-name>` is enough, no need to use
    #    `pyenv activate <venv-name>` to mimic the behavior of `source venv/bin/activate`
    autoload -Uz add-zsh-hook
    add-zsh-hook -D precmd _pyenv_virtualenv_hook

    unset cache_file
  fi

  unset init_args
  
  # optional: rehash manually
  # for i in rbenv pyenv nodenv; do
  #   (( $+commands[i] )) && $i rehash
  # done
}

if ! [[ -d "${ZPLGM[HOME_DIR]}/plugins/_local---init0" ]]; then
  mkdir -p "${ZPLGM[HOME_DIR]}/plugins/_local---init0" 2>/dev/null
  touch "${ZPLGM[HOME_DIR]}/plugins/_local---init0/init.plugin.zsh" 2>/dev/null
fi





# General
export EDITOR="nvim"
export VISUAL="nvim"

setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_LIST
setopt EXTENDED_HISTORY
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=${HOME}/.zsh_history

# Plugins

zplugin ice wait'0' atload'_env_init' lucid
zplugin light _local/init0

zplugin ice silent pick"history.zsh"
zplugin snippet OMZ::lib/history.zsh

# zplugin snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh

zplugin ice silent pick"completion.zsh"
zplugin snippet OMZ::lib/completion.zsh

zplugin ice blockf
zplugin light zsh-users/zsh-completions

# zplugin ice blockf
# zplugin light greymd/docker-zsh-completion

zplugin snippet OMZ::plugins/extract/extract.plugin.zsh
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zplugin snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zplugin snippet OMZ::plugins/sudo/sudo.plugin.zsh # May have unexpected behavious when using with vi-mode
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/history-search-multi-word
zplugin light knu/z

export PURE_PROMPT_SYMBOL='▶'
export PURE_PROMPT_VICMD_SYMBOL='◀'
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure



# Key Bindings
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey -r '\e/'

export PATH="$HOME/.nodenv/bin:$PATH"


[[ -f $HOME/.zshrc_local ]] &&  . $HOME/.zshrc_local

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
