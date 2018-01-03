setlocal smartindent
setlocal autoindent
setlocal nosmarttab
setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal shiftround

setlocal foldmethod=syntax
setlocal foldlevel=100

setlocal formatoptions+=m
setlocal formatoptions+=M
setlocal formatoptions+=r
setlocal formatoptions+=o

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
\'
