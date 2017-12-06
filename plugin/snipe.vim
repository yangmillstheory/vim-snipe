" character motions
nnoremap <script> <Plug>(snipe-f) :call snipe#core#DoCharMotion('f', '')<CR>
nnoremap <script> <Plug>(snipe-F) :call snipe#core#DoCharMotion('F', '')<CR>
nnoremap <script> <Plug>(snipe-t) :call snipe#core#DoCharMotion('t', '')<CR>
nnoremap <script> <Plug>(snipe-T) :call snipe#core#DoCharMotion('T', '')<CR>
vnoremap <script> <Plug>(snipe-f) :<c-u>call snipe#core#DoCharMotion('f', visualmode())<CR>
vnoremap <script> <Plug>(snipe-F) :<c-u>call snipe#core#DoCharMotion('F', visualmode())<CR>
vnoremap <script> <Plug>(snipe-t) :<c-u>call snipe#core#DoCharMotion('t', visualmode())<CR>
vnoremap <script> <Plug>(snipe-T) :<c-u>call snipe#core#DoCharMotion('T', visualmode())<CR>
onoremap <script> <Plug>(snipe-f) :call snipe#core#DoCharMotion('f', mode(1))<CR>
onoremap <script> <Plug>(snipe-F) :call snipe#core#DoCharMotion('F', mode(1))<CR>
onoremap <script> <Plug>(snipe-t) :call snipe#core#DoCharMotion('t', mode(1))<CR>
onoremap <script> <Plug>(snipe-T) :call snipe#core#DoCharMotion('T', mode(1))<CR>

" word motions
nnoremap <script> <Plug>(snipe-w)  :call snipe#core#DoWordMotion('w', '')<CR>
nnoremap <script> <Plug>(snipe-W)  :call snipe#core#DoWordMotion('W', '')<CR>
nnoremap <script> <Plug>(snipe-e)  :call snipe#core#DoWordMotion('e', '')<CR>
nnoremap <script> <Plug>(snipe-E)  :call snipe#core#DoWordMotion('E', '')<CR>
nnoremap <script> <Plug>(snipe-b)  :call snipe#core#DoWordMotion('b', '')<CR>
nnoremap <script> <Plug>(snipe-B)  :call snipe#core#DoWordMotion('B', '')<CR>
nnoremap <script> <Plug>(snipe-ge) :call snipe#core#DoWordMotion('ge', '')<CR>
nnoremap <script> <Plug>(snipe-gE) :call snipe#core#DoWordMotion('gE', '')<CR>
vnoremap <script> <Plug>(snipe-w)  :<c-u>call snipe#core#DoWordMotion('w', visualmode())<CR>
vnoremap <script> <Plug>(snipe-W)  :<c-u>call snipe#core#DoWordMotion('W', visualmode())<CR>
vnoremap <script> <Plug>(snipe-e)  :<c-u>call snipe#core#DoWordMotion('e', visualmode())<CR>
vnoremap <script> <Plug>(snipe-E)  :<c-u>call snipe#core#DoWordMotion('E', visualmode())<CR>
vnoremap <script> <Plug>(snipe-b)  :<c-u>call snipe#core#DoWordMotion('b', visualmode())<CR>
vnoremap <script> <Plug>(snipe-B)  :<c-u>call snipe#core#DoWordMotion('B', visualmode())<CR>
vnoremap <script> <Plug>(snipe-ge) :<c-u>call snipe#core#DoWordMotion('ge', visualmode())<CR>
vnoremap <script> <Plug>(snipe-gE) :<c-u>call snipe#core#DoWordMotion('gE', visualmode())<CR>
onoremap <script> <Plug>(snipe-w)  :call snipe#core#DoWordMotion('w', mode(1))<CR>
onoremap <script> <Plug>(snipe-W)  :call snipe#core#DoWordMotion('W', mode(1))<CR>
onoremap <script> <Plug>(snipe-e)  :call snipe#core#DoWordMotion('e', mode(1))<CR>
onoremap <script> <Plug>(snipe-E)  :call snipe#core#DoWordMotion('E', mode(1))<CR>
onoremap <script> <Plug>(snipe-b)  :call snipe#core#DoWordMotion('b', mode(1))<CR>
onoremap <script> <Plug>(snipe-B)  :call snipe#core#DoWordMotion('B', mode(1))<CR>
onoremap <script> <Plug>(snipe-ge) :call snipe#core#DoWordMotion('ge', mode(1))<CR>
onoremap <script> <Plug>(snipe-gE) :call snipe#core#DoWordMotion('gE', mode(1))<CR>

" editing motions
nnoremap <script> <Plug>(snipe-f-xp) :call snipe#core#DoSwap('f')<CR>
nnoremap <script> <Plug>(snipe-F-xp) :call snipe#core#DoSwap('F')<CR>
nnoremap <script> <Plug>(snipe-f-x) :call snipe#core#DoCut('f')<CR>
nnoremap <script> <Plug>(snipe-F-x) :call snipe#core#DoCut('F')<CR>
nnoremap <script> <Plug>(snipe-f-r) :call snipe#core#DoReplace('f')<CR>
nnoremap <script> <Plug>(snipe-F-r) :call snipe#core#DoReplace('F')<CR>
nnoremap <script> <Plug>(snipe-f-i) :call snipe#core#DoInsert('f')<CR>
nnoremap <script> <Plug>(snipe-F-i) :call snipe#core#DoInsert('F')<CR>
nnoremap <script> <Plug>(snipe-f-a) :call snipe#core#DoAppend('f')<CR>
nnoremap <script> <Plug>(snipe-F-a) :call snipe#core#DoAppend('F')<CR>

call snipe#highlight#InitializeHLGroups()

augroup SmartMotionInitializeHL
  autocmd!
  autocmd ColorScheme * call snipe#highlight#InitializeHLGroups()
augroup end
