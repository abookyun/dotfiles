" General Settings
" use sensible.vim basic settings: https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

set directory=$MY_VIM_STATE_DIR,~/,/tmp
set backupdir=$MY_VIM_STATE_DIR,~/,/tmp
if !has('nvim')
  set viminfo+=n$MY_VIM_STATE_DIR/viminfo
endif

set encoding=utf-8
set nobackup noswapfile autowriteall hidden
set mouse=a
set number relativenumber
set cursorline cursorcolumn
set tabstop=2
set shiftwidth=2
set expandtab
" Enable folding
set foldmethod=indent

" https://vi.stackexchange.com/questions/23110/pasting-text-on-vim-inside-tmux-breaks-indentation
" fix pasting code in tmux breaks indentation
if &term =~ "screen"
  let &t_BE = "\e[?2004h"
  let &t_BD = "\e[?2004l"
  exec "set t_PS=\e[200~"
  exec "set t_PE=\e[201~"
endif

augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase ignorecase
    autocmd CmdLineLeave : set smartcase
augroup END

" Keyboard Shortcuts
let mapleader = ' '
noremap <silent> <leader>r :source ${XDG_CONFIG_HOME}/vim/vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>l :NERDTreeFind<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>} :TagbarToggle<CR>
nnoremap <leader>1 :bfirst<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>
nnoremap <leader>9 :blast<CR>
nnoremap <leader>x :bdelete<CR>
nnoremap <leader>u :UndotreeToggle<CR>

" noremap <leader>a :Ag<space>

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4
