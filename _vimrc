" jakalada's vimrc

" Initialize {{{1
set nocompatible
scriptencoding utf-8

let s:iswin32 = has('win32')
let s:iswin64 = has('win64')
let s:iswin = has('win32') || has('win64')
let s:isgui = has("gui_running")
let s:ismacunix = has("macunix")

if s:iswin
  set shellslash
  let $DOTVIMDIR = expand('~/vimfiles')
  let $DROPBOXDIR = expand('~/Dropbox')
  let $VIMCONFIGDIR = expand('~/project/vim-dotfiles')
else
  let $DOTVIMDIR = expand('~/.vim')
  let $DROPBOXDIR = expand('~/Dropbox')
  let $VIMCONFIGDIR = expand('~/project/vim-dotfiles')
endif


" NeoBundle {{{1
let $VIMBUNDLEDIR = $DOTVIMDIR . '/bundle'
let $NEOBUNDLEPATH = $VIMBUNDLEDIR . '/neobundle.vim'

function! s:bundled(bundle)
  if !isdirectory($VIMBUNDLEDIR)
    return 0
  endif

  if stridx(&runtimepath, $NEOBUNDLEPATH) == -1
    return 0
  endif

  if a:bundle ==# 'neobundle.vim'
    return 1
  else
    return neobundle#is_installed(a:bundle)
  endif
endfunction

filetype off

if isdirectory($NEOBUNDLEPATH)
  set runtimepath+=$NEOBUNDLEPATH
endif

if s:bundled('neobundle.vim')
  call neobundle#rc($VIMBUNDLEDIR)

  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'Shougo/vimproc', {
        \'build' : {
        \    'windows' : 'make -f make_mingw32.mak',
        \    'cygwin' : 'make -f make_cygwin.mak',
        \    'mac' : 'make -f make_mac.mak',
        \    'unix' : 'make -f make_unix.mak',
        \  },
        \}

  NeoBundle 'bling/vim-airline'
  NeoBundle 'Shougo/junkfile.vim'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'Shougo/vinarise'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'airblade/vim-rooter'
  NeoBundle 'dannyob/quickfixstatus'
  NeoBundle 'h1mesuke/vim-alignta'
  NeoBundle 'hail2u/vim-tabcom'
  NeoBundle 'itchyny/thumbnail.vim'
  NeoBundle 'jceb/vim-hier'
  NeoBundle 'kana/vim-altr'
  NeoBundle 'kana/vim-gf-user'
  NeoBundle 'kana/vim-metarw'
  NeoBundle 'kana/vim-metarw-git'
  NeoBundle 'kana/vim-smartchr'
  "NeoBundle 'kana/vim-smartinput'
  NeoBundle 'kana/vim-submode'
  NeoBundle 'kana/vim-tabpagecd'
  NeoBundle 'kannokanno/previm'
  NeoBundle 'majutsushi/tagbar'
  NeoBundle 'mattn/calendar-vim'
  NeoBundle 'mattn/learn-vimscript'
  NeoBundle 'mattn/webapi-vim'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'supermomonga/shiraseru.vim', {'depends' : 'Shougo/vimproc'}
  NeoBundle 't9md/vim-quickhl'
  NeoBundle 'taku-o/vim-toggle'
  NeoBundle 'thinca/vim-editvar'
  NeoBundle 'thinca/vim-localrc'
  NeoBundle 'thinca/vim-openbuf'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'thinca/vim-visualstar'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'tpope/vim-rails'
  NeoBundle 'tpope/vim-repeat'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tyru/caw.vim'
  NeoBundle 'tyru/current-func-info.vim'
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'tyru/savemap.vim'
  NeoBundle 'tyru/vice.vim'
  NeoBundle 'vim-jp/vimdoc-ja'
  NeoBundle 'vim-scripts/VOoM'
  NeoBundle 'zef/vim-cycle'

  " colorscheme {{{
  NeoBundle 'chriskempson/vim-tomorrow-theme'
  NeoBundle 'hail2u/h2u_colorscheme'
  NeoBundle 'hickop/vim-hickop-colors'
  NeoBundle 'junegunn/seoul256.vim'
  NeoBundle 'Lokaltog/vim-distinguished'
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'tomasr/molokai'
  " }}}

  " filetype {{{
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'leshill/vim-json'
  NeoBundle 'othree/html5.vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'slim-template/vim-slim'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'tpope/vim-haml'
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'vim-scripts/Textile-for-VIM'
  NeoBundle 'kingbin/vim-arduino'
  " }}}

  " textobj {{{
  NeoBundle 'kana/vim-textobj-user'

  NeoBundle 'h1mesuke/textobj-wiw'
  NeoBundle 'kana/vim-textobj-fold'
  NeoBundle 'kana/vim-textobj-indent'
  NeoBundle 'kana/vim-textobj-lastpat'
  NeoBundle 'kana/vim-textobj-line'
  NeoBundle 'kana/vim-textobj-syntax'
  NeoBundle 'osyo-manga/vim-textobj-multiblock'
  " }}}

  " unite {{{
  NeoBundle 'Shougo/unite.vim'

  NeoBundle 'Shougo/unite-build'
  NeoBundle 'Shougo/unite-outline'
  NeoBundle 'basyura/unite-rails'
  NeoBundle 'choplin/unite-vim_hacks'
  NeoBundle 'sgur/unite-git_grep'
  NeoBundle 'sgur/unite-qf'
  NeoBundle 'tacroe/unite-mark'
  NeoBundle 'thinca/vim-unite-history'
  NeoBundle 'tsukkee/unite-help'
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'tungd/unite-session'
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'ujihisa/unite-font'
  NeoBundle 'ujihisa/unite-locate'
  " }}}

  " game {{{
  NeoBundle 'tyru/pacman.vim'
  " }}}

  " Installation check.
  NeoBundleCheck
