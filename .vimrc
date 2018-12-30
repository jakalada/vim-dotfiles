" jakalada's vimrc

" Initialize {{{1

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

filetype plugin indent off

if has('vim_starting')
  if has('win32') || has('win64')
    set encoding=utf-8
  else
    set encoding=utf-8
  endif
  scriptencoding utf-8
endif

let s:iswin32 = has('win32')
let s:iswin64 = has('win64')
let s:iswin = has('win32') || has('win64')
let s:isgui = has('gui_running')
let s:ismacunix = has('macunix')

if s:iswin
  set shellslash
  let $DOTVIMDIR = expand('~/vimfiles')
  let $DROPBOXDIR = expand('~/Dropbox')
  let $VIMCONFIGDIR = expand('~/git/vim-dotfiles')
else
  let $DOTVIMDIR = expand('~/.vim')
  let $DROPBOXDIR = expand('~/Dropbox')
  let $VIMCONFIGDIR = expand('~/git/vim-dotfiles')
endif

" vim-plug {{{1
call plug#begin($DOTVIMDIR . '/plugged')

" Colorscheme {{{2
Plug 'altercation/vim-colors-solarized'
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/seoul256.vim'
Plug 'kamwitsta/flatwhite-vim'
Plug 'NLKNguyen/papercolor-theme'

" Syntax {{{2
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'gabrielelana/vim-markdown'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'            " 多機能
Plug 'udalov/kotlin-vim'
Plug 'vim-ruby/vim-ruby'

" Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'lambdalisue/vim-gita'

" 入力補助 {{{2
Plug 'cohama/lexima.vim'      " 囲み文字の自動入力
Plug 'godlygeek/tabular'      " コード整形
Plug 'kana/vim-smartchr'      " 例: smartchr#loop(' = ', ' == ', '=')
Plug 'taku-o/vim-toggle'      " 例: true -> false -> true
Plug 'tpope/vim-surround'     " 囲み文字に入力補助
Plug 'tyru/caw.vim'           " コメントアウト

" シンタックスチェック {{{2
Plug 'w0rp/ale'

" 補完 {{{2

" フォーマッター {{{2

" スニペット {{{2

" 移動 {{{2
Plug 'kana/vim-altr'          " ユーザー定義の代替ファイル
Plug 'kana/vim-gf-user'       " ユーザー定義のgf
Plug 'thinca/vim-visualstar'  " *で選択中の文字列を検索

" UI {{2
Plug 'itchyny/thumbnail.vim'           " バッファのサムネイル表示
Plug 'justinmk/vim-dirvish'            " ファイラ
Plug 'Shougo/vimfiler'                 " ファイラ
Plug 'previm/previm'                   " Markdownのプレビュー表示
Plug 'majutsushi/tagbar'               " タグのサイドバー表示
Plug 'mattn/calendar-vim'              " カレンダー表示
Plug 'nathanaelkane/vim-indent-guides' " インデント表示
Plug 'Shougo/vinarise'                 " バイナリエディタ
Plug 'thinca/vim-editvar'              " 変数の値を別バッファで編集

" コンソール連携 {{{2
Plug 'jpalardy/vim-slime'

" Vimスクリプトライブラリ {{{2
Plug 'mattn/webapi-vim'                     " Web API
if !s:iswin
  Plug 'Shougo/vimproc.vim', {'do': 'make'} " 非同期処理
endif
Plug 'tpope/vim-dispatch'                   " 非同期処理

" そのほか {{{2
Plug 'kana/vim-tabpagecd'       " タブページごとにカレントディレクトリを設定する
Plug 'Shougo/junkfile.vim'      " 日時を名前にしたファイルを作成する
Plug 'Shougo/tabpagebuffer.vim'
Plug 't9md/vim-quickhl'         " 指定文字列のハイライト
Plug 'thinca/vim-zenspace'      " 全角スペースの表示
Plug 'thinca/vim-prettyprint'   " Vim Script用のpp
Plug 'thinca/vim-quickrun'      " コード実行
Plug 'tpope/vim-repeat'         " surroundの挙動もドットで繰り返せるようにする
Plug 'tyru/open-browser.vim'    " ブラウザでの表示・検索
Plug 'vim-jp/vimdoc-ja'         " vimdocの和訳版

