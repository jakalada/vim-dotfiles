
" ========================
" SECTION: Initialize {{{1
" ========================

" .vimrcの再読み込み時にオプションを初期化する {{{
" 設定されたruntimepathが初期化されないようにする
let s:tmp = &runtimepath
set all&
let &runtimepath = s:tmp
unlet s:tmp
" }}}

let s:iswin = has('win32') || has('win64')

let s:isgui = has("gui_running")

if s:iswin
  " For Windows {{{
  language message en

  " すでに読み込まれているファイル名には影響がないので注意する
  set shellslash

  let $DOTVIMDIR = expand('~/vimfiles')

  let $DROPBOXDIR = expand('~/Dropbox')

  let $VIMCONFIGDIR = expand('~/project/vim-dotfiles')
  " }}}
else
  " For Linux {{{
  language message C

  let $DOTVIMDIR = expand('~/.vim')

  let $DROPBOXDIR = expand('~/Dropbox')

  let $VIMCONFIGDIR = expand('~/project/vim-dotfiles')
  " }}}
endif

" pathogen.vim {{{
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype on
filetype plugin on
filetype indent on
" }}}

" ======================
" SECTION: Commands {{{1
" ======================

" .vimrcの再読み込み時に.vimrc内で設定されたautocmdを初期化する
" MyAutocmdを使用することで漏れなく初期化できる
" {{{
augroup vimrc
    autocmd!
augroup END

command!
\   -bang -nargs=*
\   MyAutocmd
\   autocmd<bang> vimrc <args>
" }}}

" 定義されているマッピングを調べるコマンドを定義する
" {{{
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>
" }}}

" For rails.vim
 " {{{
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

" =======================
" SECTION: Functions {{{1
" =======================

" statullineの設定に使用する
function! SnipMid(str, len, mask) " {{{
  if a:len >= len(a:str)
    return a:str
  elseif a:len <= len(a:mask)
    return a:mask
  endif

  let len_head = (a:len - len(a:mask)) / 2
  let len_tail = a:len - len(a:mask) - len_head

  return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction
" }}}

" ======================
" SECTION: Encoding {{{1
" ======================

" fileencodingの設定 {{{
set fileencodings=iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,euc-jp,eucjp-ms,cp932
set encoding=utf-8

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

" ====================
" SECTION: Syntax {{{1
" ====================

syntax enable

if s:isgui
  colorscheme rdark
else
  set t_Co=256
  colorscheme wombat256mod
endif

MyAutocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
MyAutocmd BufWinEnter,BufNewFile *_spec.coffee set filetype=coffee.jasmine
MyAutocmd BufWinEnter,BufNewFile *_spec.coffee set filetype=coffee.vows

" ft-ruby-syntax
let ruby_operators = 1

" ft-java-syntax
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_allow_cpp_keywords = 1

" ft-php-syntax
let g:php_folding = 1

" ft-python-syntax
let g:python_highlight_all = 1

" ft-xml-syntax
let g:xml_syntax_folding = 1

" ft-vim-syntax
let g:vimsyntax_noerror = 1

" ft-sh-syntax
let g:is_bash = 1

" =====================
" SECTION: Options {{{1
" =====================

if s:isgui
  set guioptions=aci
  set guifont=Ricty\ Discord\ 13.5
  set mouse=a
  set mousehide
  set mousefocus
  set visualbell
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0
  set guicursor+=i-ci:ver25-Cursor/lCursor-blinkon0,r-cr:hor20-Cursor/lCursor-blinkon0
  set guicursor+=sm:block-Cursor-blinkon0
  let loaded_matchparen = 1
endif

set nocursorline
set cmdheight=2
set showtabline=2

setlocal autoindent
setlocal smartindent
setlocal smarttab
setlocal expandtab

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal shiftround

set backspace=indent,eol,start

set nojoinspaces

setlocal matchpairs+=<:>

setlocal iskeyword+=-

set hidden

set directory-=.
if v:version >= 703
  set undofile
  let &undodir=&directory
endif

