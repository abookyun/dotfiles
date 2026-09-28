" herdr version of vim-tmux-navigator, for vim and nvim.
" ctrl+hjkl moves between splits. At the edge of the screen it moves herdr
" focus to the next pane. herdr/navigate.sh sends these keys here only when
" vim is the foreground process in the pane.
"
" nvim sources this file from lua/plugins/tmux-navigator.lua.

" Inside tmux, vim-tmux-navigator already does this
if exists('g:loaded_herdr_navigator') || empty($HERDR_PANE_ID) || !empty($TMUX)
  finish
endif
let g:loaded_herdr_navigator = 1

function! s:Navigate(wincmd, direction) abort
  let l:win = winnr()
  execute 'wincmd ' . a:wincmd
  if winnr() != l:win
    return
  endif
  let l:herdr = empty($HERDR_BIN_PATH) ? 'herdr' : $HERDR_BIN_PATH
  call system(shellescape(l:herdr) . ' pane focus --pane ' . shellescape($HERDR_PANE_ID)
        \ . ' --direction ' . a:direction)
endfunction

function! s:Map() abort
  nnoremap <silent> <C-h> :<C-u>call <SID>Navigate('h', 'left')<CR>
  nnoremap <silent> <C-j> :<C-u>call <SID>Navigate('j', 'down')<CR>
  nnoremap <silent> <C-k> :<C-u>call <SID>Navigate('k', 'up')<CR>
  nnoremap <silent> <C-l> :<C-u>call <SID>Navigate('l', 'right')<CR>
endfunction

" vim-tmux-navigator maps the same keys when it loads. Map again on VimEnter
" so these win, whatever order the plugins load in.
call s:Map()
augroup herdr_navigator
  autocmd!
  autocmd VimEnter * call s:Map()
augroup END