" vim-lsp - Language Server Protocol対応 {{{2
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'natebosch/vim-lsc'

" lightline - ステータスバー {{{2
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'   " aleによるシンタックスチェックの結果表示

" Unite {{{2
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
Plug 'tacroe/unite-mark'
Plug 'ujihisa/unite-colorscheme'
Plug 'ujihisa/unite-font'
Plug 'ujihisa/unite-locate'

" ref {{{2
Plug 'thinca/vim-ref'

" metarw - データソースを抽象化して扱うファイラ {{{2
Plug 'kana/vim-metarw'
Plug 'kana/vim-metarw-git'

" operator-user ユーザー定義のオペレータ {{{2
Plug 'kana/vim-operator-user'

" submode ユーザー定義のモード {{{2
Plug 'kana/vim-submode'

" textobj ユーザー定義のテキストオブジェクト {{{2
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-lastpat'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-syntax'
Plug 'osyo-manga/vim-textobj-multiblock'

call plug#end()

filetype plugin indent on
syntax enable
syntax sync fromstart

" Commands {{{1
" .vimrcの再読み込み時に.vimrc内で設定されたautocmdを初期化する {{{
" MyAutocmdを使用することで漏れなく初期化できる
augroup vimrc
  autocmd!
augroup END

command!
      \   -bang -nargs=*
      \   MyAutocmd
      \   autocmd<bang> vimrc <args>
" }}}

" 定義されているマッピングを調べるコマンドを定義する {{{
command!
      \   -nargs=* -complete=mapping
      \   AllMaps
      \   map <args> | map! <args> | lmap <args>
" }}}

" For rails.vim {{{
if s:iswin
  command!
        \   -bar -nargs=1
        \   OpenURL
        \   :!start cmd /cstart /b <args>
else
  command!
        \   -bar -nargs=1
        \   OpenURL
        \   :VimProcBang firefox <args>
endif
" }}}

" Functions {{{1


" Encoding {{{1
" fileencodingの設定 {{{
set fileencodings=iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,euc-jp,eucjp-ms,cp932

" マルチバイト文字が含まれていない場合はencodingの値を使用する
MyAutocmd BufReadPost *
      \   if &modifiable && !search('[^\x00-\x7F]', 'cnw')
      \ |   setlocal fileencoding=
      \ | endif
" }}}

" fileformatの設定 {{{
if s:iswin
  set fileformat=dos
else
  set fileformat=unix
endif

set fileformats=unix,dos,mac
" }}}

"East Asian Width Class Ambiguous な文字をASCII文字の2倍の幅で扱う
set ambiwidth=double

set emoji

" Options {{{1

if s:isgui
  let g:PaperColor_Theme_Options = {
        \   'language': {
        \     'python': {
        \       'highlight_builtins' : 1
        \     },
        \     'cpp': {
        \       'highlight_standard_library': 1
        \     },
        \     'c': {
        \       'highlight_builtins' : 1
        \     }
        \   }
        \ }
  set background=light
  colorscheme PaperColor

  if s:ismacunix
    set guifont=SourceCodePro-Regular:h13
  elseif s:iswin
    set renderoptions=type:directx,renmode:5
    set guifont=Ricty_Diminished:h11:cANSI:qDRAFT:qANTIALIASED
  else
    set guifont=Ricty\ Diminished\ 13.5
  endif

  set linespace=8
  set guioptions=ciM
  set mouse=a
  set mousehide
  set mousefocus
  set novisualbell
  set guicursor+=a:blinkon0
else
  set background=light
  colorscheme PaperColor
endif

set noimcmdline
set iminsert=0
set imsearch=0

set pumheight=10

set cursorline
set cmdheight=1

set signcolumn=yes

set breakindent

set smartindent autoindent
set smarttab expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround

set backspace=indent,eol,start

set nojoinspaces

setlocal matchpairs+=<:>

setlocal iskeyword+=-

set hidden

set foldlevelstart=99

set backupdir=~/tmp
set directory-=.
if v:version >= 703
  set undofile
  set undodir=~/tmp
