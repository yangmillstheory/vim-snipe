function! s:GetHits(ord, motion)
  let search_dir = a:motion == 'f' ? '' : 'b'
  let hits = []
  while 1
    let hit = searchpos(
\     '\C' . escape(nr2char(a:ord), '.$^~'),
\     search_dir,
\     line('.')
\   )
    if hit == [0, 0]
      " no more hits
      break
    elseif foldclosed(hit[0]) != -1
      " skip folded lines
      continue
    endif
    call add(hits, hit)
  endwhile
  echom string(hits)
  call s:HighlightHits()
endfunction

function! s:HighlightHits()
  echom "highlighting hits"
endfunction

" nnoremap <unique> <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <SID>GetHitsForward :call <SID>GetHits(getchar(), 'f')<CR>
