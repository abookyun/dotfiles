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

" === Foundation ===
Plug 'tpope/vim-sensible'

" === UI & Appearance ===
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

" === Navigation & File Finding ===
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" === Git Integration ===
Plug 'tpope/vim-fugitive'

" === Text Editing & Movement ===
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" === Tools & Utilities ===
Plug 'rking/ag.vim'
Plug 'preservim/tagbar'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-dispatch'
Plug 'mbbill/undotree'

" === Syntax, Linting & Completion ===
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'elzr/vim-json'
Plug 'preservim/vim-markdown'

call plug#end()