endif

if has('virtualedit')
  set virtualedit=block
endif

" マルチバイト文字の扱いを自然にする
set formatoptions+=m
set formatoptions+=M

set scrolloff=10

set helplang=ja

" REF: http://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html
MyAutocmd WinEnter * checktime
set autoread

if s:isgui || has('xterm_clipboard')
  set clipboard=unnamed
endif

set showfulltag
set tagbsearch

if has('unix')
  set nofsync
  set swapsync=
endif

" search {{{
set incsearch
set ignorecase
set smartcase
set wrapscan
set hlsearch

nnoremap <silent> <SID>[nohlsearch] :<C-U>nohlsearch<CR>
nnoremap <script> v <SID>[nohlsearch]v
nnoremap <script> V <SID>[nohlsearch]V
nnoremap <script> i <SID>[nohlsearch]i
nnoremap <script> I <SID>[nohlsearch]I
nnoremap <script> a <SID>[nohlsearch]a
nnoremap <script> A <SID>[nohlsearch]A
nnoremap <script> o <SID>[nohlsearch]o
nnoremap <script> O <SID>[nohlsearch]O
" }}}

set number

set noshowcmd

set noshowmode

set confirm

set report=0

set noequalalways

if has('conceal')
  set conceallevel=0
endif

set list
let &listchars = 'tab:| ,trail:-'

let &fillchars = 'vert: ,fold: ,diff:-'

let &showbreak = '> '

set wrap

set textwidth=0

set laststatus=2

set nomodeline

set completeopt-=preview

" Mappings {{{1

" IBusで日本語入力に切り替えるたびにスペースが挿入されてしまうのを防ぐ {{{2
noremap <C-Space> <Nop>
noremap! <C-Space> <Nop>
xnoremap <C-Space> <Nop>
snoremap <C-Space> <Nop>
lnoremap <C-Space> <Nop>


" <C-J>と<C-K>を各モードでエスケープにマッピング {{{2
nnoremap <silent> <C-J> <Esc>:<C-U>nohlsearch<CR>
vnoremap <C-J> <Esc>
onoremap <C-J> <Esc>
inoremap <C-J> <Esc>
cnoremap <C-J> <C-C>
xnoremap <C-J> <Esc>
snoremap <C-J> <Esc>
lnoremap <C-J> <Esc>

nnoremap <silent> <C-K> <Esc>:<C-U>nohlsearch<CR>
vnoremap <C-K> <Esc>
onoremap <C-K> <Esc>
inoremap <C-K> <Esc>
cnoremap <C-K> <C-C>
xnoremap <C-K> <Esc>
snoremap <C-K> <Esc>
lnoremap <C-K> <Esc>


" Leader {{{2
let g:mapleader = ' '
let g:maplocalleader = '\'

" mapmode-nvo {{{2
noremap j gj
noremap k gk

noremap L g_
noremap H ^

noremap <C-H> <C-U>
noremap <C-L> <C-D>


" mapmode-n {{{2
nnoremap <Leader>k <C-^>

nnoremap <Backspace> <C-O>
nnoremap <S-Backspace> <C-I>

nnoremap <silent> <Leader><Leader> :<C-U>write<CR>

nnoremap <C-Up> <C-A>
nnoremap <C-Down> <C-X>

nnoremap Q q
nnoremap <silent> q :<C-U>close<CR>

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap n nzz
nnoremap N Nzz


" mapmode-v {{{2
vnoremap > >gv
vnoremap < <gv

