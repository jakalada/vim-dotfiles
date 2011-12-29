setlocal smarttab expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal shiftround

setlocal foldmethod=syntax

" for xmpfilter in rcodetools "{{{
" plain annotations
nnoremap <buffer> <silent> <LocalLeader>x V!xmpfilter -a<CR>
vnoremap <buffer> <silent> <LocalLeader>x !xmpfilter -a<CR>

"" Test::Unit assertions; use -s to generate RSpec expectations instead
"map <silent> <S-F10> !xmpfilter -u<cr>
"nmap <silent> <S-F10> V<S-F10>
"imap <silent> <S-F10> <ESC><S-F10>a
"
"" Annotate the full buffer
"" I actually prefer ggVG to %; it's a sort of poor man's visual bell 
"nmap <silent> <F11> mzggVG!xmpfilter -a<cr>'z
"imap <silent> <F11> <ESC><F11>
"
"" assertions
"nmap <silent> <S-F11> mzggVG!xmpfilter -u<cr>'z
"imap <silent> <S-F11> <ESC><S-F11>a
"
"" Add # => markers
"vmap <silent> <F12> !xmpfilter -m<cr>
"nmap <silent> <F12> V<F12>
"imap <silent> <F12> <ESC><F12>a
"
"" Remove # => markers
"vmap <silent> <S-F12> ms:call RemoveRubyEval()<CR>
"nmap <silent> <S-F12> V<S-F12>
"imap <silent> <S-F12> <ESC><S-F12>a
" }}}

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\ | setlocal smartindent< autoindent< smarttab< expandtab<
\ | setlocal tabstop<
\ | setlocal shiftwidth<
\ | setlocal softtabstop<
\ | setlocal shiftround<
\ | setlocal foldmethod<
\ | vunmap <buffer> <LocalLeader>x
\ | nunmap <buffer> <LocalLeader>x
\'
