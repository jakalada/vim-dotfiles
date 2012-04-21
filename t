[1mdiff --git a/_vimrc b/_vimrc[m
[1mindex 77ea45c..6fe81de 100644[m
[1m--- a/_vimrc[m
[1m+++ b/_vimrc[m
[36m@@ -97,6 +97,15 @@[m [mendif[m
" =======================[m

" statullineの設定に使用する[m
[32mfunction! StringPart(str, start, len)[m
[32m  let bend = byteidx(a:str, a:start + a:len) - byteidx(a:str, a:start)[m
[32m  if bend < 0[m
[32m    return strpart(a:str, byteidx(a:str, a:start))[m
[32m  else[m
[32m    return strpart(a:str, byteidx(a:str, a:start), bend)[m
[32m  endif[m
[32mendfunction[m

function! SnipMid(str, len, mask) " {{{[m
  if a:len >= len(a:str)[m
    return a:str[m
[36m@@ -106,8 +115,7 @@[m [mfunction! SnipMid(str, len, mask) " {{{[m

  let len_head = (a:len - len(a:mask)) / 2[m
  let len_tail = a:len - len(a:mask) - len_head[m
  return (len_head > 0 ? [31ma:str[: len_head - 1][m[32mStringPart(a:str, 0, len_head)[m : '') . a:mask . (len_tail > 0 ? [31ma:str[-len_tail :][m[32mStringPart(a:str, len(a:str) - len_tail, len(a:str))[m  : '')
endfunction[m
" }}}[m

[36m@@ -486,7 +494,8 @@[m [mfunction! MakeTabLine()[m
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')[m
  let sep = ' : '[m
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'[m
  [31mlet[m[32m"let[m info = '(' . fnamemodify(getcwd(), ':~') . ') ' " 好きな情報を入れる
  [32mlet info = ''[m
  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示[m
endfunction[m
" }}}[m