vnoremap ) t)
vnoremap ( t(

vnoremap q <Nop>
vnoremap qq <Nop>

" REF: http://labs.timedia.co.jp/2012/10/vim-more-useful-blockwise-insertion.html
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')
function! s:force_blockwise_visual(next_key)
  if mode() ==# 'v'
    return "\<C-v>" . a:next_key
  elseif mode() ==# 'V'
    return "\<C-v>0o$" . a:next_key
  else  " mode() ==# "\<C-v>"
    return a:next_key
  endif
endfunction


" mapmode-i {{{2
inoremap <silent> <C-L> <Right>
inoremap <silent> <C-H> <Left>

inoremap <silent> <F7> <Esc>gUiwea

inoremap <C-CR> <Esc>o


" mapmode-o {{{2
onoremap / t
onoremap ? T

onoremap ) t)
onoremap ( t(

" File Type Plugins {{{1
" c.vim {{{2
let g:c_gnu = 1
let g:c_comment_strings = 1
let g:c_space_errors = 1
" let g:c_no_trail_space_error = 1
" let g:c_no_tab_space_error = 1
" let g:c_no_bracket_error = 1
" let g:c_no_curly_error = 1
let g:c_curly_error = 1
" let g:c_no_ansi = 1
let g:c_ansi_typedefs = 1
let g:c_ansi_constants  = 1
" let g:c_no_utf = 1
" let g:c_syntax_for_h = 1
let g:c_no_if0 = 1
" let g:c_no_cformat = 1
" let g:c_no_c99 = 1
" let g:c_no_c11
" let g:c_no_comment_fold = 1
" let g:c_no_if0_fold = 1
" let g:c_minlines = 100

" coffee.vim {{{2
" REF: https://github.com/kchmck/vim-coffee-script
" helpファイルがないのでREADMEを参照する
" let g:coffee_indent_keep_current = 1
" let g:coffee_compiler = '/usr/bin/coffee'
" let g:coffee_make_options = '--bare'
" let g:coffee_cake = '/opt/bin/cake'
" let g:coffee_cake_options = 'build'
" let g:coffee_linter = '/opt/bin/coffeelint'
" let g:coffee_lint_options = '-f lint.json'
" let g:coffee_compile_vert = 1
" let g:coffee_watch_vert = 1
" let g:coffee_run_vert = 1

" cpp.vim {{{2
" c.vimの変数も採用される
" let g:cpp_no_cpp11 = 1
" let g:cpp_no_cpp14 = 1

" csh.vim {{{2
let g:filetype_csh = 'tcsh'

" html.vim {{{2
" let g:html_no_rendering = 1
" let g:html_wrong_comments = 1

" java.vim {{{2
" let g:java_mark_braces_in_parens_as_errors = 1
let g:java_highlight_java_lang_ids = 1
let g:java_highlight_functions = 'style'
let g:java_highlight_debug = 1
" let g:java_ignore_javadoc = 1
let g:java_javascript = 1
let g:java_css = 1
let g:java_vb = 1
" let g:java_minlines = 50

" javascript.vim {{{2
" REF: https://github.com/pangloss/vim-javascript
" helpファイルがないのでREADMEを参照する
let g:javascript_enable_domhtmlcss = 1
" let g:javascript_ignore_javaScriptdoc = 1
" let g:javascript_conceal_function   = "ƒ"
" let g:javascript_conceal_null       = "ø"
" let g:javascript_conceal_this       = "@"
" let g:javascript_conceal_return     = "⇚"
" let g:javascript_conceal_undefined  = "¿"
" let g:javascript_conceal_NaN        = "ℕ"
" let g:javascript_conceal_prototype  = "¶"
" let g:javascript_conceal_static     = "•"
" let g:javascript_conceal_super      = "Ω"

" json.vim {{{2
" REF: https://github.com/elzr/vim-json
" helpファイルがないのでREADMEを参照する
" let g:vim_json_syntax_conceal = 0
" let g:vim_json_syntax_concealcursor = 1

" gabrielelana/vim-markdown {{{2
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 1

" php.vim {{{2
let g:php_sql_query = 1
let g:php_baselib = 1
let g:php_htmlInStrings = 1
" let g:php_oldStyle = 1
let g:php_asp_tags = 1
" let g:php_noShortTags = 1
let g:php_parent_error_close = 1
let g:php_parent_error_open = 1
let g:php_folding = 1
" let g:php_sync_method = x

" python.vim {{{2
let g:python_highlight_all = 1

" ruby.vim {{{2
let g:ruby_operators = 1
let g:ruby_space_errors = 1
" let g:ruby_no_trail_space_error = 1
" let g:ruby_no_tab_space_error = 1
let g:ruby_fold = 1
" let g:ruby_no_expensive = 1
" let g:ruby_minlines = 100
" let g:ruby_spellcheck_strings = 1

" sh.vim {{{2
let g:is_bash = 1
let g:sh_fold_enabled = 7
" let g:sh_minlines = 500
" let g:sh_maxlines = 100

" vim.vim {{{2
" let g:vimsyn_minlines = 50
" let g:vimsyn_maxlines = 50
let g:vimsyn_embed = 0
let g:vimsyn_folding = 0
let g:vimsyntax_noerror = 1

" xml.vim{{{2
" let g:xml_namespace_transparent=1
let g:xml_syntax_folding = 1

" Plugins {{{1
" vim-toggle {{{2
nmap - <Plug>ToggleN


" matchit.vim {{{2
let loaded_matchit = 1

" caw.vim " {{{2
let g:caw_no_default_keymappings = 1
nmap <C-P> <Plug>(caw:hatpos:toggle)
vmap <C-P> <Plug>(caw:hatpos:toggle)


" vimfiler {{{2
" 削除時にゴミ箱に移動したい場合
" windows: vimprocプラグインをインストール
"   linux: trash-cliをインストール
"     osx: rmtrashをインストール
"     etc: オプションで直接コマンドを指定する
call vimfiler#custom#profile('default', 'context', {
      \   'explorer' : 0,
      \   'safe' : 0,
      \   'split' : 'split',
      \   'auto_cd' : 0
      \ })

let g:vimfiler_ignore_pattern = '\(^\.\|\~$\|\.pyc$\|\.[oad]$\|^__pycache__$\|\.meta$\)'
let g:vimfiler_time_format        = '%Y/%m/%d %H:%M'  " 例: 2013/01/01 00:00
let g:vimfiler_force_overwrite_statusline = 0

nnoremap <silent> <Leader>e :<C-U>VimFilerExplorer -toggle<CR>
nnoremap <silent> <Leader>E :<C-U>VimFilerCurrentDir -toggle<CR>

MyAutocmd Filetype vimfiler call s:init_vimfiler()
function! s:init_vimfiler() " {{{
  setlocal nonumber
endfunction " }}}

" unite.vim {{{2
" unite-variables
let g:unite_split_rule = 'botright'
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 60

" unite-source-variables
let g:unite_source_file_mru_time_format = '(%F %R)'
let g:unite_source_grep_max_candidates = 1000
let g:unite_source_file_mru_long_limit = 1000
let g:unite_source_file_mru_limit = 200
let g:unite_source_directory_mru_long_limit = 1000

nnoremap <SID>[unite] <Nop>
xnoremap <SID>[unite] <Nop>
nmap f <SID>[unite]
xmap f <SID>[unite]

nnoremap <SID>[unite-no-quit] <Nop>
xnoremap <SID>[unite-no-quit] <Nop>
nmap F <SID>[unite-no-quit]
xmap F <SID>[unite-no-quit]

nnoremap <silent> <SID>[unite]<Space> :<C-U>UniteResume<CR>

nnoremap <silent> <SID>[unite]f :<C-U>Unite -buffer-name=buffer_tab buffer_tab<CR>
nnoremap <silent> <SID>[unite]F :<C-U>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite]r :<C-U>Unite -buffer-name=register register<CR>
nnoremap <silent> <SID>[unite]t :<C-U>Unite -buffer-name=tab tab:no-current<CR>
nnoremap <silent> <SID>[unite]o :<C-U>Unite -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite]m :<C-U>Unite -buffer-name=mark mark<CR>
nnoremap <silent> <SID>[unite]S :<C-U>Unite -buffer-name=source source<CR>

nnoremap <silent> <SID>[unite-no-quit]f :<C-U>Unite -no-quit -keep-focus -buffer-name=buffer_tab buffer_tab<CR>
nnoremap <silent> <SID>[unite-no-quit]F :<C-U>Unite -no-quit -keep-focus -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite-no-quit]r :<C-U>Unite -no-quit -keep-focus -buffer-name=register register<CR>
nnoremap <silent> <SID>[unite-no-quit]t :<C-U>Unite -no-quit -keep-focus -buffer-name=tab tab:no-current<CR>
nnoremap <silent> <SID>[unite-no-quit]o :<C-U>Unite -no-quit -keep-focus -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite-no-quit]m :<C-U>Unite -no-quit -keep-focus -buffer-name=mark mark<CR>
nnoremap <silent> <SID>[unite-no-quit]S :<C-U>Unite -no-quit -keep-focus -buffer-name=source source<CR>


