# vim-snipe

**Warning: this is a work in progress!**

<p align="center">
  <img alt="vim-snipe" src="https://user-images.githubusercontent.com/2729079/33256249-23767e84-d306-11e7-952d-b19821edc2ce.gif">
</p>

### Getting started

TL;DR:

```vim
" ... all possible mappings are in plugin/snipe.vim
nmap <leader><leader>F <Plug>(smart-motion-F)
nmap <leader><leader>f <Plug>(smart-motion-f)
```

### TODO

* [X] cuts
* [X] swaps
* [ ] inserts
* [ ] replacements
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
