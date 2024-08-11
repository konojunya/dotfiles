fpath=(/usr/local/share/zsh/functions/ ${fpath})

# ====================================================
# Basic
# ====================================================

export LANG=en_US.UTF-8
export EDITOR=vim

# キー操作
bindkey -e

# 自動補完
autoload -U compinit
compinit -C

# nobeep
setopt no_beep
setopt nolistbeep

# ディレクトリの移動
setopt auto_cd
function sd() {
  cd "$( ghq list --full-path | peco )"
}

alias sd="sd"

# ====================================================
# Path
# ====================================================

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"

# for M1 device
if [ -d "/opt/homebrew" ]; then
  export PATH="/opt/homebrew/bin:${PATH}"
  export PATH="/opt/homebrew/sbin:${PATH}"

  # homebrew
  if [[ -x `which brew` ]]; then
    # asdf
    if [[ -d "/opt/homebrew/opt/asdf" ]]; then
      . /opt/homebrew/opt/asdf/libexec/asdf.sh
      export ASDF_GOLANG_MOD_VERSION_ENABLED=true
    fi
  fi
fi

export PATH="/usr/local/bin:${PATH}"
export PATH="/usr/local/sbin:${PATH}"
export PATH="${PATH}:${HOME}/.poetry/bin"
export PATH="${PNPM_HOME}:${PATH}"
export PATH="${HOME}/.yarn/bin:${PATH}"
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${HOME}/Library/Android/sdk/platform-tools:${PATH}"
export PATH="${HOME}/flutter/bin:${PATH}"
export PATH="${HOME}/fvm/default/bin:${PATH}"
export PATH="${HOME}/.rbenv/bin:${PATH}"
export PATH="${PATH}:${HOME}/.pub-cache/bin"
export PATH="${GOENV_ROOT}/bin:${PATH}"

# ====================================================
# Google Cloud SDK
# ====================================================

# gcloud
# install: https://cloud.google.com/sdk/downloads?hl=ja#interactive
if [[ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]]; then
  source "${HOME}/google-cloud-sdk/path.zsh.inc"
  source "${HOME}/google-cloud-sdk/completion.zsh.inc"

  alias appserver="${HOME}/google-cloud-sdk/bin/dev_appserver.py"
fi

# ====================================================
# History
# ====================================================

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=1000000

# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

# 重複を記録しない
setopt hist_ignore_dups

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# 開始と終了を記録
setopt EXTENDED_HISTORY

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 他のターミナルとヒストリーを共有
setopt share_history

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history

# カーソル位置で補完
setopt complete_in_word

# `=` 以降のパスも補完
setopt magic_equal_subst


# history bind
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both

# 補完候補に色を付ける
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 曖昧検索
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ====================================================
# Aliases & Custom functions
# ====================================================

# basic
alias ls='ls -G'
alias ll='ls -lF'
alias la='ls -laF'
alias md='mkdir -pv'
alias cp='cp -p'
alias df='df -h'
alias rmrf='rm -rf'

# global
alias -g G="| grep"
alias -g X="| xargs"

# <Tab> で候補選択
zstyle ':completion:*:default' menu select=1

# <Shift-Tab>で補完候補の逆順
bindkey "^[[Z" reverse-menu-complete

# 単語の一部として扱われる文字のセット
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

eval "$(starship init zsh)"

# tools settings
export ESLINT_D_LOCAL_ESLINT_ONLY=1
export ESLINT_USE_FLAT_CONFIG=true

export PRETTIERD_LOCAL_PRETTIER_ONLY=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/konojunya/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/konojunya/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/konojunya/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/konojunya/google-cloud-sdk/completion.zsh.inc'; fi