" unite-line {{{2
nnoremap <silent> <SID>[unite]l :<C-U>UniteWithCursorWord -buffer-name=line line<CR>
nnoremap <silent> <SID>[unite-no-quit]l :<C-U>UniteWithCursorWord -no-quit -buffer-name=line line<CR>


" unite-menu {{{2

" unite-junkfile {{{2
nnoremap <silent> <SID>[unite]j :<C-u>Unite -start-insert junkfile/new junkfile<CR>


" altr {{{2
nmap <Leader>n  <Plug>(altr-forward)
nmap <Leader>p  <Plug>(altr-back)

call altr#define('spec/%_spec.rb', 'lib/%.rb')
call altr#define('src/lib/*/%.coffee', 'spec/*/%_spec.coffee')
call altr#define('src/lib/%.coffee', 'spec/%_spec.coffee')
call altr#define('src/%.c', 'include/%.h')


" unite-neco {{{2
let s:unite_source = {'name': 'neco'}

function! s:unite_source.gather_candidates(args, context)
  let l:necos = [
        \ "~(-'_'-) goes right",
        \ "~(-'_'-) goes right and left",
        \ "~(-'_'-) goes right quickly",
        \ "~(-'_'-) goes right then smile",
        \ "~(-'_'-)  -8(*'_'*) go right and left",
        \ "(=' .' ) ~w",
        \ ]
  return map(l:necos, "{
        \ 'word': v:val,
        \ 'source': 'neco',
        \ 'kind': 'command',
        \ 'action__command': 'Neco ' . v:key,
        \ }")
