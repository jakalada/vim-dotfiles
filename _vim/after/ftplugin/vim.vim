setlocal smartindent autoindent
setlocal smarttab expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal shiftround
setlocal foldmethod=marker

setlocal formatoptions+=m
setlocal formatoptions+=M
setlocal formatoptions-=r
setlocal formatoptions-=o

setlocal keywordprg=:help

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
\ | setlocal keywordprg<
\ | setlocal formatoptions<
\'