if has('virtualedit')
  set virtualedit=block
endif

set scrolloff=10

set helplang=ja

MyAutocmd WinEnter * checktime
set autoread

set showfulltag
set notagbsearch

if has('unix')
  set nofsync
  set swapsync=
endif

" search {{{
set incsearch
set ignorecase
set smartcase
set wrapscan

nnoremap <silent> / :<C-U>setlocal hlsearch<CR>/
nnoremap <silent> ? :<C-U>setlocal hlsearch<CR>?
nnoremap <silent> n :<C-U>setlocal hlsearch<CR>n
nnoremap <silent> N :<C-U>setlocal hlsearch<CR>N
nnoremap <silent> v :<C-U>setlocal nohlsearch<CR>v
nnoremap <silent> <C-V> :<C-U>setlocal nohlsearch<CR><C-V>
nnoremap <silent> V :<C-U>setlocal nohlsearch<CR>V
MyAutocmd InsertEnter * setlocal nohlsearch
" }}}

set linespace=3

set number

set showcmd

set noequalalways

set list
set listchars=tab:>-,trail:-

set fillchars=vert:\ ,fold:\ ,diff:\ 

set showbreak=↪

set wrap

set textwidth=0

" statusline {{{
set laststatus=2
let &statusline="%<\(%{fnamemodify(getcwd(), ':~')}\)\ %{expand('%:p:.')}\%=%m%r%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}\ %3p%%"
" }}}

set nomodeline

set foldopen=block,quickfix,search,tag,undo

" ==========================
" SECTION: Key-mappings {{{1
" ==========================

"-----------
" Leader {{{
"-----------

let mapleader = ' '
let g:mapleader = ' '
let g:maplocalleader = '\'

nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
nnoremap \ <Nop>
xnoremap \ <Nop>
" }}}

"----------------
" mapmode-nvo {{{
"----------------

noremap j gj
noremap k gk
noremap <C-J> <C-D>
noremap <C-K> <C-U>
noremap <C-L> <C-E>
noremap <C-H> <C-Y>

noremap L $
noremap H ^
noremap gj L
noremap gm M
noremap gk H
" }}}

"--------------
" mapmode-n {{{
"--------------
nnoremap <Leader>k <C-^>

nnoremap <Backspace> <C-O>
nnoremap <S-Backspace> <C-I>

nnoremap <silent> <leader><leader> :<C-U>write<CR>

nnoremap <C-Up> <C-A>
nnoremap <C-Down> <C-X>

nnoremap Q q
nnoremap <silent> q :<C-U>close<CR>

nnoremap <C-Backspace> <C-^>

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" }}}

"--------------
" mapmode-i {{{
"--------------

inoremap ii <Esc>

inoremap <C-K> <Esc>O
inoremap <C-J> <Esc>o

inoremap <silent> <C-L> <Right>
inoremap <silent> <C-H> <Left>

inoremap <silent> <F7> <Esc>gUiwea
" }}}
"
"--------------
" mapmode-ic {{{
"--------------

noremap! ; :
noremap! : ;

" }}}

" ============================
" SECTION: 少し大きい設定 {{{1
" ============================

" ---------------
" タブページ {{{2
" ---------------

nnoremap <SID>[tab] <Nop>
nmap t <SID>[tab]

nnoremap <silent> <SID>[tab]l :<C-U>tabnext<CR>
nnoremap <silent> <SID>[tab]h :<C-U>tabprev<CR>
nnoremap <silent> <SID>[tab]q :<C-U>tabclose<CR>
nnoremap <silent> <SID>[tab]tt :<C-U>tabnew<CR>

nnoremap <silent> <SID>[tab]tn :<C-U>tabnew \| lcd $DROPBOXDIR/Notes<CR>
nnoremap <silent> <SID>[tab]tl :<C-U>tabnew \| lcd $DROPBOXDIR/Lists<CR>
nnoremap <silent> <SID>[tab]tv :<C-U>tabnew \| lcd $VIMCONFIGDIR<CR>
nnoremap <silent> <SID>[tab]tc :<C-U>execute 'tabnew \| lcd ' . $DROPBOXDIR . '/Notes/cheat/filetypes/' . &filetype<CR>

