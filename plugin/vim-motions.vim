let s:forward_motions = {'f': 1, 't': 1}

function! s:GetHits(ord, motion)
  let hits = []
  let char = nr2char(a:ord)
  if char == 27
    " escape key pressed
    return
  endif
  let search_dir = has_key(s:forward_motions, a:motion) ? '' : 'b'
  while 1
    let [lnum, cnum] = searchpos(
\     '\C' . escape(nr2char(a:ord), '.$^~'),
\     search_dir,
\     line('.')
\   )
    if lnum == 0 && cnum == 0
      " no more hits
      break
    elseif foldclosed(lnum) != -1
      " skip folded lines
      continue
    endif
    call add(hits, [lnum, cnum])
  endwhile
  echom string(hits)
  call s:HighlightHits()
endfunction

function! s:HighlightHits()
  echom "highlighting hits"
endfunction

" nnoremap <unique> <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <script> <Plug>ReverseMotions <SID>GetHitsReverse
nnoremap <SID>GetHitsForward :call <SID>GetHits(getchar(), 'f')<CR>
nnoremap <SID>GetHitsReverse :call <SID>GetHits(getchar(), 'F')<CR>
