nnoremap <script> <Plug>(smart-motion-f) :call core#DoCharMotion(getchar(), 'f')<CR>
nnoremap <script> <Plug>(smart-motion-F) :call core#DoCharMotion(getchar(), 'F')<CR>
nnoremap <script> <Plug>(smart-motion-t) :call core#DoCharMotion(getchar(), 't')<CR>
nnoremap <script> <Plug>(smart-motion-T) :call core#DoCharMotion(getchar(), 'T')<CR>

nnoremap <script> <Plug>(smart-motion-w)  :call core#DoWordMotion('w')<CR>
nnoremap <script> <Plug>(smart-motion-W)  :call core#DoWordMotion('W')<CR>
nnoremap <script> <Plug>(smart-motion-e)  :call core#DoWordMotion('e')<CR>
nnoremap <script> <Plug>(smart-motion-E)  :call core#DoWordMotion('E')<CR>
nnoremap <script> <Plug>(smart-motion-b)  :call core#DoWordMotion('b')<CR>
nnoremap <script> <Plug>(smart-motion-B)  :call core#DoWordMotion('B')<CR>
nnoremap <script> <Plug>(smart-motion-ge) :call core#DoWordMotion('ge')<CR>
nnoremap <script> <Plug>(smart-motion-gE) :call core#DoWordMotion('gE')<CR>

call highlight#InitializeHLGroups()

augroup SmartMotionInitializeHL
  autocmd!
  autocmd ColorScheme * call highlight#InitializeHLGroups()
augroup end