" ---------------
" ウィンドウ {{{2
" ---------------

nnoremap <SID>[window] <Nop>
nmap $ <SID>[window]

nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

nmap <SID>[window]sj <SID>(split-to-j)
nmap <SID>[window]sk <SID>(split-to-k)
nmap <SID>[window]sh <SID>(split-to-h)
nmap <SID>[window]sl <SID>(split-to-l)

nnoremap <silent> <SID>(split-to-j) :<C-U>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <silent> <SID>(split-to-k) :<C-U>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <silent> <SID>(split-to-h) :<C-U>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <silent> <SID>(split-to-l) :<C-U>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>

" -----------------------------
" コマンドラインウィンドウ {{{2
" -----------------------------

nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-U>

nnoremap ; <Nop>
xnoremap ; <Nop>

nmap ; <SID>(command-line-enter)
xmap ; <SID>(command-line-enter)

nmap <leader>h <SID>(command-line-enter)help<Space>
nnoremap <silent> <leader>hh :<C-U>help<Space><C-R><C-W><CR>

MyAutocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin() " {{{
  nnoremap <silent> <buffer> q :<C-U>quit<CR>
  startinsert!
endfunction " }}}

" ---------------------------------
" 空行を追加と削除を容易にする {{{2
" ---------------------------------

function! AddEmptyLineBelow() " {{{
  call append(line("."), "")
endfunction " }}}

function! AddEmptyLineAbove() " {{{
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-E>
  end
  let &scrolloff = l:scrolloffsave
endfunction " }}}

