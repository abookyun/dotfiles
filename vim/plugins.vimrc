" === UI & Appearance ===

" dracula
set termguicolors
colorscheme dracula

" vim-devicons
set guifont=DroidSansMono_Nerd_Font:h11

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#disable_rtp_load = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1

" indentline
let g:indentLine_setColors = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" gitgutter
let g:gitgutter_enabled = 1

" easymotion
nnoremap <leader><leader>s <Plug>(easymotion-s2)
map / <Plug>(incsearch-easymotion-/)
map ? <Plug>(incsearch-easymotion-?)
map g/ <Plug>(incsearch-easymotion-stay)

" goyo + limelight (zen mode)
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" === Navigation & File Finding ===

" nerdtree
let g:NERDTreeBookmarksFile = $XDG_STATE_HOME.'/vim/NERDTreeBookmarks'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" === Syntax, Linting & Completion ===

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell spelllang=en_us,cjk

" vim-json
let g:vim_json_conceal = 0
let g:markdown_syntax_conceal = 0

" vim-ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
