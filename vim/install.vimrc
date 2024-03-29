" Install vim-plug if not found
if empty(glob('$MY_VIM_DATA_DIR/autoload/plug.vim'))
  silent !curl -fLo $MY_VIM_DATA_DIR/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'tpope/vim-sensible'

" User Interface
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mhinz/vim-startify'

" Project Navigation
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Git, Search, Replace and Utils
Plug 'christoomey/vim-tmux-navigator'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'preservim/tagbar'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-dispatch'
Plug 'mbbill/undotree'

" Syntax, Linter and Autocompletion
Plug 'ervandew/supertab'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'elzr/vim-json'
Plug 'preservim/vim-markdown'
Plug 'tpope/vim-endwise'

call plug#end()