endfunction
call unite#define_source(s:unite_source)


" vimshell {{{2
let g:vimshell_prompt = '$ '
let g:vimshell_user_prompt = '"[" . getcwd() ."]"'

nnoremap <Leader>s :<C-U>VimShell<CR>

" vim-ref {{{2
if s:iswin
  let g:ref_pydoc_cmd = 'pydoc.bat'
  let g:ref_refe_encoding = 'cp932'
else
  let g:ref_pydoc_cmd = 'python3 -m pydoc'
endif

let g:ref_detect_filetype = {
      \ 'c': 'man', 'clojure': 'clojure', 'perl': 'perldoc', 'php': 'phpmanual', 'ruby': 'refe', 'erlang': 'erlang', 'python': 'pydoc'
      \}

MyAutocmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nmap <buffer> <Backspace> <Plug>(ref-back)
  nmap <buffer> <S-Backspace> <Plug>(ref-forward)
  setlocal nonumber
endfunction


" changelog.vim {{{2
MyAutocmd BufNewFile,BufRead *.changelog setfiletype changelog
let g:changelog_timeformat = '%Y-%m-%d'
let g:changelog_username = 'Hideki Hamada (jakalada)'


" quickrun.vim {{{2
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \'runner' : 'vimproc',
      \"runner/vimproc/updatetime" : 10
      \}

" Python
if s:ismacunix
  let g:quickrun_config.python = {
        \'command': 'python3',
        \'hook/eval/template': 'print(%s)'
        \}
elseif s:iswin
  let g:quickrun_config.python = {
        \'command': 'python',
        \'hook/eval/template': 'print(%s)'
        \}
else
  let g:quickrun_config.python = {
        \'command': 'python3',
        \'hook/eval/template': 'print(%s)'
        \}
endif

"RSpec
let g:quickrun_config['ruby.rspec'] = {
      \'command': 'bundle exec rspec',
      \'exec': '%c %s'
      \}

" Markdown
let g:quickrun_config['markdown'] = {
      \'command':  'redcarpet',
      \'cmdopt':   '--parse-fenced-code-blocks --parse-tables',
      \'exec':     '%c %o %s',
      \'outputter/buffer/filetype': 'html'
      \}


