setlocal smartindent autoindent smarttab expandtab
setlocal smarttab expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal shiftround

if has('path_extra')
  setlocal tags+=$DOTVIMDIR/systags
endif

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\ | setlocal smartindent< autoindent< smarttab< expandtab<
\ | setlocal tabstop<
\ | setlocal shiftwidth<
\ | setlocal softtabstop<
\ | setlocal shiftround<
\ | setlocal tags-=$DOTVIMDIR/systags
\'
