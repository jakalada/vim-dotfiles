"-------------------------------------------------------------------------
" hot_coffee's .vimrc
"-------------------------------------------------------------------------
" Initialize: "{{{
"

let s:iswin = has('win32') || has('win64')

if s:iswin
  " For Windows "{{{
  language message en

  " すでに読み込まれているファイル名には影響がないので注意する
  set shellslash

  let $DOTVIMDIR = expand('~/vimfiles')

  let $DROPBOXDIR = expand('~/Dropbox')

  let $VIMCONFIGDIR = expand('~/environment/vim')
  " }}}
else
  " For Linux "{{{
  language mes C

  let $DOTVIMDIR = expand('~/.vim')

  let $DROPBOXDIR = expand('~/Dropbox')

  let $VIMCONFIGDIR = expand('~/environment/vim')
  " }}}
endif

" pathogen "{{{
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype on
filetype plugin on
filetype indent on
" }}}

" }}}

"-------------------------------------------------------------------------
" Commands: "{{{
"
" from tyru's .vimrc {{{
" https://github.com/tyru
augroup vimrc
    autocmd!
augroup END

command!
\   -bang -nargs=*
\   MyAutocmd
\   autocmd<bang> vimrc <args>
" }}}
 
" Vim-users.jp - Hack #203: 定義されているマッピングを調べる {{{
" http://vim-users.jp/2011/02/hack203/
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>
" }}}

" for rails.vim {{{
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

" }}}

"-------------------------------------------------------------------------
" Functions: "{{{
"
function! SnipMid(str, len, mask) "{{{
  if a:len >= len(a:str)
    return a:str
  elseif a:len <= len(a:mask)
    return a:mask
  endif

  let len_head = (a:len - len(a:mask)) / 2
  let len_tail = a:len - len(a:mask) - len_head

  return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction " }}}
" }}}

"-------------------------------------------------------------------------
" Encoding: "{{{
"
" The automatic recognition of the character code.

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
set encoding=utf-8

" Setting of terminal encoding."{{{
if !has('gui_running')
  if &term == 'win32' || &term == 'win64'
    " Setting when use the non-GUI Japanese console.

    " Garbled unless set this.
    set termencoding=cp932
    " Japanese input changes itself unless set this.
    " Be careful because the automatic recognition of the character code is not possible!
    set encoding=japan
  else
    if $ENV_ACCESS ==# 'linux'
      set termencoding=euc-jp
    elseif $ENV_ACCESS ==# 'colinux'
      set termencoding=utf-8
    else  " fallback
      set termencoding=  " same as 'encoding'
    endif
  endif
elseif s:iswin
  " For system.
  set termencoding=cp932
endif
" }}}

" The automatic recognition of the character code."{{{
if !exists('did_encoding_settings') && has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Build encodings.
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else  " cp932
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis

  let did_encoding_settings = 1
endif
" }}}

if has('kaoriya')
  " For Kaoriya only.
  "set fileencodings=guess
endif

" When do not include Japanese, use encoding for fileencoding.
function! AU_ReCheck_FENC()
  if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
    let &fileencoding=&encoding
  endif
endfunction

MyAutocmd BufReadPost * call AU_ReCheck_FENC()

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac
" A fullwidth character is displayed in vim properly.
set ambiwidth=double

" Command group opening with a specific character code again."{{{
" In particular effective when I am garbled in a terminal.
" Open in UTF-8 again.
command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
" Open in iso-2022-jp again.
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
" Open in Shift_JIS again.
command! -bang -bar -complete=file -nargs=? Cp932 edit<bang> ++enc=cp932 <args>
" Open in EUC-jp again.
command! -bang -bar -complete=file -nargs=? Euc edit<bang> ++enc=euc-jp <args>
" Open in UTF-16 again.
command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
" Open in UTF-16BE again.
command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>

" Aliases.
command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>
" }}}

" Tried to make a file note version."{{{
" Don't save it because dangerous.
command! WUtf8 setlocal fenc=utf-8
command! WIso2022jp setlocal fenc=iso-2022-jp
command! WCp932 setlocal fenc=cp932
command! WEuc setlocal fenc=euc-jp
command! WUtf16 setlocal fenc=ucs-2le
command! WUtf16be setlocal fenc=ucs-2
" Aliases.
command! WJis  WIso2022jp
command! WSjis  WCp932
command! WUnicode WUtf16
" }}}

" Handle it in nkf and open.
command! Nkf !nkf -g %

" Appoint a line feed."{{{
command! -bang -bar -complete=file -nargs=? Unix edit<bang> ++fileformat=unix <args>
command! -bang -bar -complete=file -nargs=? Mac edit<bang> ++fileformat=mac <args>
command! -bang -bar -complete=file -nargs=? Dos edit<bang> ++fileformat=dos <args>
command! -bang -complete=file -nargs=? WUnix write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WMac write<bang> ++fileformat=mac <args> | edit <args>
command! -bang -complete=file -nargs=? WDos write<bang> ++fileformat=dos <args> | edit <args>
" }}}" }}}

"-------------------------------------------------------------------------
" Syntax: "{{{
"
syntax enable

" Ruby
let ruby_operators = 1

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_allow_cpp_keywords = 1

" PHP
let g:php_folding = 1

" Python
let g:python_highlight_all = 1

" XML
let g:xml_syntax_folding = 1

" Vim
let g:vimsyntax_noerror = 1

" Bash
let g:is_bash = 1

" Scheme
let g:is_gauche = 1
" }}}

"-------------------------------------------------------------------------
" Options: "{{{
"
" from tyru's .vimrc {{{
" https://github.com/tyru
let s:tmp = &runtimepath
set all&
let &runtimepath = s:tmp
unlet s:tmp
" }}}

setlocal autoindent
setlocal smartindent
setlocal smarttab
setlocal expandtab

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal shiftround

set backspace=indent,eol,start

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

augroup VimrcChecktime
  autocmd!
   MyAutocmd WinEnter * checktime
augroup END

" tags
if has('path_extra')
    set tags+=.;
    set tags+=tags;
endif
set showfulltag
set notagbsearch

if has('unix')
  set nofsync
  set swapsync=
endif

" search
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

set linespace=3

set number

set showcmd

set noequalalways

set list
set listchars=tab:>-,trail:-

set nowrap

colorscheme wombat256mod

" statusline "{{{
set laststatus=2
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$').(winnr('#')==winnr()?'#':'').']':''}\ %{expand('%:p:.')}\ %<\(%{SnipMid(getcwd(),80-len(expand('%:p:.')),'...')}\)\  %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}\ %3p%%"
" }}}

" }}}

"-------------------------------------------------------------------------
" Key-mappings: "{{{
"
" Use ',' instead of '\'.
"
" Leader " {{{
let mapleader = ' '
let g:mapleader = ' '
let g:maplocalleader = '\'

nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
nnoremap \ <Nop>
xnoremap \ <Nop>
" }}}

" mapmode-nvo "{{{
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

" mapmode-n "{{{
nnoremap <Backspace> <C-O>
nnoremap <S-Backspace> <C-I>

nnoremap <silent> <leader><leader> :<C-U>write<CR>

nnoremap <C-Up> <C-A>
nnoremap <C-Down> <C-X>

nnoremap Q q
nnoremap <silent> q :<C-U>close<CR>

" }}}

" mapmode-i "{{{
inoremap <C-J> <Esc>o
inoremap <C-K> <Esc>O

inoremap <S-Space> _
" }}}

" tab page mapping {{{
nnoremap <SID>[tab] <Nop>
nmap t <SID>[tab]

nnoremap <silent> <SID>[tab]l :<C-U>tabnext<CR>
nnoremap <silent> <SID>[tab]h :<C-U>tabprev<CR>
nnoremap <silent> <SID>[tab]q :<C-U>tabclose<CR>
nnoremap <silent> <SID>[tab]t :<C-U>tabnew<CR>
nnoremap <silent> <SID>[tab]tn :<C-U>tabnew $DROPBOXDIR/Notes<CR>
nnoremap <silent> <SID>[tab]tg :<C-U>tabnew $DROPBOXDIR/GTD<CR>
nnoremap <silent> <SID>[tab]tv :<C-U>tabnew $VIMCONFIGDIR<CR>
" }}}

" window mapping {{{
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
" }}}

" Hack #161: Command-line windowを使いこなす "{{{
" http://vim-users.jp/2010/07/hack161/
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-U>

nmap ; <SID>(command-line-enter)
xmap ; <SID>(command-line-enter)

nmap <leader>h <SID>(command-line-enter)help<Space>
nnoremap <silent> <leader>hh :<C-U>help<Space><C-R><C-W><CR>

MyAutocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <silent> <buffer> q :<C-U>quit<CR>
  startinsert!
endfunction
" }}}

" Quickly adding and deleting empty lines - Vim Tips Wiki "{{{
" http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines
function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction

function! AddEmptyLineAbove()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-E>
  end
  let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
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
endfunction

function! DelEmptyLineAbove()
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
endfunction

noremap <silent> Dj :call DelEmptyLineBelow()<CR>
noremap <silent> Dk :call DelEmptyLineAbove()<CR>
noremap <silent> Aj :call AddEmptyLineBelow()<CR>
noremap <silent> Ak :call AddEmptyLineAbove()<CR>
" }}}

" }}}

"-------------------------------------------------------------------------
" Plugin: "{{{
"
" vimfiler.vim "{{{
"nnoremap <silent> <leader>a :<C-U>VimFiler<CR>
" }}}

"nerdtree.vim "{{{
let g:NERDTreeChDirMode=1

nnoremap <silent> <leader>A :<C-U>NERDTree<CR>
nnoremap <silent> <leader>a :<C-U>NERDTreeToggle<CR>
" }}}

" unite.vim "{{{
" https://github.com/Shougo/unite.vim

" unite-variables
let g:unite_split_rule = 'botright'
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 60

" unite-source-variables
let g:unite_source_file_mru_time_format = '(%F %R)'

nnoremap <SID>[unite] <Nop>
xnoremap <SID>[unite] <Nop>
nmap f <SID>[unite]
xmap f <SID>[unite]

nnoremap <SID>[unite-no-quite] <Nop>
xnoremap <SID>[unite-no-quite] <Nop>
nmap F <SID>[unite-no-quite]
xmap F <SID>[unite-no-quite]

nnoremap <silent> <SID>[unite]F :<C-U>Unite -input=/ -buffer-name=files file bookmark file_mru<CR>
nnoremap <silent> <SID>[unite]f :<C-U>Unite -buffer-name=files file<CR>
nnoremap <silent> <SID>[unite]b :<C-U>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite]r :<C-U>Unite -buffer-name=register register<CR>
nnoremap <silent> <SID>[unite]t :<C-U>Unite -buffer-name=tab tab<CR>
nnoremap <silent> <SID>[unite]o :<C-U>Unite -vertical -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite]m :<C-U>Unite -buffer-name=mark mark<CR>
nnoremap <silent> <SID>[unite]h :<C-U>Unite -buffer-name=help help<CR>

nnoremap <silent> <SID>[unite-no-quite]F :<C-U>Unite -no-quite -input=/ -buffer-name=files file bookmark file_mru<CR>
nnoremap <silent> <SID>[unite-no-quite]f :<C-U>Unite -no-quite -buffer-name=files file<CR>
nnoremap <silent> <SID>[unite-no-quite]b :<C-U>Unite -no-quite -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite-no-quite]r :<C-U>Unite -no-quite -buffer-name=register register<CR>
nnoremap <silent> <SID>[unite-no-quite]t :<C-U>Unite -no-quite -buffer-name=tab tab<CR>
nnoremap <silent> <SID>[unite-no-quite]o :<C-U>Unite -no-quite -vertical -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite-no-quite]m :<C-U>Unite -no-quite -buffer-name=mark mark<CR>
nnoremap <silent> <SID>[unite-no-quite]h :<C-U>Unite -no-quite -buffer-name=help help<CR>

nnoremap <silent> <leader>b :<C-U>UniteBookmarkAdd<CR>

" for unite-grep
let g:unite_source_grep_default_opts = '-iRHn'

" }}}

" zen-coding {{{
let g:user_zen_settings = {
      \ 'html' : {
      \   'indentation' : '  '
      \ },
      \}
" }}}

" unite-neco {{{
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

"function! unite#sources#locate#define()
"  return executable('locate') ? s:unite_source : []
"endfunction
call unite#define_source(s:unite_source)
" }}}

" neocomplcache.vim "{{{
" https://github.com/Shougo/neocomplcache
"
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_snippets_dir = '~/.vim/snippets'
" let g:neocomplcache_enable_cursor_hold_i = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_text_mode_filetypes = {}
let g:neocomplcache_text_mode_filetypes.markdown = 1

nnoremap <silent> <leader>.s :<C-U>NeoComplCacheEditSnippets<CR>
imap <expr><C-O> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-N>"
inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><C-L>  neocomplcache#complete_common_string()

" if !exists('g:neocomplcache_omni_patterns')
"   let g:neocomplcache_omni_patterns = {}
" endif
" let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" }}}

" vim-ref "{{{
if s:iswin
  let g:ref_pydoc_cmd = 'pydoc.bat'
  let g:ref_refe_encoding = 'cp932'
else
  let g:ref_refe_encoding = 'euc-jp'
endif

let g:ref_detect_filetype = {
      \ 'c': 'man', 'clojure': 'clojure', 'perl': 'perldoc', 'php': 'phpmanual', 'ruby': 'refe', 'erlang': 'erlang', 'python': 'pydoc'
      \}

autocmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nmap <buffer> <Backspace> <Plug>(ref-back)
  nmap <buffer> <S-Backspace> <Plug>(ref-forward)
  setlocal nonumber
endfunction
" }}}

" changelog.vim "{{{
MyAutocmd BufNewFile,BufRead *.changelog setf changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Hideki Hamada (jakalada)"
" }}}

" surround.vim "{{{
nmap s ys
nmap S yS
nmap ss yss
nmap SS ySS
" }}}

" quickrun.vim "{{{
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
\ 'command': 'kramdown',
\ 'exec': '%c %s'
\ }
" }}}

" vim-fugitive "{{{
nnoremap <SID>[fugitive] <Nop>
xnoremap <SID>[fugitive] <Nop>
nmap <Leader>g <SID>[fugitive]
xmap <Leader>g <SID>[fugitive]

nmap <silent> <SID>[fugitive]g <SID>(command-line-enter)Git<Space>
nnoremap <silent> <SID>[fugitive]b :<C-U>Gblame<CR>
nnoremap <silent> <SID>[fugitive]c :<C-U>Gcommit<CR>
nnoremap <silent> <SID>[fugitive]s :<C-U>Gstatus<CR>
" }}}

" vim-coffee-script " {{{
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
" }}}

" open-browser.vim " {{{
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
" }}}

" eskk.vim " {{{
let g:eskk#large_dictionary = {
      \ 'path': '~/.dict/SKK-JISYO.L',
      \ 'sorted': 0,
      \ 'encoding': 'euc-jp'
      \}
let g:eskk#show_candidates_count = 1
let g:eskk#show_annotation = 1

let g:eskk#marker_henkan = '_'
let g:eskk#marker_henkan_select = '?'
let g:eskk#marker_jisyo_touroku = '#'
let g:eskk#dictionary_save_count = 1
imap <C-u> <Plug>(eskk:toggle)

MyAutocmd User eskk-initialize-pre call s:eskk_initial_pre()
function! s:eskk_initial_pre()
    " User can be allowed to modify
    " eskk global variables (`g:eskk#...`)
    " until `User eskk-initialize-pre` event.
    " So user can do something heavy process here.
    " (I'm a paranoia, eskk#table#new() is not so heavy.
    " But it loads autoload/vice.vim recursively)
  let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
  call t.add_map('z~', '〜')
  call t.add_map('va', 'ゔぁ')
  call t.add_map('vi', 'ゔぃ')
  call t.add_map('vu', 'ゔ')
  call t.add_map('ve', 'ゔぇ')
  call t.add_map('vo', 'ゔぉ')
  call t.add_map('z ', '　')
  call eskk#register_mode_table('hira', t)
endfunction
" }}}

" }}}

" }}}

set secure  " must be written at the last.  see :help 'secure'.
