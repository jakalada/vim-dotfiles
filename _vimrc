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
let mapleader = ' '
" Use <Leader> in global plugin.
let g:mapleader = ' '
" Use <LocalLeader> in filetype plugin.
let g:maplocalleader = '\'

" Release keymappings for plug-in.
nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
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

augroup MyAutoCmd
  autocmd!
augroup END

" Set runtimepath.
if s:iswin
  let &runtimepath = join([expand('~/.vim'), expand('$VIM/runtime'), expand('~/.vim/after')], ',')
endif

" Load bundles.
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin on
filetype indent on
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
set incsearch
set ignorecase
set smartcase
set wrapscan

" hlsearch only searching."{{{
nnoremap <silent> / :<C-U>setlocal hlsearch<CR>/
nnoremap <silent> ? :<C-U>setlocal hlsearch<CR>?
nnoremap <silent> n :<C-U>setlocal hlsearch<CR>n
nnoremap <silent> N :<C-U>setlocal hlsearch<CR>N
nnoremap <silent> v :<C-U>setlocal nohlsearch<CR>v
nnoremap <silent> <C-V> :<C-U>setlocal nohlsearch<CR><C-V>
nnoremap <silent> V :<C-U>setlocal nohlsearch<CR>V
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

set scrolloff=10

set helplang=ja

set autoread

augroup VimrcChecktime
  autocmd!
  autocmd WinEnter * checktime
augroup END
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
  autocmd FileType help,git-status,git-log,qf,gitcommit,quickrun,qfreplace,ref,simpletap-summary nnoremap <buffer><silent> q :<C-U>close<CR>
  autocmd FileType * if &readonly |  nnoremap <buffer><silent> q :<C-U>close<CR> | endif
augroup END
" }}}

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
" }}}

"-------------------------------------------------------------------------
" Plugin: "{{{
"
" vimfiler.vim "{{{
nnoremap <silent> F :<C-U>VimFiler<CR>
" }}}

"nerdtree.vim "{{{
let g:NERDTreeChDirMode=1

nnoremap <silent> <leader>A :<C-U>NERDTree<CR>
nnoremap <silent> <leader>a :<C-U>NERDTreeToggle<CR>
nnoremap <silent> <leader>n :<C-U>NERDTreeToggle $HOME/Dropbox/Notes<CR>
" }}}

" unite.vim "{{{
" https://github.com/Shougo/unite.vim
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1

nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap f [unite]
xmap f [unite]
nnoremap <silent> [unite]n :<C-U>call unite#start(['file'], {'input': $HOME.'/Dropbox/Notes/', 'buffer_name': 'files'})<CR>
nnoremap <silent> [unite]F :<C-U>Unite -input=/ -buffer-name=files file bookmark file_mru<CR>
nnoremap <silent> [unite]f :<C-U>Unite -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-U>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]r :<C-U>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]t :<C-U>Unite -buffer-name=tab tab<CR>
nnoremap <silent> [unite]o :<C-U>Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]m :<C-U>Unite -buffer-name=mark mark<CR>
nnoremap <silent> [unite]h :<C-U>Unite -buffer-name=help help<CR>
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
let g:neocomplcache_enable_cursor_hold_i = 1
let g:neocomplcache_enable_auto_delimiter = 1

nnoremap <silent> <leader>.s :<C-U>NeoComplCacheEditSnippets<CR>
imap <expr><C-l> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-N>"

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
  let g:ref_refe_rsense_cmd = ['ruby', expand('$RSENSE_HOME/bin/rsense')]
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

" quickrun.vim "{{{
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
\ 'command': 'redcarpet_ext',
\ 'exec': '%c %s'
\ }
" }}}

" }}}

"-------------------------------------------------------------------------
" Key-mappings: "{{{
"
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
nnoremap <Leader>- yypVr-
nnoremap <Leader>= yypVr=

nnoremap <TAB> <C-W>w

nnoremap <Backspace> <C-O>
nnoremap <S-Backspace> <C-I>

nnoremap <silent> <leader><leader> :<C-U>write<CR>

nnoremap <C-Up> <C-A>
nnoremap <C-Down> <C-X>

nnoremap <silent> <C-Q> :<C-U>close<CR>

nnoremap <silent> <C-O> :<C-U>OpenURL <cfile><CR>

nnoremap <silent> <leader>; :<C-U>OpenRightWindow $HOME/Dropbox/GTD/inbox.md<CR>
" }}}

" mapmode-i "{{{
inoremap jj <Esc>
inoremap <C-J> <Esc>o
inoremap <C-K> <Esc>O

inoremap <S-Space> _
inoremap ; :
inoremap ;; <Space>=><Space>
inoremap ;% <%  %><Esc>hhi
inoremap ;= <%=  %><Esc>hhi
inoremap ;e <% end %><Esc>
" }}}

" tab page mapping {{{
nnoremap <SID>[tab] <Nop>
nmap t <SID>[tab]

nnoremap <silent> <SID>[tab]l :<C-U>tabnext<CR>
nnoremap <silent> <SID>[tab]h :<C-U>tabprev<CR>
nnoremap <silent> <SID>[tab]q :<C-U>tabclose<CR>
nnoremap <silent> <SID>[tab]t :<C-U>tabnew<CR>
" }}}

" split mapping {{{
nnoremap <SID>[split] <Nop>
nmap <C-W>s <SID>[split]

nmap <SID>[split]j <SID>(split-to-j)
nmap <SID>[split]k <SID>(split-to-k)
nmap <SID>[split]h <SID>(split-to-h)
nmap <SID>[split]l <SID>(split-to-l)

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

autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
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
" Commands: "{{{
"
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>


command!
\   -nargs=* -complete=mapping
\   OpenRightWindow
\   set splitright | vsplit <args> | set nosplitright

" for rails.vim
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

" requires metarw-git
nnoremap <silent> <Leader>gw :silent call GitHighlightLastChange()<CR>
function! GitHighlightLastChange()
  if &diff
    diffoff
    return
  endif

  let log = system('git log -1 --pretty=oneline ' . expand('%'))
  if v:shell_error
    echoerr log
    return
  endif
  let [ sha1, message ] = matchlist(log, '\v(\x{40}) (.*)\n')[1:2]
  execute 'vertical diffsplit' 'git:' . sha1 . '^:%'
  quit

  redrawstatus
  unsilent echo "highlighting diff of '" . message . "'"
endfunction

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
