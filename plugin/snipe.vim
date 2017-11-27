nnoremap <script> <Plug>(smart-motion-f) :call core#DoCharMotion(getchar(), 'f')<CR>
nnoremap <script> <Plug>(smart-motion-F) :call core#DoCharMotion(getchar(), 'F')<CR>
nnoremap <script> <Plug>(smart-motion-t) :call core#DoCharMotion(getchar(), 't')<CR>
nnoremap <script> <Plug>(smart-motion-T) :call core#DoCharMotion(getchar(), 'T')<CR>

call highlight#InitializeHLGroups()

augroup SmartMotionInitializeHL
  autocmd!
  autocmd ColorScheme * call highlight#InitializeHLGroups()
augroup end
