let s:forward_motions = {'f': 1, 't': 1, 'w': 1, 'e': 1}
let s:include_motions = {'f': 1, 'F': 1}
let s:char_motions = {
      \  'f': 1,
      \  'F': 1,
      \  't': 1,
      \  'T': 1,
      \}
let s:word_motions = {
      \  'w': 1,
      \  'W': 1,
      \  'e': 1,
      \  'E': 1,
      \  'ge': 1,
      \  'gE': 1,
      \}
let s:jump_tokens = 'abcdefghijklmnopqrstuvwxyz'

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

function! s:GetJumpDict(jump_tree, ...) " {{{
  " returns a map of the jump key sequence to its jump position
  let dict = {}
  let prev_key = a:0 == 1 ? a:1 : ''

  for [jump_key, node] in items(a:jump_tree)
    let next_key = prev_key . jump_key
    if type(node) == v:t_number
      let dict[next_key] = node
    else
      call extend(dict, s:GetJumpDict(node, next_key))
    endif
  endfor

  return dict
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

function! s:GetHits(pattern, is_forward, is_inclusive) " {{{
  let orig_lnum = line('.')
  let hits = []
  let flags = ''
  if !a:is_forward
    let flags .= 'b'
  endif
  while 1
    let [lnum, cnum] = searchpos(
          \  a:pattern,
          \  flags,
          \  line('.')
          \)
    if lnum == 0 && cnum == 0
      " no more hits
      break
    elseif foldclosed(lnum) != -1
      " skip folded lines
      continue
    elseif lnum != orig_lnum
      throw 'hit on ' . join([lnum, cnum], ',') . ' is on wrong '
            \'line, expected lnum ' . orig_lnum
    endif

    if !a:is_inclusive
      if a:is_forward
        let cnum -= 1
      else
        let cnum += 1
      endif
    endif
    call add(hits, cnum)
  endwhile

  return hits
endfunction
" }}}

function! s:SafeSetLine(lnum, line) " {{{
  undojoin
  call setline(a:lnum, a:line)
  redraw
endfunction
" }}}

function! s:GetJumpCol(jump_tree) " {{{
  let first_lvl = values(a:jump_tree)
  if len(first_lvl) == 1
    return first_lvl[0]
  endif
  let jump_dict = s:GetJumpDict(a:jump_tree)
  let lnum = line('.')
  let orig_line = getline(lnum)
  let hl_ids = []
  let hl_line = orig_line
  for [jump_seq, jump_col] in items(jump_dict)
    " https://github.com/yangmillstheory/vim-easymotion/blob/1e775c341eb6a0a4075b2dcb2475f7d10b876187/autoload/EasyMotion.vim#L989
    let hit_len = strdisplaywidth(matchstr(orig_line, '\%' . jump_col . 'c.'))
    let seq_len = strdisplaywidth(jump_seq)
    let hl_line = substitute(
          \hl_line, '\%' . jump_col . 'c.',
          \jump_seq . repeat(' ', hit_len - seq_len),
          \'')
    call add(hl_ids, matchaddpos(g:smart_motion_hl1_group, [[lnum, jump_col]]))
  endfor

  call s:SafeSetLine(lnum, hl_line)

  let ord_pressed = getchar()
  let key_pressed = nr2char(ord_pressed)

  for hl_id in hl_ids
    call matchdelete(hl_id)
  endfor
  call s:SafeSetLine(lnum, orig_line)

  if key_pressed == 27
    return
  elseif empty(key_pressed)
    throw 'Jump cancelled!'
  elseif !has_key(a:jump_tree, key_pressed)
    throw 'Invalid key: ' . key_pressed
  endif

  let node = a:jump_tree[key_pressed]

  if type(node) == v:t_number
    return node
  endif
  return s:GetJumpCol(node)
endfunction
" }}}

function! core#DoMotion(ord, motion) " {{{
  if a:ord == 27
    " escape key pressed
    return
  endif
  let char = nr2char(a:ord)
  let pattern = '\C'
  if has_key(s:word_motions, a:motion)
    throw 'Not implemented'
  elseif has_key(s:char_motions, a:motion)
    let pattern .= escape(char, '.$^~')
  else
    " TODO: pull out into logging utility
    echom 'vim-snipe: motion ' . a:motion . ' not implemented.'
    return
  endif
  let hits = s:GetHits(
        \  pattern,
        \  has_key(s:forward_motions, a:motion),
        \  has_key(s:include_motions, a:motion)
        \)
  if len(hits) == 0
    return
  endif
  let orig_pos = [line('.'), col('.')]
  let jump_col = s:GetJumpCol(s:GetJumpTree(hits))
  call cursor(orig_pos[0], orig_pos[1])
  mark '
  call cursor(orig_pos[0], jump_col)
endfunction
" }}}

" vim: fdm=marker