function! DelEmptyLineBelow() " {{{
  if line(".") == line("$")
    return
  end
  let l:line = getline(line(".") + 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .+1d
    ''
    call cursor(line("."), l:colsave)
  end
endfunction " }}}

function! DelEmptyLineAbove() " {{{
  if line(".") == 1
    return
  end
  let l:line = getline(line(".") - 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .-1d
    silent normal! <C-Y>
    call cursor(line("."), l:colsave)
  end
endfunction " }}}

noremap <silent> Dj :call DelEmptyLineBelow()<CR>
noremap <silent> Dk :call DelEmptyLineAbove()<CR>
noremap <silent> Aj :call AddEmptyLineBelow()<CR>
noremap <silent> Ak :call AddEmptyLineAbove()<CR>

" --------------------------------------------------------
" Vimで静的にシンタックスチェックを行なう {{{2
" via http://d.hatena.ne.jp/osyo-manga/20110921/1316605254
" --------------------------------------------------------


" for vim-hier {{{
highlight qf_error_ucurl gui=underline guifg=yellow guibg=NONE
highlight qf_error_ucurl cterm=underline ctermfg=yellow ctermbg=NONE
let g:hier_highlight_group_qf  = "qf_error_ucurl"
" }}}

" outputter/quickfixをquickrunに登録 {{{
let s:silent_quickfix = quickrun#outputter#quickfix#new()
function! s:silent_quickfix.finish(session)
    call call(quickrun#outputter#quickfix#new().finish, [a:session], self)
    :cclose
    :HierUpdate
    :QuickfixStatusEnable
endfunction
call quickrun#register_outputter("silent_quickfix", s:silent_quickfix)
" }}}

" for ruby {{{
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config["RubySyntaxCheck_ruby"] = {
    \ "exec"      : "%c %o %s:p ",
    \ "command"   : "ruby",
    \ "cmdopt"    : "-cw",
    \ "outputter" : "silent_quickfix",
    \ "runner"    : "vimproc"
\ }

autocmd BufWritePost *.rb :QuickRun RubySyntaxCheck_ruby
" }}}

" }}}2

" ======================
" SECTION: Plugins {{{1
" ======================

" ----------------------
" PLUGIN: vim-toggle {{{2
" ----------------------

nmap - <Plug>ToggleN

" ------------------------
" PLUGIN: matchit.vim {{{2
" ------------------------

runtime macros/matchit.vim

" --------------------
" PLUGIN: caw.vim {{{2
" --------------------

nmap gcc <Plug>(caw:wrap:toggle)

" -------------------------
" PLUGIN: vimfiler.vim {{{2
" -------------------------

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_split_action = "split"
let g:vimfiler_time_format = "%Y/%m/%d %H:%M"
let g:unite_kind_file_delete_file_command = 'trash-put $srcs'
let g:unite_kind_file_delete_directory_command = 'trash-put -rf $srcs'

nnoremap <silent> <leader>a :<C-U>VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quite<CR>
nnoremap <silent> <leader>A :<C-U>VimFiler<CR>

" ---------------------
" PLUGIN: unite.vim {{{2
" ----------------------

" unite-variables
let g:unite_split_rule = 'botright'
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 60

" unite-source-variables
let g:unite_source_file_mru_time_format = '(%F %R)'
let g:unite_source_grep_max_candidates = 1000

nnoremap <SID>[unite] <Nop>
xnoremap <SID>[unite] <Nop>
nmap f <SID>[unite]
xmap f <SID>[unite]

nnoremap <SID>[unite-no-quite] <Nop>
xnoremap <SID>[unite-no-quite] <Nop>
nmap F <SID>[unite-no-quite]
xmap F <SID>[unite-no-quite]

nnoremap <silent> <SID>[unite]<Space> :<C-U>UniteResume<CR>

nnoremap <silent> <SID>[unite]F :<C-U>Unite -buffer-name=files bookmark directory_mru file_mru<CR>
nnoremap <silent> <SID>[unite]f :<C-U>Unite -buffer-name=files file<CR>
nnoremap <silent> <SID>[unite]b :<C-U>Unite -buffer-name=buffer_tab buffer_tab<CR>
nnoremap <silent> <SID>[unite]B :<C-U>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite]r :<C-U>Unite -buffer-name=register register<CR>
nnoremap <silent> <SID>[unite]t :<C-U>Unite -buffer-name=tab tab:no-current<CR>
nnoremap <silent> <SID>[unite]w :<C-U>Unite -buffer-name=window window:no-current<CR>
nnoremap <silent> <SID>[unite]o :<C-U>Unite -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite]m :<C-U>Unite -buffer-name=mark mark<CR>
nnoremap <silent> <SID>[unite]h :<C-U>Unite -buffer-name=help help<CR>
nnoremap <silent> <SID>[unite]l :<C-U>Unite -buffer-name=line line<CR>
nnoremap <silent> <SID>[unite]H :<C-U>Unite -buffer-name=refe -input=ref source<CR>
nnoremap <silent> <SID>[unite]R :<C-U>Unite -buffer-name=rails -input=rails source<CR>
nnoremap <silent> <SID>[unite]s :<C-U>Unite -buffer-name=snippet snippet<CR>
nnoremap <silent> <SID>[unite]q :<C-U>Unite -buffer-name=qf qf<CR>

nnoremap <silent> <SID>[unite-no-quite]F :<C-U>Unite -no-quite -buffer-name=files bookmark directory_mru file_mru<CR>
nnoremap <silent> <SID>[unite-no-quite]f :<C-U>Unite -no-quite -buffer-name=files file<CR>
nnoremap <silent> <SID>[unite-no-quite]b :<C-U>Unite -no-quite -buffer-name=buffer_tab buffer_tab<CR>
nnoremap <silent> <SID>[unite-no-quite]B :<C-U>Unite -no-quite -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite-no-quite]r :<C-U>Unite -no-quite -buffer-name=register register<CR>
nnoremap <silent> <SID>[unite-no-quite]t :<C-U>Unite -no-quite -buffer-name=tab tab:no-current<CR>
nnoremap <silent> <SID>[unite-no-quite]w :<C-U>Unite -no-quite -buffer-name=window window:no-current<CR>
nnoremap <silent> <SID>[unite-no-quite]o :<C-U>Unite -no-quite -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite-no-quite]m :<C-U>Unite -no-quite -buffer-name=mark mark<CR>
nnoremap <silent> <SID>[unite-no-quite]h :<C-U>Unite -no-quite -buffer-name=help help<CR>
nnoremap <silent> <SID>[unite-no-quite]l :<C-U>Unite -no-quite -buffer-name=line line<CR>
nnoremap <silent> <SID>[unite-no-quite]H :<C-U>Unite -no-quite -buffer-name=refe -input=ref source<CR>
nnoremap <silent> <SID>[unite-no-quite]R :<C-U>Unite -no-quite -buffer-name=rails -input=rails source<CR>
nnoremap <silent> <SID>[unite-no-quite]s :<C-U>Unite -no-quite -buffer-name=snippet snippet<CR>
nnoremap <silent> <SID>[unite-no-quite]q :<C-U>Unite -no-quite -buffer-name=qf qf<CR>

