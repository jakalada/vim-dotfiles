setlocal smartindent
setlocal autoindent

setlocal smarttab
setlocal expandtab

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal shiftround

setlocal foldmethod=marker
setlocal foldlevel=100

setlocal formatoptions+=m
setlocal formatoptions+=M
setlocal formatoptions+=r
setlocal formatoptions+=o

setlocal keywordprg=:help

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\ | setlocal smartindent<
\ | setlocal autoindent<
\ | setlocal smarttab<
\ | setlocal expandtab<
\ | setlocal tabstop<
\ | setlocal shiftwidth<
\ | setlocal softtabstop<
\ | setlocal shiftround<
\ | setlocal foldmethod<
\ | setlocal foldlevel<
\ | setlocal formatoptions<
\ | setlocal keywordprg<
\'