endif

filetype plugin indent on


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


" Syntax {{{1
syntax enable

" ft-ruby-syntax
let ruby_operators = 1

" NOTE: ファイルタイプがvimのときでも`set foldmethod=syntax`されてしまう
" let ruby_fold = 1

let ruby_no_comment_fold = 1
" let g:rubycomplete_buffer_loading = 1
" let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

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


" Options {{{1
if s:isgui
  colorscheme jellybeans
  highlight ColorColumn guibg=#333333

  if s:ismacunix
    set guifont=Ricty\ Diminished:h17
  elseif s:iswin
    set guifont=Inconsolata:h13:cSHIFTJIS
  else
    set guifont=Ricty\ Discord\ 13.5
  endif

  set guioptions=ciM
  set mouse=a
  set mousehide
  set mousefocus
  set novisualbell
  set guicursor+=a:blinkon0
  let loaded_matchparen = 1
else
  set t_Co=256
  colorscheme distinguished
endif

set pumheight=10

set nocursorline
set cmdheight=2

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

set backupdir=~/tmp
set directory-=.
if v:version >= 703
  set undofile
  setl undodir=~/tmp
endif

if has('virtualedit')
  set virtualedit=block,insert
endif

" マルチバイト文字の扱いを自然にする
set formatoptions+=m
set formatoptions+=M
" コメント行で改行した次行を非コメント行にする
set formatoptions-=r
set formatoptions-=o

set scrolloff=10

set helplang=ja

MyAutocmd WinEnter * checktime
set autoread

set clipboard=unnamed

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
set hlsearch

nnoremap <silent> <SID>[nohlsearch] :<C-U>nohlsearch<CR>

nnoremap <script> / <SID>[nohlsearch]/
nnoremap <script> ? <SID>[nohlsearch]?

nnoremap <script> v <SID>[nohlsearch]v
nnoremap <script> <C-V> <SID>[nohlsearch]<C-V>
nnoremap <script> V <SID>[nohlsearch]V

nnoremap <script> i <SID>[nohlsearch]i
nnoremap <script> I <SID>[nohlsearch]I

nnoremap <script> a <SID>[nohlsearch]a
nnoremap <script> A <SID>[nohlsearch]A

nnoremap <script> o <SID>[nohlsearch]o
nnoremap <script> O <SID>[nohlsearch]O
" }}}

set linespace=3

set number

set noshowcmd

set noshowmode

set confirm

set report=0

set noequalalways

if has('conceal')
  set conceallevel=2
endif

set list
let &listchars = 'tab:>-,trail:-'

let &fillchars = 'vert: ,fold: ,diff: '

let &showbreak = '> '

set wrap

set textwidth=0

set laststatus=2

set nomodeline

set completeopt-=preview

" Mappings {{{1

