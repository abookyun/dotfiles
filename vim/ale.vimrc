" ============================================================================
" ALE (Asynchronous Lint Engine) Configuration
" ============================================================================

" ----------------------------------------------------------------------------
" Global ALE Settings
" ----------------------------------------------------------------------------

" Enable ALE LSP support
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

" Set ALE to use the omni completion source
set omnifunc=ale#completion#OmniFunc

" Show hover information in preview window
let g:ale_hover_to_preview = 1
let g:ale_detail_to_floating_preview = 1

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

" Keep the sign column always visible
set signcolumn=yes

" ----------------------------------------------------------------------------
" Python-specific Configuration
" ----------------------------------------------------------------------------

" Configure linters for Python
let g:ale_linters = {
\   'python': ['pylsp', 'mypy'],
\}

" Configure fixers for Python
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\}

" Python LSP Server (pylsp) configuration
let g:ale_python_pylsp_config = {
\   'pylsp': {
\     'plugins': {
\       'pycodestyle': {
\         'enabled': v:true,
\         'maxLineLength': 88
\       },
\       'pyflakes': {
\         'enabled': v:true
\       },
\       'pylint': {
\         'enabled': v:false
\       },
\       'rope_completion': {
\         'enabled': v:true,
\         'eager': v:false
\       },
\       'jedi_completion': {
\         'enabled': v:true,
\         'include_params': v:true,
\         'include_class_objects': v:true,
\         'fuzzy': v:true
\       },
\       'jedi_hover': {
\         'enabled': v:true
\       },
\       'jedi_references': {
\         'enabled': v:true
\       },
\       'jedi_signature_help': {
\         'enabled': v:true
\       },
\       'jedi_symbols': {
\         'enabled': v:true,
\         'all_scopes': v:true
\       },
\       'black': {
\         'enabled': v:true
\       },
\       'mypy': {
\         'enabled': v:true,
\         'live_mode': v:false
\       }
\     }
\   }
\}

" Use Python 3 explicitly
let g:ale_python_pylsp_executable = 'pylsp'
let g:ale_python_pylsp_use_global = 1

" ----------------------------------------------------------------------------
" Key Mappings
" ----------------------------------------------------------------------------

" Code Navigation
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gD <Plug>(ale_go_to_type_definition)
nmap <silent> gr <Plug>(ale_find_references)
nmap <silent> gi <Plug>(ale_go_to_implementation)

" Hover and Documentation
nmap <silent> K <Plug>(ale_hover)
nmap <silent> <leader>d <Plug>(ale_detail)

" Code Actions and Refactoring
nmap <silent> <leader>rn <Plug>(ale_rename)
nmap <silent> <leader>ca <Plug>(ale_code_action)

" Formatting
nmap <silent> <leader>f <Plug>(ale_fix)
" Toggle auto-fix on save
nmap <silent> <leader>F :ALEToggleFixer<CR>

" Navigation between diagnostics
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> [E <Plug>(ale_first)
nmap <silent> ]E <Plug>(ale_last)

" Show all diagnostics
nmap <silent> <leader>al <Plug>(ale_lint)
nmap <silent> <leader>ad :ALEDetail<CR>
nmap <silent> <leader>ai :ALEInfo<CR>

" Symbol search
nmap <silent> <leader>s :ALESymbolSearch<Space>

" ----------------------------------------------------------------------------
" Integration with Supertab
" ----------------------------------------------------------------------------

" Make Supertab use ALE's omni completion for Python files
augroup SupertabALE
  autocmd!
  autocmd FileType python let b:SuperTabDefaultCompletionType = '<c-x><c-o>'
augroup END

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
