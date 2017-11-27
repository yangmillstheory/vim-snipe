" character motions
nnoremap <script> <Plug>(snipe-f) :call core#DoCharMotion(getchar(), 'f')<CR>
nnoremap <script> <Plug>(snipe-F) :call core#DoCharMotion(getchar(), 'F')<CR>
nnoremap <script> <Plug>(snipe-t) :call core#DoCharMotion(getchar(), 't')<CR>
nnoremap <script> <Plug>(snipe-T) :call core#DoCharMotion(getchar(), 'T')<CR>

" word motions
nnoremap <script> <Plug>(snipe-w)  :call core#DoWordMotion('w')<CR>
nnoremap <script> <Plug>(snipe-W)  :call core#DoWordMotion('W')<CR>
nnoremap <script> <Plug>(snipe-e)  :call core#DoWordMotion('e')<CR>
nnoremap <script> <Plug>(snipe-E)  :call core#DoWordMotion('E')<CR>
nnoremap <script> <Plug>(snipe-b)  :call core#DoWordMotion('b')<CR>
nnoremap <script> <Plug>(snipe-B)  :call core#DoWordMotion('B')<CR>
nnoremap <script> <Plug>(snipe-ge) :call core#DoWordMotion('ge')<CR>
nnoremap <script> <Plug>(snipe-gE) :call core#DoWordMotion('gE')<CR>

" editing motions
nnoremap <script> <Plug>(snipe-xp-f) :call core#DoSwap(getchar(), 'f')<CR>
nnoremap <script> <Plug>(snipe-xp-F) :call core#DoSwap(getchar(), 'F')<CR>
nnoremap <script> <Plug>(snipe-x-f) :call core#DoCut(getchar(), 'f')<CR>
nnoremap <script> <Plug>(snipe-x-F) :call core#DoCut(getchar(), 'F')<CR>

call highlight#InitializeHLGroups()

augroup SmartMotionInitializeHL
  autocmd!
  autocmd ColorScheme * call highlight#InitializeHLGroups()
augroup end
