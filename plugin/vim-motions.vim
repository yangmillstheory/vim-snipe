function! s:GetHits(ord, motion)
  echo a:ord . a:motion
  call s:HighlightHits()
endfunction

function! s:HighlightHits()
  echo "highlighting hits"
endfunction

" nnoremap <unique> <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <SID>GetHitsForward :call <SID>GetHits(getchar(), 'f')<CR>
