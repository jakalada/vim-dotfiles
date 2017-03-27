setlocal smartindent autoindent
setlocal smarttab expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal shiftround

setlocal formatoptions+=m
setlocal formatoptions+=M
setlocal formatoptions-=r
setlocal formatoptions-=o

inoremap <buffer> # X<C-H>#

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\ | setlocal smartindent< autoindent<
\ | setlocal smarttab< expandtab<
\ | setlocal tabstop<
\ | setlocal shiftwidth<
\ | setlocal softtabstop<
\ | setlocal shiftround<
\ | setlocal foldmethod<
\ | setlocal formatoptions<
\ | setlocal foldlevel<
\ | execute "iunmap <buffer> #"
\'
