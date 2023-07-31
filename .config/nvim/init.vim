" =============================================================
" Basic
" =============================================================

" 不要なプラグインを停止
let g:loaded_gzip          = 1
let g:loaded_tar           = 1
let g:loaded_tarPlugin     = 1
let g:loaded_zip           = 1
let g:loaded_zipPlugin     = 1
let g:loaded_rrhelper      = 1
let g:loaded_2html_plugin  = 1
let g:loaded_vimball       = 1
let g:loaded_vimballPlugin = 1

" python3
let g:python3_host_prog = "/opt/homebrew/bin/python3"

" <Leader>を`,`に設定
let mapleader = ","

" 各種基本設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,ico-2022-jp,sjis,euc-jp,latin1
set completeopt=menu,menuone,noselect
set autoread
set t_ut=
set termguicolors
set nohlsearch
set showmode
set incsearch
set formatoptions+=mM
set display+=lastline
set ignorecase
set smartcase
set wrapscan
set showmatch
set showmode
set title
set ruler
set tabstop=2
set shiftwidth=2
set signcolumn=yes
set autoindent
set smartindent
set expandtab
set wrap
if has('mac')
  set clipboard=unnamed
elseif has('unix')
  set clipboard=unnamedplus
endif
set laststatus=2
if !isdirectory($HOME.'/.config/nvim/swap')
  call mkdir($HOME.'/.config/nvim/swap', 'p')
endif
set directory=~/.config/nvim/swap
set ambiwidth=single
set wildmenu
set wildmode=longest,full
set iminsert=0
set imsearch=0
set noimdisable
set noimcmdline
set backspace=indent,eol,start
set matchpairs& matchpairs+=<:>
set lazyredraw
set nrformats=
set guicursor=n-v-ve-o-r-c-cr-sm:block,i-ci:block-blinkwait300-blinkon200-blinkoff150

" 改行時のコメントを無効化
set formatoptions-=r
set formatoptions-=o

" ビープ音を消す
set vb t_vb=
set novisualbell

" タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

" マウス無効化
set mouse=

" `system()` の末尾空白を削除して結果を返す
function! TrimedSystem(...)
 return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

" 基本キーマップ

" leader を \ に退避
nnoremap \ ,
vnoremap \ ,

" <C-c> の動作を <Esc> に合わせる
inoremap <C-c> <Esc>

" vscode の設定に <Esc> を合わせる
inoremap <C-c> <Esc>

" increment, decrement で選択状態を維持
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" x でレジスタを使わずに切り取り
nnoremap x "_x

" マーク使わないので無効化
nnoremap m <Nop>

" 行頭, 文末の移動
nnoremap M g^
vnoremap M g^
nnoremap H g0
vnoremap H g0
nnoremap L g$
vnoremap L g$

nnoremap mH 0
vnoremap mH 0
nnoremap mL $
vnoremap mL $

" スクリーン内での移動
nnoremap gh H
nnoremap gm M
nnoremap gl L
vnoremap gh H
vnoremap gm M
vnoremap gl L

" 検索後の位置調整
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" command モードは Emacs 風に
cmap <C-f> <Right>
cmap <C-b> <Left>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-d> <Del>
cmap <C-h> <BackSpace>

" QuickFix の移動
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>

" locationlist の移動
nnoremap [w :lprevious<CR>
nnoremap ]w :lnext<CR>
nnoremap [W :<C-u>lfirst<CR>
nnoremap ]W :<C-u>llast<CR>

" argument list の移動
nnoremap [a :previous<CR>
nnoremap ]a :next<CR>
nnoremap [A :<C-u>first<CR>
nnoremap ]A :<C-u>last<CR>

" Toggle系オプション
nnoremap <silent> \w :<C-u>setl wrap! wrap?<CR>
nnoremap <silent> \s :call <SID>toggle_syntax()<CR>
nnoremap <silent> \n :call <SID>toggle_number()<CR>
nnoremap <silent> \m :call <SID>toggle_mouse()<CR>
nnoremap <silent> \h :<C-u>setl hlsearch!<CR>

function! s:toggle_syntax() abort
  if exists('g:syntax_on')
    syntax off
    TSDisable highlight
    redraw
    echo 'syntax off'
  else
    syntax on
    TSEnable highlight
    redraw
    echo 'syntax on'
  endif
endfunction

function! s:toggle_number() abort
  if &number == 1
    set nonumber
    echo 'number off'
  else
    set number
    echo 'number on'
  endif
endfunction

function! s:toggle_mouse() abort
  if &mouse == 'a'
    set mouse=
    echo 'mouse off'
  else
    set mouse=a
    echo 'mouse on'
  endif
endfunction

" スーパーユーザとして保存
cnoremap w!! w !sudo tee > /dev/null %

" 選択範囲内をExpressionレジスタで評価->置換
vnoremap Q "0ygvc<C-r>=<C-r>0<CR><ESC>

