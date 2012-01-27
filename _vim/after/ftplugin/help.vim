nnoremap <buffer> <CR> <C-]>

function! after#ftplugin#help#yank_plugin_variable() " {{{
  let line = getline(line('.'))

  if match(line, '^g:') != -1
    let yanked = 'let ' . substitute(line, '\s\+[*].\+[*]$', '', '') . ' = '
    call setreg('"', yanked, 'l')
    echo 'plugin option yanked'
  endif
endfunction " }}}

nnoremap <expr> yy match(getline(line('.')), '^g:') != -1 ?
      \ ":\<C-u>call after#ftplugin#help#yank_plugin_variable()\<CR>" : "yy"
