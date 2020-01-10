if exists('loaded_snipe') " {{{
    finish
endif

let loaded_snipe = 1
" }}}

" private variables {{{
let s:known_modes = {'no': 1, 'v': 1, '': 1}
let s:esc_ord = 27
let s:cr_ord = 13
let s:forward_motions = {
      \  'f': 1,
      \  't': 1,
      \  'w': 1,
      \  'W': 1,
      \  'e': 1,
      \  'E': 1,
      \}
if !exists('g:snipe_jump_tokens')
  let g:snipe_jump_tokens = 'asdfghjklqwertyuiopzxcvbnm'
endif
" }}}

function! s:GetTargetCounts(targets_rem) " {{{
  " returns a list corresponding to g:snipe_jump_tokens; each
  " count represents how many targets are in the subtree
  " rooted at the corresponding jump token
  let n_jump_tokens = len(g:snipe_jump_tokens)
  let target_counts = repeat([0], n_jump_tokens)
  let targets_rem = a:targets_rem

  let is_first_lvl = 1
  while targets_rem > 0
    " if we can't fit all the targets in the first lvl,
    " fit the remainder starting from the last jump token
    let n_children = is_first_lvl
          \ ? 1
          \ : n_jump_tokens - 1
    for j in range(n_jump_tokens)
      let target_counts[j] += n_children
      let targets_rem -= n_children
      if targets_rem <= 0
        let target_counts[j] += targets_rem
        break
      endif
    endfor
    let is_first_lvl = 0
  endwhile

  return reverse(target_counts)
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

function! s:GetJumpTree(targets) " {{{
  " returns a tree where non-leaf nodes are jump tokens and leaves are column numbers
  "
  " each level of the tree is filled such that the average path depth of the tree
  " is minimized and the closest targets come first.
  let tree = {}

  " i: index into targets
  " j: index into jump tokens
  let i = 0
  let j = 0
  for n_children in s:GetTargetCounts(len(a:targets))
    let node = g:snipe_jump_tokens[j]
    if n_children == 1
      let tree[node] = a:targets[i]
    elseif n_children > 1
      let tree[node] = s:GetJumpTree(a:targets[i:i + n_children - 1])
    else
      continue
    endif
    let j += 1
    let i += n_children
  endfor
  return tree
endfunction
" }}}

function! s:GetCharTargets(motion, target) " {{{
  let targets = []

  let start_lnum = line('.')
  let start_cnum = col('.')

  if foldclosed(start_lnum) != -1
    normal! zo
    call cursor(start_lnum, start_cnum)
  endif

  let first_pass = 1
  let prev_cnum = start_cnum
  while 1
    let cmd = first_pass
          \ ? a:motion . a:target
          \ : ';'
    execute 'keepjumps normal! ' . cmd
    let next_cnum = col('.')
    if next_cnum == prev_cnum
      if a:motion ==? 't' && first_pass
        " prevent the the loop from exiting early and provide correction
        let [dir_key_start, delta, dir_key_end] = a:motion ==# 't'
              \ ? ['l', +1, 'h']
              \ : ['h', -1, 'l']
        " look ahead one token since the next iteration will
        "
        "   execute 'normal! ;'
        "
        " thus potentially missing the first target
        let saved = @@
        execute 'normal! 2' . dir_key_start . 'vy' . dir_key_end
        if @@ ==# a:target
          call add(targets, next_cnum + delta)
        endif
        let @@ = saved
      else
        break
      endif
    else
      call add(targets, next_cnum)
    endif
    let [first_pass, prev_cnum] = [0, next_cnum]
  endwhile

  call cursor(start_lnum, start_cnum)
  return targets
