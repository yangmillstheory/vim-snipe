# vim-snipe

> Warning: this is a work in progress!

![nov-26-2017 21-38-00](https://user-images.githubusercontent.com/2729079/33252297-1aab5d24-d2f2-11e7-9200-da6bb39e947b.gif)

### TL;DR

```vim
nmap <leader><leader>F <Plug>(smart-motion-F)
nmap <leader><leader>f <Plug>(smart-motion-f)
nmap <leader><leader>T <Plug>(smart-motion-T)
nmap <leader><leader>t <Plug>(smart-motion-t)
nmap <leader><leader>w <Plug>(smart-motion-w)
nmap <leader><leader>W <Plug>(smart-motion-W)
nmap <leader><leader>e <Plug>(smart-motion-e)
nmap <leader><leader>E <Plug>(smart-motion-E)
nmap <leader><leader>b <Plug>(smart-motion-b)
nmap <leader><leader>B <Plug>(smart-motion-B)
nmap <leader><leader>ge <Plug>(smart-motion-ge)
nmap <leader><leader>gE <Plug>(smart-motion-gE)
```

### TODO

* [ ] cuts
* [ ] swaps
* [ ] inserts
* [ ] visual mode
* [ ] operator mode
* [ ] docs

### FAQ

> But doesn't [vim-easymotion](https://github.com/easymotion/vim-easymotion/) do the same thing?

[It does too much.](https://www.reddit.com/r/vim/comments/1v9qyu/actively_developed_and_maintained_fork_of/ceq7lcf/)

After looking at the code, it's indeed monolithic, large, sprawling, and (in my opinion) painful and unpleasant
to extend.  So, I'm writing my own implementation to add some different features and solve my own problems.

To be fair, [the core algorithm is almost the same](https://github.com/easymotion/vim-easymotion/pull/359).

> How is it different from `vim-easymotion`?

All motions are constrained on `line('.')`. This is both more natural and more performant.

There ~are~ will be motions for targeted insertions, cuts, and swaps.
