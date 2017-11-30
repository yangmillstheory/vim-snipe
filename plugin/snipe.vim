" character motions
nnoremap <script> <Plug>(snipe-f) :call core#DoCharMotion('f', '')<CR>
nnoremap <script> <Plug>(snipe-F) :call core#DoCharMotion('F', '')<CR>
nnoremap <script> <Plug>(snipe-t) :call core#DoCharMotion('t', '')<CR>
nnoremap <script> <Plug>(snipe-T) :call core#DoCharMotion('T', '')<CR>
vnoremap <script> <Plug>(snipe-f) :<c-u>call core#DoCharMotion('f', visualmode())<CR>
vnoremap <script> <Plug>(snipe-F) :<c-u>call core#DoCharMotion('F', visualmode())<CR>
vnoremap <script> <Plug>(snipe-t) :<c-u>call core#DoCharMotion('t', visualmode())<CR>
vnoremap <script> <Plug>(snipe-T) :<c-u>call core#DoCharMotion('T', visualmode())<CR>
onoremap <script> <Plug>(snipe-f) :call core#DoCharMotion('f', mode(1))<CR>
onoremap <script> <Plug>(snipe-F) :call core#DoCharMotion('F', mode(1))<CR>
onoremap <script> <Plug>(snipe-t) :call core#DoCharMotion('t', mode(1))<CR>
onoremap <script> <Plug>(snipe-T) :call core#DoCharMotion('T', mode(1))<CR>

" word motions
nnoremap <script> <Plug>(snipe-w)  :call core#DoWordMotion('w', '')<CR>
nnoremap <script> <Plug>(snipe-W)  :call core#DoWordMotion('W', '')<CR>
nnoremap <script> <Plug>(snipe-e)  :call core#DoWordMotion('e', '')<CR>
nnoremap <script> <Plug>(snipe-E)  :call core#DoWordMotion('E', '')<CR>
nnoremap <script> <Plug>(snipe-b)  :call core#DoWordMotion('b', '')<CR>
nnoremap <script> <Plug>(snipe-B)  :call core#DoWordMotion('B', '')<CR>
nnoremap <script> <Plug>(snipe-ge) :call core#DoWordMotion('ge', '')<CR>
nnoremap <script> <Plug>(snipe-gE) :call core#DoWordMotion('gE', '')<CR>
vnoremap <script> <Plug>(snipe-w)  :<c-u>call core#DoWordMotion('w', visualmode())<CR>
vnoremap <script> <Plug>(snipe-W)  :<c-u>call core#DoWordMotion('W', visualmode())<CR>
vnoremap <script> <Plug>(snipe-e)  :<c-u>call core#DoWordMotion('e', visualmode())<CR>
vnoremap <script> <Plug>(snipe-E)  :<c-u>call core#DoWordMotion('E', visualmode())<CR>
vnoremap <script> <Plug>(snipe-b)  :<c-u>call core#DoWordMotion('b', visualmode())<CR>
vnoremap <script> <Plug>(snipe-B)  :<c-u>call core#DoWordMotion('B', visualmode())<CR>
vnoremap <script> <Plug>(snipe-ge) :<c-u>call core#DoWordMotion('ge', visualmode())<CR>
vnoremap <script> <Plug>(snipe-gE) :<c-u>call core#DoWordMotion('gE', visualmode())<CR>
onoremap <script> <Plug>(snipe-w)  :call core#DoWordMotion('w', mode(1))<CR>
onoremap <script> <Plug>(snipe-W)  :call core#DoWordMotion('W', mode(1))<CR>
onoremap <script> <Plug>(snipe-e)  :call core#DoWordMotion('e', mode(1))<CR>
onoremap <script> <Plug>(snipe-E)  :call core#DoWordMotion('E', mode(1))<CR>
onoremap <script> <Plug>(snipe-b)  :call core#DoWordMotion('b', mode(1))<CR>
onoremap <script> <Plug>(snipe-B)  :call core#DoWordMotion('B', mode(1))<CR>
onoremap <script> <Plug>(snipe-ge) :call core#DoWordMotion('ge', mode(1))<CR>
onoremap <script> <Plug>(snipe-gE) :call core#DoWordMotion('gE', mode(1))<CR>

" editing motions
nnoremap <script> <Plug>(snipe-f-xp) :call core#DoSwap('f')<CR>
nnoremap <script> <Plug>(snipe-F-xp) :call core#DoSwap('F')<CR>
nnoremap <script> <Plug>(snipe-f-x) :call core#DoCut('f')<CR>
nnoremap <script> <Plug>(snipe-F-x) :call core#DoCut('F')<CR>
nnoremap <script> <Plug>(snipe-f-r) :call core#DoReplace('f')<CR>
nnoremap <script> <Plug>(snipe-F-r) :call core#DoReplace('F')<CR>

call highlight#InitializeHLGroups()

augroup SmartMotionInitializeHL
  autocmd!
  autocmd ColorScheme * call highlight#InitializeHLGroups()
augroup end