endfunction
""" }}}

function! s:SafeSetLine(lnum, line) " {{{
  " note: this modifies the buffer
  try | silent undojoin | catch | endtry
  call setline(a:lnum, a:line)
  redraw
endfunction

let s:buf = 0
function! s:OpenFlagWindow(lnum, line, jump_items)
  let hl_line = a:line

  let winid = win_getid()
  let winpos = win_screenpos(winid)
  let pos = screenpos(winid, a:lnum, 1)
  let pos2 = screenpos(winid, a:lnum, len(hl_line))
  let opt = {'focusable': v:false,
        \ 'relative': 'editor',
        \ 'row': pos.row-1,
        \ 'col': pos.col-1,
        \ 'width': winwidth(0) - (pos.col - winpos[1]),
        \ 'height': pos2.row - pos.row + 1,
        \ 'style': 'minimal'}
  if empty(s:buf) || !bufexists(s:buf)
    let s:buf = nvim_create_buf(0, 1)
    call nvim_buf_set_option(s:buf, 'syntax', 'off')
  endif
  let winid = nvim_open_win(s:buf, 0, opt)

  let hl_ids = []
  for [jump_seq, jump_col] in a:jump_items
    " this loop builds the highlighted line, adding highlights from left to right;
    " multi-token jump sequences will only show the first token.
    let hl_line = substitute(hl_line, '\%' . jump_col . 'c.', jump_seq[0], '')
    call add(hl_ids, matchaddpos(g:snipe_hl1_group, [[1, jump_col]], 10, -1, {'window': winid}))
  endfor
  call nvim_buf_set_lines(s:buf, 0, -1, 0, [hl_line])
  return winid
endfunction
" }}}

function! s:GetInput(message) " {{{
  redraw | echo a:message
  let ord = getchar()
  normal :<c-u>
  return ord
endfunction
" }}}

function! s:GetJumpCol(jump_tree) " {{{
  " FIXME remove side effects, like highlighting, or rename
  let first_lvl = values(a:jump_tree)
  if len(first_lvl) == 1
    return first_lvl[0]
  endif
  let jump_dict = s:GetJumpDict(a:jump_tree)
  let lnum = line('.')
  let orig_line = getline(lnum)
  let hl_ids = []
  let hl_line = orig_line

  function! SortAscByJumpCol(x, y)
    return a:x[1] - a:y[1]
  endfunction

  let jump_items = items(jump_dict)
  call sort(jump_items, 'SortAscByJumpCol')

  if !get(g:, 'snipe_float_window', exists('*nvim_open_win'))
    for [jump_seq, jump_col] in jump_items
      " this loop builds the highlighted line, adding highlights from left to right;
      " multi-token jump sequences will only show the first token.
      let hl_line = substitute(hl_line, '\%' . jump_col . 'c.', jump_seq[0], '')
      call add(hl_ids, matchaddpos(g:snipe_hl1_group, [[1, jump_col]]))
    endfor

    let modified = &modified
    call s:SafeSetLine(lnum, hl_line)
  else
    let win = s:OpenFlagWindow(lnum, hl_line, jump_items)
  endif

  let ord_pressed = s:GetInput('Enter key: ')
  let key_pressed = nr2char(ord_pressed)

  for hl_id in hl_ids | call matchdelete(hl_id) | endfor
  if !get(g:, 'snipe_float_window', exists('*nvim_open_win'))
    call s:SafeSetLine(lnum, orig_line)
    if !modified
      set nomodified
    endif
  else
    call nvim_win_close(win, 1)
  endif

  if ord_pressed == s:esc_ord || key_pressed ==# nr2char(s:cr_ord)
    echom 'Jump cancelled.' | return
  elseif !has_key(a:jump_tree, key_pressed)
    echom 'Invalid key: ' . key_pressed | return
  endif

  let node = a:jump_tree[key_pressed]

  if type(node) == v:t_number
    return node
  endif
  return s:GetJumpCol(node)
endfunction
" }}}

function! snipe#core#DoCharMotion(motion, mode) " {{{
  " returns 1 if the motion was successful, 0 in case
  " there was nowhere to jump to or the jump was cancelled
  let ord = s:GetInput('Enter target: ')
  if ord == s:esc_ord | return 0 | endif
  let targets = s:GetCharTargets(a:motion, nr2char(ord))
  if len(targets) == 0
    return 0
  endif
  let jump_tree = s:GetJumpTree(targets)
  let jump_col = s:GetJumpCol(jump_tree)
  if !jump_col
    return 0
  endif
  call <SID>Jump(jump_col, a:mode)
  return 1
endfunction
" }}}

function! s:GetWordTargets(motion) " {{{
  let targets = []
  let orig_winview = winsaveview()
  let orig_curpos = getcurpos()
  if has_key(s:forward_motions, a:motion)
    normal G$
  else
    normal gg
  endif
  let endpos = getcurpos()
  call setpos('.', orig_curpos)
  while 1
    execute 'keepjumps normal! ' . a:motion
    let curpos = getcurpos()
    let lnum = curpos[1]
    let cnum = curpos[2]
    if lnum != orig_curpos[1]
      break
    endif
    call add(targets, cnum)
    if curpos[:-2] == endpos[:-2]
      break
    endif
  endwhile
  call setpos('.', orig_curpos)
  call winrestview(orig_winview)
  return targets
endfunction
" }}}

function! snipe#core#DoWordMotion(motion, mode) " {{{
  if !has_key(s:known_modes, a:mode)
    return
  endif
  let targets = s:GetWordTargets(a:motion)
  if len(targets) == 0
    return
  endif
  let jump_tree = s:GetJumpTree(targets)
  let jump_col = s:GetJumpCol(jump_tree)
  if !jump_col
    return
  endif
  call <SID>Jump(jump_col, a:mode)
endfunction
" }}}

function! DoAndGoBack(f) " {{{
  let q_mark_pos = getpos("'q")
  normal mq
  call a:f()
  normal `q
  call setpos("'q", q_mark_pos)
endfunction
" }}}

function! s:Jump(jump_col, mode) " {{{
  let jump_col = a:jump_col
  if a:mode ==# 'v'
    normal! v
  elseif a:mode ==# 'no'
    let jump_col += col('.') < a:jump_col
  endif
  call cursor(line('.'), jump_col)
endfunction
" }}}

function! snipe#core#DoSwap(motion) " {{{
  function! DoSwap(...)
    let saved = @"
    let did_jump = snipe#core#DoCharMotion(a:1, '')
    if did_jump
      normal xp
    endif
    let @" = saved
  endfunction
  call DoAndGoBack(function('DoSwap', [a:motion]))
endfunction
" }}}

function! snipe#core#DoCut(motion) " {{{
  function! DoCut(...)
    let did_jump = snipe#core#DoCharMotion(a:1, '')
    if did_jump
      normal "_x
    endif
  endfunction
  call DoAndGoBack(function('DoCut', [a:motion]))
endfunction
" }}}

function! snipe#core#DoReplace(motion) " {{{
  function! DoReplace(...)
    let did_jump = snipe#core#DoCharMotion(a:1, '')
    if !did_jump
      return
    endif
    let ord = s:GetInput('Replace with: ')
    if ord == s:esc_ord | return | endif
    silent execute 'normal! r' . nr2char(ord)
  endfunction
  call DoAndGoBack(function('DoReplace', [a:motion]))
endfunction
" }}}

function! snipe#core#DoInsert(motion) " {{{
  function! DoInsert(...)
    let did_jump = snipe#core#DoCharMotion(a:1, '')
    if !did_jump
      return
    endif
    let ord = s:GetInput('Insert character: ')
    if ord == s:esc_ord | return | endif
    silent execute 'normal! i' . nr2char(ord) . "\<esc>"
  endfunction
  call DoAndGoBack(function('DoInsert', [a:motion]))
endfunction
" }}}

function! snipe#core#DoAppend(motion) " {{{
  function! DoAppend(...)
    let did_jump = snipe#core#DoCharMotion(a:1, '')
    if !did_jump
      return
    endif
    let ord = s:GetInput('Append character: ')
    if ord == s:esc_ord | return | endif
    silent execute 'normal! a' . nr2char(ord) . "\<esc>"
  endfunction
  call DoAndGoBack(function('DoAppend', [a:motion]))
endfunction
" }}}

" vim: fdm=marker