" menu-fugitive
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.fugitive = {
      \     'description' : 'fugitive menu',
      \ }
let g:unite_source_menu_menus.fugitive.candidates = {
      \       'add'      : 'Gwrite',
      \       'blame'      : 'Gblame',
      \       'diff'      : 'Gdiff',
      \       'commit'      : 'Gcommit',
      \       'status'      : 'Gstatus',
      \       'rm'      : 'Gremove',
      \     }
function g:unite_source_menu_menus.fugitive.map(key, value)
  return {
        \       'word' : a:key, 'kind' : 'command',
        \       'action__command' : a:value,
        \     }
endfunction

nnoremap <silent> <SID>[unite]g :<C-u>Unite menu:fugitive<CR>

" ----------------
" PLUGIN: altr {{{2
" ----------------

nmap <Leader>n  <Plug>(altr-forward)
nmap <Leader>p  <Plug>(altr-back)

call altr#define('spec/%_spec.rb', 'lib/%.rb')
call altr#define('src/lib/*/%.coffee', 'spec/*/%_spec.coffee')
call altr#define('src/lib/%.coffee', 'spec/%_spec.coffee')

" -----------------------
" PLUGIN: unite-neco {{{2
" -----------------------

let s:unite_source = {'name': 'neco'}

function! s:unite_source.gather_candidates(args, context)
  let necos = [
        \ "~(-'_'-) goes right",
        \ "~(-'_'-) goes right and left",
        \ "~(-'_'-) goes right quickly",
        \ "~(-'_'-) goes right then smile",
        \ "~(-'_'-)  -8(*'_'*) go right and left",
        \ "(=' .' ) ~w",
        \ ]
  return map(necos, '{
        \ "word": v:val,
        \ "source": "neco",
        \ "kind": "command",
        \ "action__command": "Neco " . v:key,
        \ }')
endfunction
call unite#define_source(s:unite_source)

" -----------------------
" PLUGIN: rsense.vim {{{2
" -----------------------

let g:rsenseHome = expand('$RSENSE_HOME')
let g:rsenseUseOmniFunc = 1

" --------------------
" PLUGIN: vimshell {{{2
" --------------------

let g:vimshell_prompt = '$ '
let g:vimshell_user_prompt = '"[" . getcwd() ."]"'

" -----------------------------
" PLUGIN: neocomplcache.vim {{{2
" -----------------------------

" for rsense.vim {{{
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" }}}


if !exists('g:neocomplcache_dictionary_filetype_lists')
let g:neocomplcache_dictionary_filetype_lists = {
      \'jasmine': expand('~/.vim/dict/jasmine.dict')
      \}
let g:neocomplcache_dictionary_filetype_lists = {
      \'vows': expand('~/.vim/dict/vows.dict')
      \}
endif


let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 0
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_snippets_dir = expand('~/.vim/snippets')
let g:neocomplcache_enable_cursor_hold_i = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_menu_width = 50

nnoremap <silent> <leader>.s :<C-U>NeoComplCacheEditSnippets<CR>
imap <expr><C-O> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-N>"
inoremap <expr><C-C> neocomplcache#complete_common_string()
imap <C-f> <Plug>(neocomplcache_start_unite_complete)

