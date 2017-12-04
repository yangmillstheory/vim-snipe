" highlighting; TODO: pull out of this file {{{
let s:hl1_group_colors = {
    \   'gui'     : ['NONE', '#fabd2f' , 'bold,underline']
    \ , 'cterm256': ['NONE', '7'       , 'bold']
    \ , 'cterm'   : ['NONE', '7'       , 'bold']
    \ }
let g:snipe_hl1_group = 'SmartMotionHL1'

function! s:InitializeHLGroup(hl_group_name, colors) " TODO: understand me! {{{
  let default_hl_group_name = a:hl_group_name . 'Default'
  let guihl = printf('guibg=%s guifg=%s gui=%s', a:colors.gui[0], a:colors.gui[1], a:colors.gui[2])
  let ctermhl = &t_Co == 256
      \ ? printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm256[0], a:colors.cterm256[1], a:colors.cterm256[2])
      \ : printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm[0], a:colors.cterm[1], a:colors.cterm[2])
  execute printf('hi default %s %s %s', default_hl_group_name, guihl, ctermhl)
  if hlexists(a:hl_group_name)
    redir => hlstatus | exec 'silent hi ' . a:hl_group_name | redir END
    if hlstatus !~ 'cleared'
      return
    endif
  endif
  execute printf('hi default link %s %s', a:hl_group_name, default_hl_group_name)
endfunction " }}}

function! snipe#highlight#InitializeHLGroups()
  " wrapper function that exists to provide further highlighting
  call <SID>InitializeHLGroup(g:snipe_hl1_group, s:hl1_group_colors)
endfunction
" }}}


