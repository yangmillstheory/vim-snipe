# vim-snipe

**Warning: this is a work in progress!**

<p align="center">
  <img alt="vim-snipe" src="https://user-images.githubusercontent.com/2729079/33256249-23767e84-d306-11e7-952d-b19821edc2ce.gif">
</p>

### Getting started

Character motions

```vim
nmap <leader><leader>F <Plug>(snipe-F)
nmap <leader><leader>f <Plug>(snipe-f)
nmap <leader><leader>T <Plug>(snipe-T)
nmap <leader><leader>t <Plug>(snipe-t)
```

Word motions

```vim
nmap <leader><leader>w <Plug>(snipe-w)
nmap <leader><leader>W <Plug>(snipe-W)
nmap <leader><leader>e <Plug>(snipe-e)
nmap <leader><leader>E <Plug>(snipe-E)
nmap <leader><leader>b <Plug>(snipe-b)
nmap <leader><leader>B <Plug>(snipe-B)
nmap <leader><leader>ge <Plug>(snipe-ge)
nmap <leader><leader>gE <Plug>(snipe-gE)
```

Swap `xp`

```vim
nmap <leader><leader>] <Plug>(snipe-f-xp)
nmap <leader><leader>[ <Plug>(snipe-f-xp)
```

Cut `x`

```vim
nmap <leader><leader>> <Plug>(snipe-f-x)
nmap <leader><leader>< <Plug>(snipe-F-x)
```

Replace `r`

```vim
nmap <leader><leader>. <Plug>(snipe-f-r)
nmap <leader><leader>, <Plug>(snipe-F-r)
```

Substitute `s`

```vim
nmap <leader><leader>+ <Plug>(snipe-f-s)
nmap <leader><leader>- <Plug>(snipe-F-s)
```

### TODO

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

All motions are constrained on `line('.')`. This is both more natural and more performant, and with `set relativenumber`, there's
no need to scan the entire buffer for `b`, `e`, `w` and friends.

There ~are~ will be motions for targeted insertions, cuts, and swaps.
