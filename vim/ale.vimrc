" ============================================================================
" ALE (Asynchronous Lint Engine) Configuration
" ============================================================================

" ----------------------------------------------------------------------------
" Global ALE Settings
" ----------------------------------------------------------------------------

let g:ale_use_global_executables = 0

" Set ALE to use the omni completion source
set omnifunc=ale#completion#OmniFunc

" Enable ALE LSP support
let g:ale_disable_lsp = 0
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

" Show hover information in floating window (popup)
let g:ale_hover_cursor = 0  " Don't auto-show on cursor hover (too noisy)
let g:ale_floating_preview = 1  " Use floating windows for preview
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─'] " Pretty borders

" Keep the sign column always visible
set signcolumn=yes
" Configure signs for errors and warnings
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_sign_style_error = '✘'
let g:ale_sign_style_warning = '⚠'

" Configure message format
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Fix files on save
let g:ale_fix_on_save = 0  " Disabled by default, enable with <leader>F

" Lint only on save and when text changes in normal mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1

" ----------------------------------------------------------------------------
" Python-specific Configuration
" ----------------------------------------------------------------------------

" Configure linters
let g:ale_linters = {
\   'python': [],
\   'vim': ['vimls'],
\}

" Configure fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': [],
\}

" ----------------------------------------------------------------------------
" Key Mappings
" ----------------------------------------------------------------------------

nnoremap <leader>I :ALEInfo<CR>

" Code Navigation
nnoremap gd <Plug>(ale_go_to_definition)
nnoremap gD <Plug>(ale_go_to_type_definition)
nnoremap gr <Plug>(ale_find_references)
nnoremap gi <Plug>(ale_go_to_implementation)

" Hover and Documentation
nnoremap <leader>h <Plug>(ale_hover)
nnoremap <leader>k <Plug>(ale_detail)

" Code Actions and Refactoring
nnoremap <leader>R <Plug>(ale_rename)
nnoremap <leader>A <Plug>(ale_code_action)

" Formatting
nnoremap <leader>F <Plug>(ale_fix)

" Navigation between diagnostics
nnoremap [e <Plug>(ale_previous_wrap)
nnoremap ]e <Plug>(ale_next_wrap)
nnoremap [E <Plug>(ale_first)
nnoremap ]E <Plug>(ale_last)

" Show all diagnostics
nnoremap <leader>L <Plug>(ale_lint)

" Symbol search
" nnoremap <leader>s :ALESymbolSearch<Space>

" ----------------------------------------------------------------------------
" Integration with Supertab
" ----------------------------------------------------------------------------

let g:SuperTabDefaultCompletionType = "context"
" Fallback to omni completion when context detection fails
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" ----------------------------------------------------------------------------
" Visual Customization
" ----------------------------------------------------------------------------

" Highlight groups for ALE signs
highlight ALEErrorSign ctermfg=red ctermbg=NONE guifg=#FF5555 guibg=NONE
highlight ALEWarningSign ctermfg=yellow ctermbg=NONE guifg=#FFB86C guibg=NONE
highlight ALEInfoSign ctermfg=blue ctermbg=NONE guifg=#8BE9FD guibg=NONE

" Highlight for error and warning lines
highlight ALEError cterm=underline gui=underline guisp=#FF5555
highlight ALEWarning cterm=underline gui=underline guisp=#FFB86C

" ----------------------------------------------------------------------------
" Helper Functions
" ----------------------------------------------------------------------------

" Toggle ALE fixers on save
function! ALEToggleFixer()
  let g:ale_fix_on_save = !g:ale_fix_on_save
  if g:ale_fix_on_save
    echo "ALE: Auto-fix on save enabled"
  else
    echo "ALE: Auto-fix on save disabled"
  endif
endfunction
command! ALEToggleFixer call ALEToggleFixer()

" ----------------------------------------------------------------------------
" Status Line Integration
" ----------------------------------------------------------------------------

" Show ALE status in airline (if installed)
let g:airline#extensions#ale#enabled = 1

" Custom status line function for ALE
function! ALEStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_warnings = l:counts.warning + l:counts.style_warning

  if l:all_errors == 0 && l:all_warnings == 0
    return 'OK'
  endif

  let l:error_str = l:all_errors > 0 ? printf('E:%d', l:all_errors) : ''
  let l:warning_str = l:all_warnings > 0 ? printf('W:%d', l:all_warnings) : ''

  return join(filter([l:error_str, l:warning_str], 'v:val != ""'), ' ')
endfunction
