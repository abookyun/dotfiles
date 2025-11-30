" User Interface
set termguicolors
colorscheme dracula

" indentline
let g:vim_json_conceal = 0
let g:markdown_syntax_conceal = 0
let g:indentLine_setColors = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

let g:gitgutter_enabled = 1

let g:airline#extensions#disable_rtp_load = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1

" vim-devicons
set guifont=:h
set guifont=DroidSansMono_Nerd_Font:h11
let g:airline_powerline_fonts = 1

" goyo + limelight = zen mode
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Project Navigation
let g:NERDTreeBookmarksFile = $MY_VIM_STATE_DIR.'/NERDTreeBookmarks'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Git, Search, Replace and Utils

" Syntax, Linter and Autocompletion
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell spelllang=en_us,cjk

" vim-ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