" --------------------
" PLUGIN: vim-ref {{{2
" --------------------

if s:iswin
  let g:ref_pydoc_cmd = 'pydoc.bat'
  let g:ref_refe_encoding = 'cp932'
else
  let g:ref_refe_encoding = 'euc-jp'
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

" --------------------------
" PLUGIN: changelog.vim {{{2
" --------------------------

MyAutocmd BufNewFile,BufRead *.changelog setf changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Hideki Hamada (jakalada)"

" ------------------------
" PLUGIN: surround.vim {{{2
" ------------------------

nmap s ys
nmap S yS
nmap ss yss
nmap SS ySS

" -------------------------
" PLUGIN: quickrun.vim {{{2
" -------------------------

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec'}
let g:quickrun_config['markdown'] = {
\ 'command': 'kramdown',
\ 'exec': '%c %s'
\ }

" ------------------------------
" PLUGIN: vim-coffee-script {{{2
" ------------------------------

augroup MyCoffeeScriptAutoMake
    autocmd!
augroup END

command!
\   -bang -nargs=*
\   ToggleCoffeeScriptAutoMake
\   call s:toggle_coffee_script_auto_make()


let g:my_coffee_script_auto_make = 0
function! s:toggle_coffee_script_auto_make()
  if g:my_coffee_script_auto_make == 1
    augroup MyCoffeeScriptAutoMake
        autocmd!
    augroup END
    let g:my_coffee_script_auto_make = 0
  else
    autocmd MyCoffeeScriptAutoMake BufWritePost *.coffee silent CoffeeMake!
    let g:my_coffee_script_auto_make = 1
  endif
endfunction

" ------------------------------
" PLUGIN: open-browser.vim  {{{2
" ------------------------------

if !exists('g:openbrowser_open_commands')
  let g:openbrowser_open_commands = ['google-chrome', 'firefox']
endif

if !exists('g:openbrowser_open_rules')
  let g:openbrowser_open_rules = {
        \ 'google-chrome': '{browser} {shellescape(uri)}',
        \ 'firefox': '{browser} {shellescape(uri)}',
        \ }
endif

if !exists('g:openbrowser_search_engines')
    let g:openbrowser_search_engines = {
    \   'google': 'http://google.co.jp/search?q={query}',
    \}
endif

nmap <Leader>o <Plug>(openbrowser-smart-search)
vmap <Leader>o <Plug>(openbrowser-smart-search)

" ----------------------
" PLUGIN: eskk.vim  {{{2
" ----------------------

" let g:eskk#large_dictionary = {
"       \ 'path': '~/.dict/SKK-JISYO.L',
"       \ 'sorted': 0,
"       \ 'encoding': 'euc-jp'
"       \}
" let g:eskk#show_candidates_count = 1
" let g:eskk#kakutei_when_unique_candidate = 1
" let g:eskk#dictionary_save_count = 1
" 
" let g:eskk#marker_henkan = '_'
" let g:eskk#marker_henkan_select = '?'
" let g:eskk#marker_jisyo_touroku = '#'
" 
" MyAutocmd User eskk-initialize-pre call s:eskk_initial_pre()
" function! s:eskk_initial_pre()
"     " User can be allowed to modify
"     " eskk global variables (`g:eskk#...`)
"     " until `User eskk-initialize-pre` event.
"     " So user can do something heavy process here.
"     " (I'm a paranoia, eskk#table#new() is not so heavy.
"     " But it loads autoload/vice.vim recursively)
"   let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
"   call t.add_map('z~', '〜')
"   call t.add_map('va', 'ゔぁ')
"   call t.add_map('vi', 'ゔぃ')
"   call t.add_map('vu', 'ゔ')
"   call t.add_map('ve', 'ゔぇ')
"   call t.add_map('vo', 'ゔぉ')
"   call t.add_map('z ', '　')
"   call eskk#register_mode_table('hira', t)
" endfunction

" }}}2

" }}}1

set secure  " must be written at the last.  see :help 'secure'.
