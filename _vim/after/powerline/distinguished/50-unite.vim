call Pl#Statusline(
  \ Pl#Match('&filetype', 'unite'),
  \
  \ Pl#Segment("  %-2{Stl_GetMode()} ",
  \ Pl#HiCurrent(   Pl#FG( 22), Pl#BG(148), Pl#Attr('bold')),
  \ Pl#HiInsert(    Pl#FG( 23), Pl#BG(231), Pl#Attr('bold'))
  \ ),
  \
  \ Pl#SegmentGroup(
    \ Pl#HiCurrent(   Pl#BG(240)),
    \ Pl#HiInsert(    Pl#BG( 31)),
    \ Pl#HiNonCurrent(Pl#BG(235)),
    \ Pl#Segment(' %{"unite"} ',
      \ Pl#HiCurrent(   Pl#FG(231), Pl#Attr('bold')),
      \ Pl#HiInsert(    Pl#FG(231), Pl#Attr('bold')),
      \ Pl#HiNonCurrent(Pl#FG(245), Pl#Attr('bold'))
      \ ),
    \ ),
  \
  \ Pl#Split(
    \ Pl#HiCurrent(   Pl#BG(236)),
    \ Pl#HiInsert(    Pl#BG( 24)),
    \ Pl#HiNonCurrent(Pl#BG(234))
    \ )
  \ )
