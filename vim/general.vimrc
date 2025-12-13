" General Settings
" use sensible.vim basic settings: https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

" State files (swap, backup, undo, viminfo)
let s:vim_state = $XDG_STATE_HOME.'/vim'
let &directory = s:vim_state.',~/,/tmp'
let &backupdir = s:vim_state.',~/,/tmp'
let &undodir   = s:vim_state
set undofile
let &viminfofile = s:vim_state.'/viminfo'

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
set foldlevel=2
set hlsearch incsearch
set completeopt=menu,menuone,popup,noselect


" Enable bracketed paste mode to fix auto-indent issues when pasting in INSERT mode
" - t_BE/t_BD: control bracketed paste on/off
" - t_PS/t_PE: mark paste start/end
" When enabled, Vim detects paste operations and temporarily disables auto-indent
" https://vi.stackexchange.com/questions/23110/pasting-text-on-vim-inside-tmux-breaks-indentation
if &term =~ "screen" || &term =~ "tmux"
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
noremap  <leader>r :source $MYVIMRC<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>} :TagbarToggle<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>1 :bfirst<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>
nnoremap <leader>9 :blast<CR>
nnoremap <leader>x :bdelete<CR>
nnoremap <leader>u :UndotreeToggle<CR>
" noremap <leader>a :Ag<space>
nnoremap <CR> za
vnoremap <CR> zf

" System Clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4