" tagbar {{{2
let g:tagbar_sort = 0
nnoremap <silent> <Leader>t :<C-U>TagbarToggle<CR>


" open-browser.vim  {{{2
nmap <C-O> <Plug>(openbrowser-smart-search)
vmap <C-O> <Plug>(openbrowser-smart-search)


" quickhl.vim {{{2
nmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>m <Plug>(quickhl-manual-this)
nmap <Leader>M <Plug>(quickhl-manual-reset)
xmap <Leader>M <Plug>(quickhl-manual-reset)

nmap <Leader>j <Plug>(quickhl-cword-toggle)
nmap <Leader>] <Plug>(quickhl-tag-toggle)


" Alignta {{{2
vnoremap aa :Alignta
vnoremap a= :Alignta =<CR>
vnoremap a+ :Alignta +<CR>


" textobj-multiblock {{{2
omap a; <Plug>(textobj-multiblock-a)
omap i; <Plug>(textobj-multiblock-i)
vmap a; <Plug>(textobj-multiblock-a)
vmap i; <Plug>(textobj-multiblock-i)

let g:textobj_multiblock_blocks = [
      \[ '(', ')' ],
      \[ '[', ']' ],
      \[ '{', '}' ],
      \[ '<', '>' ],
      \[ '"', '"' ],
      \[ "'", "'" ],
      \[ '`', '`' ],
      \[ '<', '>' ]
      \]


" gitgutter {{{2
let g:gitgutter_enabled = 1
nnoremap <Leader>gg  :<C-u>GitGutterToggle<CR>

" lightline {{{2
if s:isgui
  let g:lightline = {
        \ 'colorscheme': 'PaperColor',
        \ }
else
  let g:lightline = {
        \ 'colorscheme': 'PaperColor',
        \ }
endif

let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }
let g:lightline.active = { 'right': [[ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ],  ['linter_errors', 'linter_warnings', 'linter_ok' ] ] }

" markdown {{{2
let g:vim_markdown_folding_level = 2

" vim-slime {{{2
let g:slime_target = "tmux"

" vim-indent-guides {{{2
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 1
let g:indent_guides_color_change_percent = 4
let g:indent_guides_default_mapping = 0

" vim-clang-format {{{2
let g:clang_format#auto_format = 0
let g:clang_format#code_style = 'google'

" vim-go {{{2
let g:go_fmt_command = "goimports"

" ale {{{2
let g:ale_fix_on_save = 1

" asynccomplete {{{2
let g:asyncomplete_smart_completion = 1

" asynccomplete-lsp {{{2
let g:lsp_async_completion = 1

" vim-lsp {{{2
let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_preview_keep_focus = 0

" For Python
"   $ pip install python-language-server
" REF: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Python
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" For clang
"   $ brew install llvm
" REF: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Clangd
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" For CSS, LESS, Sass
"   $ npm install -g vscode-css-languageserver-bin
" REF: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Css
if executable('css-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass'],
        \ })
endif

" For Docker
"   $ npm install -g dockerfile-language-server-nodejs
" REF: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Docker
if executable('docker-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
endif

" For Go
"   $ go get -u golang.org/x/tools/cmd/golsp
" REF: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Go
if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
endif

" For Ruby
"   $ gem install solargraph
" REF: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Ruby
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

" For TypeScript
"   $ npm install -g typescript typescript-language-server
" REF: https://github.com/prabirshrestha/vim-lsp/wiki/Servers-TypeScript
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
      \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
      \ })
endif

" Misc {{{1
" 折りたたみ {{{2
nnoremap <SID>[fold] <Nop>
xnoremap <SID>[fold] <Nop>
nmap z <SID>[fold]
xmap z <SID>[fold]

noremap <SID>[fold]g [z
noremap <SID>[fold]G ]z
noremap <SID>[fold]j zj
noremap <SID>[fold]k zk

noremap <SID>[fold]l zo
noremap <SID>[fold]L zO
noremap <SID>[fold]h zc
noremap <SID>[fold]H zC
noremap <SID>[fold]t za
noremap <SID>[fold]T zA

