setlocal smarttab expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal shiftround

setlocal foldmethod=manual

nnoremap <buffer> = "=repeat('=', strdisplaywidth(getline("."))) . "\n"<CR>p
nnoremap <buffer> - "=repeat('-', strdisplaywidth(getline("."))) . "\n"<CR>p

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
\ | nunmap <buffer> =
\ | nunmap <buffer> -
\'
