"-------------------------------------------------------------------------
" hot_coffee's .vimrc
"-------------------------------------------------------------------------
" Initialize: "{{{
"

let s:iswin = has('win32') || has('win64')

" Use English interface.
if s:iswin
  " For Windows.
  language message en
else
  " For Linux.
  language mes C
endif

" Use ',' instead of '\'.
" It is not mapped with respect well unless I set it before setting for plug in.
let mapleader = ','
" Use <Leader> in global plugin.
let g:mapleader = ','
" Use <LocalLeader> in filetype plugin.
let g:maplocalleader = '\'

" Release keymappings for plug-in.
nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap , <Nop>
xnoremap , <Nop>
nnoremap \ <Nop>
xnoremap \ <Nop>

if s:iswin
  " Exchange path separator.
  set shellslash
endif

" In Windows/Linux, take in a difference of ".vim" and "$VIM/vimfiles".
let $DOTVIM = expand('~/.vim')

" Because a value is not set in $MYGVIMRC with the console, set it.
if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif


filetype plugin on
filetype indent on

augroup MyAutoCmd
  autocmd!
augroup END

" Set runtimepath.
if s:iswin
  let &runtimepath = join([expand('~/.vim'), expand('$VIM/runtime'), expand('~/.vim/after')], ',')
endif

" Load bundles.
call pathogen#runtime_append_all_bundles()
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

autocmd MyAutoCmd BufReadPost * call AU_ReCheck_FENC()

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
" Search: "{{{
"
set noincsearch
set ignorecase
set smartcase
set wrapscan

" hlsearch only searching."{{{
nnoremap <silent> / :<C-u>setlocal hlsearch<CR>/
nnoremap <silent> ? :<C-u>setlocal hlsearch<CR>?
nnoremap <silent> n :<C-u>setlocal hlsearch<CR>n
nnoremap <silent> N :<C-u>setlocal hlsearch<CR>N
nnoremap <silent> v :<C-u>setlocal nohlsearch<CR>v
nnoremap <silent> <C-v> :<C-u>setlocal nohlsearch<CR><C-v>
nnoremap <silent> V :<C-u>setlocal nohlsearch<CR>V
autocmd MyAutoCmd InsertEnter * setlocal nohlsearch
" }}}

" }}}

"-------------------------------------------------------------------------
" Edit: "{{{
"
set nocompatible
set smarttab expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround

set modeline

set clipboard& clipboard+=unnamed

autocmd MyAutoCmd FileType * set textwidth=0

set backspace=indent,eol,start

set showmatch
set cpoptions-=m
set matchtime=3
" Highlight <>.
set matchpairs+=<:>

set hidden

set infercase

set cdpath+=~

set directory-=.

if v:version >= 703
  set undofile
  let &undodir=&directory
endif

set virtualedit=block

set helplang=ja
" }}}

"-------------------------------------------------------------------------
" View: "{{{
"
set linespace=3

set number
set numberwidth=3

set showcmd
set cmdheight=2

set noequalalways

set list
set listchars=tab:>-,trail:-,extends:>,precedes:<

set linebreak
set showbreak=>\
set breakat=\ \	;:,!?

colorscheme wombat256mod

" statusline "{{{
set laststatus=2
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$').(winnr('#')==winnr()?'#':'').']':''}\ %{expand('%:p:.')}\ %<\(%{SnipMid(getcwd(),80-len(expand('%:p:.')),'...')}\)\ %{cfi#format('(%s())', '(no function)')}\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}\ %3p%%"
" }}}

" window title "{{{
set title
" Title length.
set titlelen=95
" Title string.
let &titlestring="%{expand('%:p:.')}%(%m%r%w%) %<\(%{SnipMid(getcwd(),80-len(expand('%:p:.')),'...')}\) - Vim"
" }}}

" }}}

"-------------------------------------------------------------------------
" Syntax: "{{{
"
syntax enable

augroup MyAutoCmd "{{{
  " Close help and git window by pressing q.
  autocmd FileType help,git-status,git-log,qf,gitcommit,quickrun,qfreplace,ref,simpletap-summary nnoremap <buffer><silent> q :<C-u>close<CR>
  autocmd FileType * if &readonly |  nnoremap <buffer><silent> q :<C-u>close<CR> | endif
augroup END
" }}}

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
" }}}

"-------------------------------------------------------------------------
" Plugin: "{{{
"
" unite.vim "{{{
" https://github.com/Shougo/unite.vim
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_enable_split_vertically=1
let g:unite_enable_start_insert=1

nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap f [unite]
xmap f [unite]
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file bookmark file_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]t :<C-u>Unite -buffer-name=tab tab<CR>
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mark mark<CR>
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> <leader>b :<C-u>UniteBookmarkAdd<CR>

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

" }}}

" neocomplcache.vim "{{{
" https://github.com/Shougo/neocomplcache
"
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_snippets_dir = '~/.vim/snippets'

nnoremap <silent> <leader>.s :<C-u>NeoComplCacheEditSnippets<CR>
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<TAB>"
inoremap <S-TAB> <C-p>
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-f> neocomplcache#manual_filename_complete()
inoremap <expr><C-o> neocomplcache#manual_omni_complete()
inoremap <expr><C-k> neocomplcache#manual_keyword_complete()

" for rsense.vim
let g:rsenseUseOmniFunc = 1

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" }}}

" vim-quickrun "{{{
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = { 'command': 'kramdown'}
" }}}

" vim-ref "{{{
if s:iswin
  let g:ref_pydoc_cmd = 'pydoc.bat'
  let g:ref_refe_encoding = 'cp932'
else
  let g:ref_refe_encoding = 'euc-jp'
endif

autocmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nmap <buffer> <Backspace> <Plug>(ref-back)
  nmap <buffer> <S-Backspace> <Plug>(ref-forward)
  setlocal nonumber
endfunction
" }}}

" changelog.vim "{{{
autocmd MyAutoCmd BufNewFile,BufRead *.changelog setf changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "hot_coffee"
" }}}

" surround.vim "{{{
let g:surround_no_mappings = 1
autocmd MyAutoCmd FileType * call s:define_surround_keymappings()

function! s:define_surround_keymappings()
  if !&modifiable
    return
  endif

  nmap <buffer>         ds   <Plug>Dsurround
  nmap <buffer>         cs   <Plug>Csurround
  nmap <buffer>         s   <Plug>Ysurround
  nmap <buffer>         S   <Plug>YSurround
  nmap <buffer>         ss  <Plug>Yssurround
  nmap <buffer>         SS  <Plug>YSsurround
endfunction
" }}}

" rsense.vim "{{{
let g:rsenseHome = $RSENSE_HOME
" }}}

" }}}

"-------------------------------------------------------------------------
" Key-mappings: "{{{
"
" basic mapping {{{
inoremap 1 !
inoremap ! 1
inoremap 2 @
inoremap @ 2
inoremap 3 #
inoremap # 3
inoremap 4 $
inoremap $ 4
inoremap 5 %
inoremap % 5
inoremap 6 ^
inoremap ^ 6
inoremap 7 &
inoremap & 7
inoremap 8 *
inoremap * 8
inoremap 9 (
inoremap ( 9
inoremap 0 )
inoremap ) 0

inoremap <S-Space> _

inoremap ; :
inoremap : ;

noremap j gj
noremap k gk
noremap <C-j> <C-d>
noremap <C-k> <C-u>
noremap <C-l> <C-e>
noremap <C-h> <C-y>

noremap L $
noremap H ^
noremap gj L
noremap gm M
noremap gk H

nnoremap <TAB> <C-w>w

nnoremap <silent> <leader>, :<C-u>write<CR>
" }}}

" tab page mapping {{{
nnoremap <SID>[tab] <Nop>
nmap t <SID>[tab]

nnoremap <silent> <SID>[tab]l :<C-u>tabnext<CR>
nnoremap <silent> <SID>[tab]h :<C-u>tabprev<CR>
nnoremap <silent> <SID>[tab]q :<C-u>tabclose<CR>
nnoremap <silent> <SID>[tab]t :<C-u>tabnew<CR>
" }}}

" split mapping {{{
nnoremap <SID>[split] <Nop>
nmap <C-w>s <SID>[split]

nmap <SID>[split]j <SID>(split-to-j)
nmap <SID>[split]k <SID>(split-to-k)
nmap <SID>[split]h <SID>(split-to-h)
nmap <SID>[split]l <SID>(split-to-l)

nnoremap <silent> <SID>(split-to-j) :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <silent> <SID>(split-to-k) :<C-u>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <silent> <SID>(split-to-h) :<C-u>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <silent> <SID>(split-to-l) :<C-u>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>
" }}}

" Hack #161: Command-line windowを使いこなす "{{{
" http://vim-users.jp/2010/07/hack161/
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

nmap ; <SID>(command-line-enter)
xmap ; <SID>(command-line-enter)

nmap <leader>h <SID>(command-line-enter)help<Space>
nnoremap <leader>hh :<C-u>help<Space><C-r><C-w><CR>

autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <silent> <buffer> q :<C-u>quit<CR>
  nnoremap <silent> <buffer> <TAB> :<C-u>quit<CR>
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
    silent normal! <C-e>
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
    silent normal! <C-y>
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
" Commands: "{{{
"
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>
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
" Platform depends: "{{{
"
if s:iswin
  " For Windows "{{{

  " }}}
else
  " For Linux "{{{

  " }}}
endif
" }}}

"-------------------------------------------------------------------------
" Finish:  "{{{1
" https://github.com/kana/config/blob/master/vim/personal/dot.vimrc
if !exists('s:loaded_my_vimrc')
  let s:loaded_my_vimrc = 1
  " autocmd MyAutoCmd VimEnter *
  " \ doautocmd MyAutoCmd User DelayedSettings
else
  " doautocmd MyAutoCmd User DelayedSettings
endif

set secure  " must be written at the last.  see :help 'secure'.