" MacVimのメニューに登録されているショーットカットを無効化 " {{{2
if s:ismacunix && s:isgui
  let s:macmenus = [
        \  'File.New Window',
        \  'File.New Window',
        \  'File.New Tab',
        \  'File.Open...',
        \  'File.Split-Open...',
        \  'File.Open Tab...',
        \  'File.Open Recent',
        \  'File.Close Window',
        \  'File.Close',
        \  'File.Save',
        \  'File.Save All',
        \  'File.Save As...',
        \  'File.Print',
        \  'Edit.Undo',
        \  'Edit.Redo',
        \  'Edit.Cut',
        \  'Edit.Copy',
        \  'Edit.Paste',
        \  'Edit.Select All',
        \  'Edit.Find.Find...',
        \  'Edit.Find.Find Next',
        \  'Edit.Find.Find Previous',
        \  'Edit.Font.Bigger',
        \  'Edit.Font.Smaller',
        \  'Edit.Special Characters...',
        \  'Tools.Make',
        \  'Tools.List Errors',
        \  'Tools.Next Error',
        \  'Tools.Previous Error',
        \  'Tools.Older List',
        \  'Tools.Newer List',
        \  'Tools.Spelling.To Next error',
        \  'Tools.Spelling.Suggest Corrections',
        \  'Window.Select Previous Tab',
        \  'Window.Select Next Tab',
        \  'Window.Minimize',
        \  'Window.Minimize All',
        \  'Window.Zoom',
        \  'Window.Zoom All',
        \  'Window.Toggle Full Screen Mode'
        \]
  for s in s:macmenus
    execute 'macmenu ' . substitute(escape(s, ' '), '\.\.\.', '\\.\\.\\.', 'g') . ' key=<Nop>'
  endfor
endif

" IBusで日本語入力に切り替えるたびにスペースが挿入されてしまうのを防ぐ {{{2
noremap <C-Space> <Nop>
noremap! <C-Space> <Nop>
xnoremap <C-Space> <Nop>
snoremap <C-Space> <Nop>
lnoremap <C-Space> <Nop>


" <C-J>と<C-K>を各モードでエスケープにマッピング {{{2
noremap <C-J> <Esc>
inoremap <C-J> <Esc>
cnoremap <C-J> <C-C>
xnoremap <C-J> <Esc>
snoremap <C-J> <Esc>
lnoremap <C-J> <Esc>

noremap <C-K> <Esc>
inoremap <C-K> <Esc>
cnoremap <C-K> <C-C>
xnoremap <C-K> <Esc>
snoremap <C-K> <Esc>
lnoremap <C-K> <Esc>


" Leader {{{2
let mapleader = ' '
let maplocalleader = '\'

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

nnoremap <C-Backspace> <C-^>

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


" mapmode-ic {{{2


" mapmode-o {{{2
onoremap / t
onoremap ? T

onoremap ) t)
onoremap ( t(


" Plugins {{{1
" vim-toggle {{{2
if s:bundled('vim-toggle')
  nmap - <Plug>ToggleN
endif


" matchit.vim {{{2
runtime macros/matchit.vim


" caw.vim " {{{2
if s:bundled('caw.vim')
  let g:caw_no_default_keymappings = 1
  nmap <C-P> <Plug>(caw:wrap:toggle)
  vmap <C-P> <Plug>(caw:wrap:toggle)gv=
endif


" vimfiler {{{2
if s:bundled('vimfiler')
  " 削除時にゴミ箱に移動したい場合
  " windows: vimprocプラグインをインストール
  "   linux: trash-cliをインストール
  "     osx: rmtrashをインストール
  "     etc: オプションで直接コマンドを指定する
  let g:vimfiler_as_default_explorer = 1    " explorerとして使用する
  let g:vimfiler_safe_mode_by_default = 0   " セーフモードをオフにする
  let g:vimfiler_split_action = "split"     " 忘れた

  let g:vimfiler_time_format        = "%Y/%m/%d %H:%M"  " 例: 2013/01/01 00:00

  let g:vimfiler_tree_leaf_icon     = ' '   " default: '|'
  let g:vimfiler_tree_opened_icon   = '-'   " default: '-'
  let g:vimfiler_tree_closed_icon   = '+'   " default: '+'
  let g:vimfiler_readonly_file_icon = '!'   " deafult: 'X'
  let g:vimfiler_file_icon          = '-'   " default: '-'
  let g:vimfiler_marked_file_icon   = '*'   " default: '*'

  nnoremap <silent> <Leader>e :<C-U>VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
  nnoremap <silent> <Leader>E :<C-U>VimFiler<CR>

  let g:vimfiler_no_default_key_mappings = 1 " デフォルトのマッピングを無効
  MyAutocmd Filetype vimfiler call s:init_vimfiler()
  function! s:init_vimfiler() " {{{
    setlocal nonumber
    vmap <buffer> '               <Plug>(vimfiler_toggle_mark_selected_lines)

    nmap <buffer> <Tab>           <Plug>(vimfiler_switch_to_other_window)
    nmap <buffer> j               <Plug>(vimfiler_loop_cursor_down)
    nmap <buffer> k               <Plug>(vimfiler_loop_cursor_up)
    nmap <buffer> gg              <Plug>(vimfiler_cursor_top)
    " nmap <buffer> <C-l>         <Plug>(vimfiler_redraw_screen)
    nmap <buffer> '               <Plug>(vimfiler_toggle_mark_current_line)
    "nmap <buffer> <S-Space>      <Plug>(vimfiler_toggle_mark_current_line_up)
    " nmap <buffer> *             <Plug>(vimfiler_toggle_mark_all_lines)
    nmap <buffer> "               <Plug>(vimfiler_clear_mark_all_lines)
    nmap <buffer> c               <Plug>(vimfiler_copy_file)
    nmap <buffer> m               <Plug>(vimfiler_move_file)
    nmap <buffer> d               <Plug>(vimfiler_delete_file)
    nmap <buffer> Cc              <Plug>(vimfiler_clipboard_copy_file)
    nmap <buffer> Cm              <Plug>(vimfiler_clipboard_move_file)
    nmap <buffer> Cp              <Plug>(vimfiler_clipboard_paste)
    nmap <buffer> r               <Plug>(vimfiler_rename_file)
    nmap <buffer> K               <Plug>(vimfiler_make_directory)
    nmap <buffer> N               <Plug>(vimfiler_new_file)
    nmap <buffer> <Enter>               <Plug>(vimfiler_execute)
    nmap <buffer> l               <Plug>(vimfiler_smart_l)
    nmap <buffer> X               <Plug>(vimfiler_execute_system_associated)
    nmap <buffer> h               <Plug>(vimfiler_smart_h)
    nmap <buffer> L               <Plug>(vimfiler_switch_to_drive)
    nmap <buffer> ~               <Plug>(vimfiler_switch_to_home_directory)
    nmap <buffer> \               <Plug>(vimfiler_switch_to_root_directory)
    nmap <buffer> <C-j>           <Plug>(vimfiler_switch_to_history_directory)
    nmap <buffer> <BS>            <Plug>(vimfiler_switch_to_parent_directory)
    nmap <buffer> .               <Plug>(vimfiler_toggle_visible_dot_files)
    " nmap <buffer> H             <Plug>(vimfiler_popup_shell)
    nmap <buffer> e               <Plug>(vimfiler_edit_file)
    nmap <buffer> E               <Plug>(vimfiler_split_edit_file)
    nmap <buffer> B               <Plug>(vimfiler_edit_binary_file)
    nmap <buffer> ge              <Plug>(vimfiler_execute_external_filer)
    " nmap <buffer> <RightMouse>  <Plug>(vimfiler_execute_external_filer)
    nmap <buffer> !               <Plug>(vimfiler_execute_shell_command)
    nmap <buffer> q               <Plug>(vimfiler_hide)
    nmap <buffer> Q               <Plug>(vimfiler_exit)
    " nmap <buffer> -             <Plug>(vimfiler_close)
    nmap <buffer> ?               <Plug>(vimfiler_help)
    " nmap <buffer> v             <Plug>(vimfiler_preview_file)
    " nmap <buffer> o             <Plug>(vimfiler_sync_with_current_vimfiler)
    " nmap <buffer> O             <Plug>(vimfiler_open_file_in_another_vimfiler)
    " nmap <buffer> <C-g>         <Plug>(vimfiler_print_filename)
    " nmap <buffer> g<C-g>        <Plug>(vimfiler_toggle_maximize_window)
    nmap <buffer> yy              <Plug>(vimfiler_yank_full_path)
    nmap <buffer> gm              <Plug>(vimfiler_set_current_mask)
    nmap <buffer> gr              <Plug>(vimfiler_grep)
    nmap <buffer> gf              <Plug>(vimfiler_find)
    nmap <buffer> gs              <Plug>(vimfiler_select_sort_type)
    " nmap <buffer> <C-v>         <Plug>(vimfiler_switch_vim_buffer_mode)
    nmap <buffer> gc              <Plug>(vimfiler_cd_vim_current_dir)
    " nmap <buffer> gs            <Plug>(vimfiler_toggle_safe_mode)
    " nmap <buffer> gS            <Plug>(vimfiler_toggle_simple_mode)
    nmap <buffer> a               <Plug>(vimfiler_choose_action)
    " nmap <buffer> Y             <Plug>(vimfiler_pushd)
    " nmap <buffer> P             <Plug>(vimfiler_popd)
    nmap <buffer> zl              <Plug>(vimfiler_expand_tree)
    nmap <buffer> zL              <Plug>(vimfiler_expand_tree_recursive)
    nmap <buffer> zh              <Plug>(vimfiler_expand_tree)
    nmap <buffer> zH              <Plug>(vimfiler_expand_tree_recursive)
    nmap <buffer> i               <Plug>(vimfiler_cd_input_directory)
    " nmap <buffer> <2-LeftMouse> <Plug> (vimfiler_double_click)
  endfunction " }}}
endif

" unite.vim {{{2
if s:bundled('unite.vim')
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
  nnoremap <silent> <SID>[unite]H :<C-U>Unite -buffer-name=refe -input=ref source<CR>
  nnoremap <silent> <SID>[unite]R :<C-U>Unite -buffer-name=rails -input=rails source<CR>
  nnoremap <silent> <SID>[unite]s :<C-U>Unite -buffer-name=snippet snippet<CR>
  nnoremap <silent> <SID>[unite]S :<C-U>Unite -buffer-name=source source<CR>
  nnoremap <silent> <SID>[unite]q :<C-U>Unite -buffer-name=qf qf<CR>

  nnoremap <silent> <SID>[unite-no-quit]F :<C-U>Unite -no-quit -keep-focus -buffer-name=files bookmark directory_mru file_mru<CR>
  nnoremap <silent> <SID>[unite-no-quit]f :<C-U>Unite -no-quit -keep-focus -buffer-name=files file<CR>
  nnoremap <silent> <SID>[unite-no-quit]b :<C-U>Unite -no-quit -keep-focus -buffer-name=buffer_tab buffer_tab<CR>
  nnoremap <silent> <SID>[unite-no-quit]B :<C-U>Unite -no-quit -keep-focus -buffer-name=buffer buffer<CR>
  nnoremap <silent> <SID>[unite-no-quit]r :<C-U>Unite -no-quit -keep-focus -buffer-name=register register<CR>
  nnoremap <silent> <SID>[unite-no-quit]t :<C-U>Unite -no-quit -keep-focus -buffer-name=tab tab:no-current<CR>
  nnoremap <silent> <SID>[unite-no-quit]w :<C-U>Unite -no-quit -keep-focus -buffer-name=window window:no-current<CR>
  nnoremap <silent> <SID>[unite-no-quit]o :<C-U>Unite -no-quit -keep-focus -buffer-name=outline outline<CR>
  nnoremap <silent> <SID>[unite-no-quit]m :<C-U>Unite -no-quit -keep-focus -buffer-name=mark mark<CR>
  nnoremap <silent> <SID>[unite-no-quit]h :<C-U>Unite -no-quit -keep-focus -buffer-name=help help<CR>
  nnoremap <silent> <SID>[unite-no-quit]H :<C-U>Unite -no-quit -keep-focus -buffer-name=refe -input=ref source<CR>
  nnoremap <silent> <SID>[unite-no-quit]R :<C-U>Unite -no-quit -keep-focus -buffer-name=rails -input=rails source<CR>
  nnoremap <silent> <SID>[unite-no-quit]s :<C-U>Unite -no-quit -keep-focus -buffer-name=snippet snippet<CR>
  nnoremap <silent> <SID>[unite-no-quit]S :<C-U>Unite -no-quit -keep-focus -buffer-name=source source<CR>
  nnoremap <silent> <SID>[unite-no-quit]q :<C-U>Unite -no-quit -keep-focus -buffer-name=qf qf<CR>
endif


" unite-line {{{2
if s:bundled('unite.vim')
  nnoremap <silent> <SID>[unite]l :<C-U>UniteWithCursorWord -buffer-name=line line<CR>
  nnoremap <silent> <SID>[unite-no-quite]l :<C-U>UniteWithCursorWord -no-quit -buffer-name=line line<CR>
endif


" unite-menu {{{2
if s:bundled('unite.vim')
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
endif


" unite-junkfile {{{2
if s:bundled('unite.vim') && s:bundled('junkfile.vim')
  nnoremap <silent> <SID>[unite]j :<C-u>Unite -start-insert junkfile/new junkfile<CR>
endif


" altr {{{2
if s:bundled('vim-altr')
  nmap <Leader>n  <Plug>(altr-forward)
  nmap <Leader>p  <Plug>(altr-back)

  call altr#define('spec/%_spec.rb', 'lib/%.rb')
  call altr#define('src/lib/*/%.coffee', 'spec/*/%_spec.coffee')
  call altr#define('src/lib/%.coffee', 'spec/%_spec.coffee')
endif


" unite-neco {{{2
if s:bundled('unite.vim')
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
endif


" rsense.vim {{{2
" let g:rsenseHome = expand('$RSENSE_HOME')
" let g:rsenseUseOmniFunc = 1


" vimshell {{{2
if s:bundled('vimshell')
  let g:vimshell_prompt = '$ '
  let g:vimshell_user_prompt = '"[" . getcwd() ."]"'

  nnoremap <Leader>s :<C-U>VimShell<CR>
endif

" neocomplete.vim {{{2
if s:bundled('neocomplcache') && (v:version <= 702 || (v:version == 703 && !has('patch885')))
  let g:neocomplete#enable_at_startup = 1

  inoremap <expr> <C-C>  neocomplete#complete_common_string()
  inoremap <expr> <C-O>  neocomplete#start_manual_complete()
endif

" neocomplcache.vim {{{2
if s:bundled('neocomplcache') && (v:version <= 704 || (v:version == 703 && has('patch885')))
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_min_keyword_length = 3

  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.php =
        \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
  let g:neocomplcache_omni_patterns.c =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
  let g:neocomplcache_omni_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
  let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

  inoremap <expr> <C-C> neocomplcache#complete_common_string()
  inoremap <expr> <C-O>  neocomplcache#start_manual_complete()
endif


" neosnippet {{{2
if s:bundled('neosnippet')
  let g:neosnippet#snippets_directory = expand('~/.vim/snippets')

  nnoremap <silent> <Leader>.s :<C-U>NeoSnippetEdit<CR>
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
endif


" vim-ref {{{2
if s:bundled('vim-ref')
  if s:iswin
    let g:ref_pydoc_cmd = 'pydoc.bat'
    let g:ref_refe_encoding = 'cp932'
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
endif


" changelog.vim {{{2
MyAutocmd BufNewFile,BufRead *.changelog setfiletype changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Hideki Hamada (jakalada)"


" surround.vim {{{2
if s:bundled('vim-surround')
  nmap s ys
  nmap S yS

  nmap ss yss
  nmap SS ySS

  vmap s S
endif


" quickrun.vim {{{2
if s:bundled('vim-quickrun')
  let g:quickrun_config = get(g:, 'quickrun_config', {})
  let g:quickrun_config._ = {'runner' : 'vimproc'}
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


" vim-coffee-script {{{2
if s:bundled('vim-coffee-script')
endif

" tagbar {{{2
if s:bundled('tagbar')
  let g:tagbar_sort = 0

  nnoremap <silent> <Leader>t :<C-U>TagbarToggle<CR>
endif


" open-browser.vim  {{{2
if s:bundled('open-browser.vim')
  nmap <C-O> <Plug>(openbrowser-smart-search)
  vmap <C-O> <Plug>(openbrowser-smart-search)
endif


" quickhl.vim {{{2
if s:bundled('vim-quickhl')
  nmap <Space>m <Plug>(quickhl-toggle)
  xmap <Space>m <Plug>(quickhl-toggle)
  nmap <Space>M <Plug>(quickhl-reset)
  xmap <Space>M <Plug>(quickhl-reset)
  nmap <Space>j <Plug>(quickhl-match)
endif


" Alignta {{{2
if s:bundled('vim-alignta')
  vnoremap aa :Alignta
  vnoremap a= :Alignta =<CR>
  vnoremap a+ :Alignta +<CR>
endif


" textobj-multiblock {{{2
if s:bundled('vim-textobj-multiblock')
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
endif


" gitgutter {{{2
if s:bundled('vim-gitgutter')
  let g:gitgutter_enabled = 0
  nnoremap <Space>gg  :<C-u>GitGutterToggle<CR>
endif


" rooter {{{2
if s:bundled('vim-rooter')
  let g:rooter_use_lcd = 1
endif

" vim-airline {{{2
if s:bundled('vim-airline')
  let g:airline_theme = 'wombat'
  let g:airline#extensions#syntastic#enabled = 1
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

set foldtext=getline(v:foldstart)


" タブページ {{{2
nnoremap <SID>[tab] <Nop>
nmap t <SID>[tab]

nnoremap <SID>[tabnew] <Nop>
nmap T <SID>[tabnew]

nnoremap <silent> <SID>[tab]l :<C-U>tabnext<CR>
nnoremap <silent> <SID>[tab]h :<C-U>tabprev<CR>
nnoremap <silent> <SID>[tab]q :<C-U>tabclose<CR>
nnoremap <silent> <SID>[tab]t :<C-U>tabnew<CR>

nnoremap <silent> <SID>[tabnew]n :<C-U>tabnew \| lcd $DROPBOXDIR/Notes<CR>
nnoremap <silent> <SID>[tabnew]v :<C-U>tabnew \| lcd $VIMCONFIGDIR<CR>

" REF: http://d.hatena.ne.jp/thinca/20111204/1322932585
set showtabline=2
set tabline=%!MakeTabLine()

function! s:tabpage_label(n)

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? ' [+]' : ''

  let label = ''

  let title = gettabvar(a:n, 'title')
  if title !=# ''
    " t:titleと言う変数があればその内容を使用
    let label = ' #' . title . ' '
  else
    " t:titleと言う変数がなければカレントバッファ名を使用
    let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
    let fname = bufname(curbufnr)
    if fname ==# ''
      let fname = '[No Name]'
    else
      let fname = fnamemodify(fname, ':t')
    end

    let label = mod . ' ' . fname . ' '
  endif

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' : '
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  "let info = '(' . fnamemodify(getcwd(), ':~') . ') ' " 好きな情報を入れる
  let info = ''
  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction


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
nnoremap <silent> <SID>(command-line-enter) q:
xnoremap <silent> <SID>(command-line-enter) q:
nnoremap <silent> <SID>(command-line-enter-help) q:help<Space>
nnoremap <silent> <SID>(command-line-enter-setlocal-filetype) q:setfiletype<Space>

nnoremap ; <Nop>
xnoremap ; <Nop>

nmap ; <SID>(command-line-enter)
xmap ; <SID>(command-line-enter)

nnoremap <leader>h <Nop>
nnoremap <leader>f <Nop>

nmap <leader>h <SID>(command-line-enter-help)
nmap <leader>f <SID>(command-line-enter-setlocal-filetype)

MyAutocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin() " {{{
  nnoremap <buffer><silent> q :<C-U>quit<CR>
  inoremap <buffer><expr> <CR> pumvisible() ? '<C-Y><CR>' : '<CR>'
  nnoremap <buffer> ; <Nop>
  startinsert!
endfunction " }}}


" 現在行のインデントをハイライトする {{{2
MyAutocmd CursorMoved * call s:hilight_indent()
MyAutocmd CursorMovedI * call s:hilight_indent()
function! s:hilight_indent() "{{{
  let n = indent(line('.'))
  if n >= &tabstop
    let &l:colorcolumn = join(range(&tabstop, n, &tabstop), ',')
  else
    let &l:colorcolumn = ''
  endif
endfunction " }}}


" 空行を追加と削除を容易にする {{{2
nnoremap <silent> <Leader>o   :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader>O   :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Leader>O", v:count1)<CR>


" 最後に編集した位置に移動する {{{2
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" カーソル位置を移動せずにファイル全体を整形する {{{2
" http://kannokanno.hatenablog.com/entry/2014/03/16/160109
function! s:format_file()
  let view = winsaveview()
  normal gg=G
  silent call winrestview(view)
endfunction
nnoremap <C-F> :call <SID>format_file()<CR>

" }}}1

set secure  " must be written at the last.  see :help 'secure'.
