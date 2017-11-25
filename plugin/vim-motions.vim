let s:forward_motions = {'f': 1, 't': 1}

function! s:PromptUser()
  " code
endfunction

function! s:GetHits(ord, motion)
  let hits = []
  let search_dir = has_key(s:forward_motions, a:motion) ? '' : 'b'
  while 1
    let [lnum, cnum] = searchpos(
\     '\C' . escape(char, '.$^~'),
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
  return hits
endfunction

function! s:HighlightHits()
  echom "highlighting hits"
endfunction

function! s:DoMotion(ord, motion)
  let char = nr2char(a:ord)
  if char == 27
    " escape key pressed
    return
  endif
  let hits = s:GetHits(a:ord, a:motion)
endfunction

" nnoremap <unique> <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <script> <Plug>ForwardMotion <SID>DoMotionForward
nnoremap <script> <Plug>ReverseMotion <SID>DoMotionReverse
nnoremap <SID>DoMotionForward :call <SID>DoMotion(getchar(), 'f')<CR>
nnoremap <SID>DoMotionReverse :call <SID>DoMotion(getchar(), 'F')<CR>
