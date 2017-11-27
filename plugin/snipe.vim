nnoremap <script> <Plug>(smart-motion-f) :call core#DoMotion(getchar(), 'f')<CR>
nnoremap <script> <Plug>(smart-motion-F) :call core#DoMotion(getchar(), 'F')<CR>
nnoremap <script> <Plug>(smart-motion-t) :call core#DoMotion(getchar(), 't')<CR>
nnoremap <script> <Plug>(smart-motion-T) :call core#DoMotion(getchar(), 'T')<CR>

call highlight#InitializeHLGroups()

augroup SmartMotionInitializeHL
  autocmd!
  autocmd ColorScheme * call highlight#InitializeHLGroups()
augroup end
