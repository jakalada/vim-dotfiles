nnoremap <buffer> <CR> <C-]>

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
\ | unmap <CR>
\'
