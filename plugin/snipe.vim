onoremap <script> <Plug>(snipe-t) :call core#DoCharMotion('t')<CR>
vnoremap <script> <Plug>(snipe-t) :<c-u>call core#DoCharMotion('t')<CR>
nnoremap <script> <Plug>(snipe-T) :call core#DoCharMotion('T')<CR>
onoremap <script> <Plug>(snipe-T) :call core#DoCharMotion('T')<CR>
vnoremap <script> <Plug>(snipe-T) :<c-u>call core#DoCharMotion('T')<CR>

" word motions
nnoremap <script> <Plug>(snipe-w)  :call core#DoWordMotion('w')<CR>