" 指定データをクリップボードにつながるレジスタへ保存
function! s:clip(data)
  let root = finddir('.git/..', expand('%:p:h') . ';') . '/'
  let data = substitute(a:data, '^' . root, '', '')
  let @* = data
  echo '[clipped] ' . data
endfunction

" 現在開いているファイルのパス
command! -nargs=0 ClipPath call s:clip(expand('%:p'))

" 現在開いているファイルのファイル名
command! -nargs=0 ClipFile call s:clip(expand('%:t'))

" 現在開いているファイルのディレクトリパス
command! -nargs=0 ClipDir  call s:clip(expand('%:p:h'))

" QuickFix の設定
augroup QuickfixConfigure
  autocmd!

  " help & QuickFix を q だけで閉じる
  autocmd FileType help nnoremap <buffer> q <C-w>c
  autocmd FileType qf nnoremap <buffer> q <C-w>c

  " QuickFix は折り返しを無効化する
  autocmd FileType qf setlocal nowrap

  " signcolumn を無効化
  autocmd FileType qf setlocal signcolumn=no

  " QuickFix を自動で開く
  autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vim,**grep** nested if len(getqflist()) != 0 | copen | endif
augroup END

" ペースト時のオートインデントを無効化
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" ファイルタイプショートカット
autocmd! FileType md setlocal filetype=markdown
autocmd! FileType js setlocal filetype=javascript


" カーソル位置の復元
augroup restoreCursorPosition
  autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup END


" incsearch
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter [/\?] :set hlsearch
  autocmd CmdlineLeave [/\?] :set nohlsearch
augroup END

" Set tabline.
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap [Tag] <Nop>
nmap t [Tag]

" 画面分割用のキーマップ
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w><Bar>
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

" quickfix/locationlist の open/close
nnoremap <Space>co :copen<CR>
nnoremap <Space>cc :cclose<CR>
nnoremap <Space>lo :lopen<CR>
nnoremap <Space>lc :lclose<CR>

" 現在のタブページ以外全て閉じる
nnoremap <C-w>O :<C-u>tabo<CR>

" Switches to tab with specific number.
nnoremap <silent> <Leader>1 1gt
nnoremap <silent> <Leader>2 2gt
nnoremap <silent> <Leader>3 3gt
nnoremap <silent> <Leader>4 4gt
nnoremap <silent> <Leader>5 5gt
nnoremap <silent> <Leader>6 6gt
nnoremap <silent> <Leader>7 7gt
nnoremap <silent> <Leader>8 8gt
nnoremap <silent> <Leader>9 9gt

" Terminal
augroup terminal-config
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal signcolumn=no
augroup END

" open terminal
nnoremap <silent> <Leader>tt :<C-u>terminal<CR>
nnoremap <silent> <Leader>ts :<C-u>execute 'split \| terminal'<CR>
nnoremap <silent> <Leader>tv :<C-u>execute 'vsplit \| terminal'<CR>
tnoremap <silent> <Leader>ts <C-\><C-n>:execute 'split \| terminal'<CR>
tnoremap <silent> <Leader>tv <C-\><C-n>:execute 'vsplit \| terminal'<CR>

" to normal mode
tnoremap <silent> <C-[> <C-\><C-n>
tnoremap <silent> <Esc> <C-\><C-n>

" close terminal
tnoremap <silent> <C-q> <C-\><C-n>:q<CR>

function! s:auto_update_colorscheme(...) abort
    setlocal autoread noswapfile
    let interval = a:0 > 0 ? a:1 : 3000
    let timer = timer_start(interval, {-> execute('checktime')}, {'repeat' : -1})
    autocmd! BufReadPost <buffer> source $MYVIMRC
endfunction
command! -nargs=? AutoUpdateColorscheme call <SID>auto_update_colorscheme(<f-args>)

" ripgrep
" If rg is not present, install: https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --hidden\ -g\ !.git
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" =============================================================
" Filetypes
" =============================================================
augroup fileTypeDetect
  autocmd BufRead,BufNew,BufNewFile *.mdx setlocal filetype=markdown
  autocmd BufRead,BufNew,BufNewFile *.ejs setlocal ft=html

  autocmd BufRead,BufNew,BufNewFile gitconfig setlocal ft=gitconfig
  autocmd BufRead,BufNew,BufNewFile .eslintrc setlocal ft=json
  autocmd BufRead,BufNew,BufNewFile .stylelintrc setlocal ft=json
  autocmd BufRead,BufNew,BufNewFile .prettierrc setlocal ft=json
  autocmd BufRead,BufNew,BufNewFile .babelrc setlocal ft=json
  autocmd BufRead,BufNew,BufNewFile .textlintrc setlocal ft=json
augroup END


" =============================================================
" Plugins
" =============================================================
call plug#begin()

" editing
Plug 'easymotion/vim-easymotion'

" statusline
Plug 'itchyny/lightline.vim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" color schema
Plug 'wadackel/vim-dogrun'

call plug#end()

" lightline option
let g:lightline = {
  \ 'colorscheme': 'dogrun',
  \ }

" colorschema
colorscheme dogrun

