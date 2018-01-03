let s:save_cpo = &cpo
set cpo&vim


if !exists('g:ref_ri_cmd')
  let g:ref_ri_cmd = executable('ri') ? 'ri --format=rdoc' : ''
endif
let s:cmd = g:ref_ri_cmd

if !exists('g:ref_ri_encoding')
  let g:ref_ri_encoding = &termencoding
endif


" Help: ref-sources
let s:source = {}


" Help: ref-source-attr-name
let s:source = {'name': 'ri'}


" Help: ref-source-attr-get_body()
function! s:ri(args)
  return ref#system(ref#to_list(g:ref_ri_cmd) + ref#to_list(a:args))
endfunction

function! s:source.get_body(query)
  let res = s:ri(a:query)
  if res.result
    throw matchstr(res.stderr, '^.\{-}\ze\n')
  endif

  let content = res.stdout

  if exists('g:ref_ri_encoding') &&
  \  !empty(g:ref_ri_encoding) && g:ref_ri_encoding != &encoding
    let converted = iconv(content, g:ref_ri_encoding, &encoding)
    if converted != ''
      let content = converted
    endif
  endif

  return content
endfunction


" Help: ref-source-attr-available()
function! s:source.available()
  return !empty(g:ref_ri_cmd)
endfunction


" Help: ref-source-attr-opened()
" function! s:source.opened(query)
" endfunction


" Help: ref-source-attr-get_keyword()
" function! s:source.get_keyword()
" endfunction


" Help: ref-source-attr-complete()
" function! s:source.complete(query)
" endfunction


" Help: ref-source-attr-normalize()
" function! s:source.normalize(query)
" endfunction


" Help: ref-source-attr-leave()
" function! s:source.leave()
" endfunction


" Help: ref-autoload
function! ref#ri#define()
  return s:source
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
