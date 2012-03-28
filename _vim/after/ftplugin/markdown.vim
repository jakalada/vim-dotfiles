setlocal smarttab expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal shiftround

setlocal foldmethod=manual

nnoremap <buffer> 1 "=repeat('=', strdisplaywidth(getline("."))) . "\n"<CR>p
nnoremap <buffer> 2 "=repeat('-', strdisplaywidth(getline("."))) . "\n"<CR>p

" 見出しの下線を自動補完する {{{
augroup MyMarkdown
    autocmd!
augroup END

command!
\   -bang -nargs=*
\   MyMarkdownAutocmd
\   autocmd<bang> MyMarkdown <args>

function! s:syntax_name(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name')
endfunction

function! s:format_header(current_line, syntax_name)
  let next_line = a:current_line + 1
  if a:syntax_name == 'markdownH1'
    call setline(next_line, repeat('=', strdisplaywidth(getline(a:current_line))))
  elseif a:syntax_name == 'markdownH2'
    call setline(next_line, repeat('-', strdisplaywidth(getline(a:current_line))))
  endif
endfunction

function! s:format_header_i()
  let current_line = line('.')
  if s:syntax_name(current_line + 1, 1) == 'markdownHeadingRule'
    let syntax_name = s:syntax_name(current_line, col('.') - 1)
    call s:format_header(current_line, syntax_name)
  endif
endfunction

function! s:format_header_n()
  let current_line = line('.')
  if s:syntax_name(current_line + 1, 1) == 'markdownHeadingRule'
    let syntax_name = s:syntax_name(current_line, col('.'))
    call s:format_header(current_line, syntax_name)
  endif
endfunction

MyMarkdownAutocmd CursorMovedI <buffer> call s:format_header_i()
" }}}


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
\ | nunmap <buffer> 1
\ | nunmap <buffer> 2
\'
