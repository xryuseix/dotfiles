# --------------------------------------------------
#  Setting of zsh
# --------------------------------------------------

source ~/.zprezto/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --------------------------------------------------
#  Source Prezto
# --------------------------------------------------

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz promptinit
promptinit
prompt powerlevel10k

# --------------------------------------------------
#  vcs_info
# --------------------------------------------------

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
#add-zsh-hook precmd _update_vcs_info_msg

# デフォルトエディタをVimに変更
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

# --------------------------------------------------
#  PATHを通す
# --------------------------------------------------

# brew
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"

# Python
PATH=$PATH:$HOME/.pyenv/bin:$PATH

# Ruby
PATH=$PATH:$HOME/.rbenv/shims:$PATH
#PATH=$PATH:$HOME/.rbenv/bin:$PATH
PATH=$PATH:$HOME/.composer/vendor/bin:$PATH
export PATH="/usr/local/Cellar/mysql/8.0.19/bin:$PATH"

eval "$(rbenv init -)"
eval "$(pyenv init -)"

# Flutter
export PATH="$PATH:/Users/ryuse/development/flutter/bin"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# opencv
export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig'

# --------------------------------------------------
#  オプション
# --------------------------------------------------

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob



# --------------------------------------------------
#  キーバインド
# --------------------------------------------------

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward



# --------------------------------------------------
#  エイリアス
# --------------------------------------------------

# ls
alias l='lsd'
alias ls='lsd'
alias la='lsd -a'
alias ll='lsd -l'
alias l1='lsd -1'
alias sl='/usr/local/bin/sl'

# vi to vim
alias vi='vim'

# Jupyter Notebook
alias jn='jupyter notebook'

# alias rm='rm -i'
alias rm='gmv -f --backup=numbered --target-directory ~/.Trash'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'
alias cat='bat'
alias :q="exit"

# ファイルを開く
alias cot="open -a CotEditor"
alias edit="open -a textedit"

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
     alias -g C='| putclip'
fi

# --------------------------------------------------
#  OS別の設定
# --------------------------------------------------
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        #alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        #alias ls='ls -F --color=auto'
        ;;
esac

# vim:set ft=zsh:


autoload -Uz compinit
autoload -Uz zmv
compinit



# --------------------------------------------------
#  gitコマンド補完機能セット
# --------------------------------------------------

# autoloadの文より前に記述
fpath=(~/.zsh/completion $fpath)



# --------------------------------------------------
#  コマンド入力補完
# --------------------------------------------------

# 補完機能有効にする
autoload -U compinit
compinit -u

# 補完候補に色つける
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完リストの表示間隔を狭くする
setopt list_packed

# コマンドの打ち間違いを指摘してくれる
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "



# --------------------------------------------------
#  $ cd 機能拡張
# --------------------------------------------------

# cdを使わずにディレクトリを移動できる
setopt auto_cd
# $ cd - でTabを押すと、ディレクトリの履歴が見れる
setopt auto_pushd



# --------------------------------------------------
#  $ tree でディレクトリ構成表示
# --------------------------------------------------

alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/| /g'"



# --------------------------------------------------
#  git エイリアス
# --------------------------------------------------

alias g="git"
compdef g=git

alias gs='git status --short --branch'
alias ga='git add -A'
alias gc='git commit -m'
alias gps='git push'
alias gpsu='git push -u origin'
alias gp='git pull origin'
alias gf='git fetch'
alias gfp='git fetch -p'

# logを見やすく
alias gl='git log --abbrev-commit --no-merges --date=short --date=iso'
# grep
alias glg='git log --abbrev-commit --no-merges --date=short --date=iso --grep'
# ローカルコミットを表示
alias glc='git log --abbrev-commit --no-merges --date=short --date=iso origin/html..html'

alias gd='git diff'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch -r'

alias gm='git merge'
alias gr='git reset'

# git pull --force
alias current-branch-name="git branch | grep -e '^\\* ' | sed -e 's/^\\* //g'"
# alias force-pull="git fetch && git reset --hard origin/$(current-branch-name)"
alias force-pull="git fetch && git reset --hard origin/master"



# --------------------------------------------------
#  その他のエイリアス
# --------------------------------------------------

# alias B='php ./build'
# alias CB='cd ./build_company'

alias cw='compass watch --time'

alias c='clear'

alias brew='arch -arm64 brew'

## ===== 競プロ ===============
alias gpp='g++ -std=c++1z -O3 -fsanitize=undefined -I .'
alias ao='./a.out'
fj() {
  ALGOPATH="/Users/ryuse/Desktop/Algorithm Library"
  PWD=$(cd $(dirname $0); pwd)
  if [ $PWD = $ALGOPATH ]; then
    g++ -std=c++1z -O3 -fsanitize=address -D_GLIBCXX_DEBUG -fsanitize=undefined -D_GLIBCXX_DEBUG_PEDANTIC -o a.out -I . temp.cpp;
    ./a.out
  else
    echo "The directory is wrong. Please change it now."
  fi
}
alias gpp++='g++ -std=c++1z -O3 -fsanitize=address -D_GLIBCXX_DEBUG -fsanitize=undefined -D_GLIBCXX_DEBUG_PEDANTIC -o a.out -I .'

## ===== Other Lang ===============
alias py='python'
alias py2='python2'
alias rb='ruby'

## ===== Other Tools ===============
alias proofLeader='python /Users/ryuse/Programming/ProofLeader/ProofLeader/proofLeader.py'
alias commitMessage='/Users/ryuse/Programming/Command/commit.out'
alias rime='npx rime'

# --------------------------------------------------
#  bindkey
# --------------------------------------------------

# bindkeyを任意のキー（commandとかoption）にする設定方法
# 1. iTerm2の環境設定>Keys>追加（＋）
# 2. keyboard shortcut → 任意のキー　｜　action → Send Escape Sequence　｜　Esc+ → ●●●●●
# 3. bindekeyの設定で「bindkey '^[●●●●●' 関数名」にする

# コミット 3行用
function git_commit() {
	BUFFER='git commit -m "#'
	CURSOR=$#BUFFER
	BUFFER=$BUFFER'" -m "" -m ""'
}
zle -N git_commit
bindkey '^[git_commit' git_commit

# タブに名前を付ける
function tab_rename() {
	BUFFER="echo -ne \"\e]1;"
	CURSOR=$#BUFFER
	BUFFER=$BUFFER\\a\"
}
zle -N tab_rename
bindkey '^[tab_rename' tab_rename

# 単語単位で削除（前後）
# 前：option ,
# 後：option .
bindkey '^[word-remove-right' kill-word
bindkey '^[word-remove-left' backward-kill-word

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


export PATH="/usr/local/etc/php/7.4/bin:$PATH"
export PATH="/usr/local/etc/php/7.4/sbin:$PATH"

## ===== My Website ===============
export DB_CONNECTION='mysql'
export DB_HOST='localhost'
export DB_PORT='3306'
export DB_DATABASE='NewsBBS'
export DB_USERNAME='root'
export DB_PASSWORD='root'


## ===== RDC ===============
export PATH=~/.npm-global/bin:$PATH




export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

