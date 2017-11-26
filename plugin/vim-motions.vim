let s:forward_motions = {'f': 1, 't': 1}
let s:jump_tokens = 'abcdefghijklmnopqrstuvwxyz'
" let s:jump_tokens = 'abc'

function! s:GetHitCounts(hits_rem) " {{{
  " returns a list corresponding to s:jump_tokens; each
  " count represents how many hits are in the subtree
  " rooted at the corresponding jump token
  let n_jump_tokens = len(s:jump_tokens)
  let n_hits = repeat([0], n_jump_tokens)
  let hits_rem = a:hits_rem

  let is_first_lvl = 1
  while hits_rem > 0
    " if we can't fit all the hits in the first lvl,
    " fit the remainder starting from the last jump token
    let n_children = is_first_lvl
          \ ? 1
          \ : n_jump_tokens - 1
    for j in range(n_jump_tokens)
      let n_hits[j] += n_children
      let hits_rem -= n_children
      if hits_rem <= 0
        let n_hits[j] += hits_rem
        break
      endif
    endfor
    let is_first_lvl = 0
  endwhile

  return reverse(n_hits)
endfunction
" }}}

function! s:CreateCoordKeyDict(groups, ...) " {{{
  " Dict structure:
  " 1,2 : a
  " 2,3 : b
  let coord_keys = {}
  let sort_list = []
  let group_key = a:0 == 1 ? a:1 : ''

  for [key, item] in items(a:groups)
    let key = ( ! empty(group_key) ? group_key : key)

    if type(item) == 3
      " Destination coords

      " The key needs to be zero-padded in order to
      " sort correctly
      let dict_key = printf('%05d,%05d', item[0], item[1])
      let coord_keys[dict_key] = key

      " We need a sorting list to loop correctly in
      " PromptUser, dicts are unsorted
      call add(sort_list, dict_key)
    else
      " Item is a dict (has children)
      let coord_key_dict = s:CreateCoordKeyDict(item, key)

      " Make sure to extend both the sort list and the
      " coord key dict
      call extend(sort_list, coord_key_dict[0])
      call extend(coord_keys, coord_key_dict[1])
    endif

    unlet item
  endfor

  return [sort_list, coord_keys]
endfunction
" }}}

function! s:GetJumpTree(hits) " {{{
  " returns a tree where non-leaf nodes are jump tokens and leaves are coordinates
  " (tuples) of hits.
  "
  " each level of the tree is filled such that the average path depth of the tree
  " is minimized and the closest hits come first first.
  let tree = {}

  " i: index into hits
  " j: index into jump tokens
  let i = 0
  let j = 0
  for n_children in s:GetHitCounts(len(a:hits))
    let node = s:jump_tokens[j]
    if n_children == 1
      let tree[node] = a:hits[i]
    elseif n_children > 1
      let tree[node] = s:GetJumpTree(a:hits[i:i + n_children - 1])
    else
      continue
    endif
    let j += 1
    let i += n_children
  endfor
  return tree
endfunction
" }}}

function! GetJumpPos(jump_tree) " {{{
  let first_lvl = values(a:jump_tree)
  if len(first_lvl) == 1
    return first_lvl[0]
  endif
endfunction
" }}}

function! GetNextJumpToken(jump_tree) " {{{

endfunction
" }}}

function! s:GetHits(char, motion) " {{{
  let hits = []
  let flags = ''
  if !has_key(s:forward_motions, a:motion)
    let flags += 'b'
  endif
  while 1
    let [lnum, cnum] = searchpos(
          \'\C' . escape(a:char, '.$^~'),
          \flags,
          \line('.')
          \)
    if lnum == 0 && cnum == 0
      " no more hits
      break
    elseif foldclosed(lnum) != -1
      " skip folded lines
      continue
    endif
    call add(hits, [lnum, cnum])
  endwhile
  return hits
endfunction
" }}}

function! s:DoMotion(ord, motion) " {{{
  if a:ord == 27
    " escape key pressed
    return
  endif
  let orig = [line('.'), col('.')]
  let char = nr2char(a:ord)
  let hits = s:GetHits(char, a:motion)
  let tree = s:GetJumpTree(hits)
  let jump_pos = s:GetJumpPos(tree)
  echom string(hits)
  echom string(tree)
endfunction
" }}}

" nnoremap <unique> <script> <Plug>ForwardMotions <SID>GetHitsForward
nnoremap <script> <Plug>ForwardMotion <SID>DoMotionForward
nnoremap <script> <Plug>ReverseMotion <SID>DoMotionReverse
nnoremap <SID>DoMotionForward :call <SID>DoMotion(getchar(), 'f')<CR>
nnoremap <SID>DoMotionReverse :call <SID>DoMotion(getchar(), 'F')<CR>

" vim: fdm=marker
