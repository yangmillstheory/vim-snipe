# vim-snipe

**Warning: this is a work in progress!**

### Installing

If you use a plugin manager such as [vim-plug](https://github.com/junegunn/vim-plug)
this is as simple as

```vim
Plug 'yangmillstheory/vim-snipe'
```

### Usage

Character motions

> Jump forward to an "e"

![f](https://user-images.githubusercontent.com/2729079/33358485-c2981e28-d47d-11e7-9f88-739cb73a92f9.gif)

```vim
nmap <leader><leader>F <Plug>(snipe-F)
nmap <leader><leader>f <Plug>(snipe-f)
nmap <leader><leader>T <Plug>(snipe-T)
nmap <leader><leader>t <Plug>(snipe-t)
```

Word motions

> Jump to a previous start of word

![b](https://user-images.githubusercontent.com/2729079/33358540-17101a5a-d47e-11e7-9fef-9520662356b0.gif)

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

> Fix the typo in "croe"

![xp](https://user-images.githubusercontent.com/2729079/33358623-8b80a742-d47e-11e7-8c46-e800b5e17e9a.gif)

```vim
nmap <leader><leader>] <Plug>(snipe-f-xp)
nmap <leader><leader>[ <Plug>(snipe-f-xp)
```

Cut `x`

> Cut an extra `,`

![x](https://user-images.githubusercontent.com/2729079/33358650-b9777c34-d47e-11e7-842a-3756cda89ddc.gif)

```vim
nmap <leader><leader>x <Plug>(snipe-f-x)
nmap <leader><leader>X <Plug>(snipe-F-x)
```

Replace `r`

> Replace a previous "o"

![r](https://user-images.githubusercontent.com/2729079/33358695-fa0d6736-d47e-11e7-95f4-6850520498c6.gif)

```vim
nmap <leader><leader>r <Plug>(snipe-f-r)
nmap <leader><leader>R <Plug>(snipe-F-r)
```

### TODO

* [ ] docs

### FAQ

> But doesn't [vim-easymotion](https://github.com/easymotion/vim-easymotion/) do the same thing?

No, and [it does too much.](https://www.reddit.com/r/vim/comments/1v9qyu/actively_developed_and_maintained_fork_of/ceq7lcf/)

> Why didn't you extend it instead?

After looking at the code, it's indeed monolithic, large, sprawling, and (in my opinion) painful and unpleasant
to extend.

To be fair, [the core algorithm is almost the same](https://github.com/easymotion/vim-easymotion/pull/359).

> How is it different?

All motions are constrained on `line('.')`. This is both more natural and more performant, and with `set relativenumber`, there's
no need to scan the entire buffer for `b`, `e`, `w` and friends.

There are will be motions for targeted insertions, cuts, and swaps.