noremap <SID>[fold]M zM
noremap <SID>[fold]m zm
noremap <SID>[fold]R zR
noremap <SID>[fold]r zr

noremap <silent> <SID>[fold]0 :<C-U>setl foldlevel=0<CR>
noremap <silent> <SID>[fold]1 :<C-U>setl foldlevel=1<CR>
noremap <silent> <SID>[fold]2 :<C-U>setl foldlevel=2<CR>
noremap <silent> <SID>[fold]3 :<C-U>setl foldlevel=3<CR>
noremap <silent> <SID>[fold]4 :<C-U>setl foldlevel=4<CR>
noremap <silent> <SID>[fold]5 :<C-U>setl foldlevel=5<CR>
noremap <silent> <SID>[fold]6 :<C-U>setl foldlevel=6<CR>
noremap <silent> <SID>[fold]7 :<C-U>setl foldlevel=7<CR>
noremap <silent> <SID>[fold]8 :<C-U>setl foldlevel=8<CR>
noremap <silent> <SID>[fold]9 :<C-U>setl foldlevel=9<CR>

set foldtext=getline(v:foldstart)


" タブページ {{{2
nnoremap <SID>[tab] <Nop>
nmap t <SID>[tab]

nnoremap <SID>[tabnew] <Nop>
nmap T <SID>[tabnew]

nnoremap <silent> <C-L> :<C-U>tabnext<CR>
nnoremap <silent> <C-H> :<C-U>tabprev<CR>
nnoremap <silent> <SID>[tab]q :<C-U>tabclose<CR>
nnoremap <silent> <SID>[tab]t :<C-U>tabnew<CR>

nnoremap <silent> <SID>[tabnew]n :<C-U>tabnew \| lcd $DROPBOXDIR/Notes<CR>
nnoremap <silent> <SID>[tabnew]v :<C-U>tabnew \| lcd $VIMCONFIGDIR<CR>

set showtabline=2

" ウィンドウ {{{2
nnoremap <SID>[window] <Nop>
nmap <Leader>w <SID>[window]

nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

nmap <SID>[window]j <SID>(split-to-j)
nmap <SID>[window]k <SID>(split-to-k)
nmap <SID>[window]h <SID>(split-to-h)
nmap <SID>[window]l <SID>(split-to-l)

nnoremap <silent> <SID>(split-to-j) :<C-U>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <silent> <SID>(split-to-k) :<C-U>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <silent> <SID>(split-to-h) :<C-U>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <silent> <SID>(split-to-l) :<C-U>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>


" コマンドラインウィンドウ {{{2
nnoremap <silent> ; q:
xnoremap <silent> ; q:
nnoremap <silent> / q/
nnoremap <silent> ? q?

MyAutocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin() " {{{
  nnoremap <buffer><silent> q :<C-U>quit<CR>
  inoremap <buffer><expr> <CR> pumvisible() ? '<C-Y><CR>' : '<CR>'
  nnoremap <buffer> ; <Nop>
  setlocal nonumber
  startinsert!
endfunction " }}}




" 空行を追加と削除を容易にする {{{2
" REF: http://deris.hatenablog.jp/entry/20130404/1365086716
nnoremap <silent> <Leader>o   :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader>O   :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Leader>O", v:count1)<CR>


" 最後に編集した位置に移動する {{{2
MyAutocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" カーソル位置を移動せずにファイル全体を整形する {{{2
" http://kannokanno.hatenablog.com/entry/2014/03/16/160109
function! s:format_file()
  let l:view = winsaveview()
  exe 'normal gg=G'
  silent call winrestview(l:view)
endfunction
nnoremap <C-F> :call <SID>format_file()<CR>


" vimrcに列挙しているプラグインのGithubのページを開く
function! s:open_github_page()
  let current_line = getline('.')
  let pattern = 'Plug ''\(.\{-}\)'''
  let m = matchlist(current_line, pattern)
  if len(m) >= 1
    silent call openbrowser#open('https://github.com/' . m[1])
  else
    echo 'no match'
  endif
endfunction
nnoremap <expr> <C-G>  <SID>open_github_page()

" }}}1

set secure  " must be written at the last.  see :help 'secure'.
