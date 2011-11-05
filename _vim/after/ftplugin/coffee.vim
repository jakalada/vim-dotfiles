setlocal smarttab expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal shiftround

inoremap <expr> > smartchr#one_of('->', '=>', '>' '>>')

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\ | setlocal smartindent< autoindent< smarttab< expandtab<
\ | setlocal tabstop<
\ | setlocal shiftwidth<
\ | setlocal softtabstop<
\ | setlocal shiftround<
\ | iunmap >
\'
