setlocal smarttab expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal shiftround

setlocal foldmethod=manual

inoremap <buffer> <expr> =  smartchr#one_of('=', '==============================')
inoremap <buffer> <expr> -  smartchr#one_of('-', '------------------------------')

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\ | setlocal smartindent< autoindent< smarttab< expandtab<
\ | setlocal tabstop<
\ | setlocal shiftwidth<
\ | setlocal softtabstop<
\ | setlocal keywordprg<
\ | setlocal shiftround<
\ | iunmap <buffer> <expr> =
\ | iunmap <buffer> <expr> -
\'
