set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'mattn/webapi-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'neomake/neomake'
Plug 'dougireton/vim-chef', { 'for': 'ruby.chef' }
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'autozimu/LanguageClient-neovim' , { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-rct-complete'
Plug 'Shougo/echodoc.vim'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'jonathanfilip/vim-lucius'
Plug 'editorconfig/editorconfig-vim'
Plug 'rizzatti/dash.vim'
Plug 'mattn/gist-vim'
Plug 'fatih/vim-go'
Plug 'LnL7/vim-nix'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

call plug#end()
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

set number
set ruler
set laststatus=2

set nowrap
set ts=2
set sw=2
set shiftround
set expandtab
set softtabstop=2

set incsearch
set ignorecase
set smartcase
set title
set nohlsearch

set hidden
nnoremap ' `
nnoremap ` '
let mapleader=','
let maplocalleader=','
set history=1000
set clipboard=unnamed

set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

if has('mac')
	let g:gist_clip_command = 'pbcopy'
elseif
	let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype=1
let g:gist_open_browser_after_post=1

" from https://raw.githubusercontent.com/jonathanfilip/lucius/master/vim-airline/lucius.vim
let g:airline#themes#lucius#palette = {}

function! airline#themes#lucius#refresh()

    let s:N1 = airline#themes#get_highlight('StatusLine')
    let s:N2 = airline#themes#get_highlight('Folded')
    let s:N3 = airline#themes#get_highlight('CursorLine')
    let g:airline#themes#lucius#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

    let modified_group = airline#themes#get_highlight('Statement')
    let g:airline#themes#lucius#palette.normal_modified = {
                \ 'airline_c': [modified_group[0], '', modified_group[2], '', '']
                \ }

    let warning_group = airline#themes#get_highlight('DiffDelete')
    let g:airline#themes#lucius#palette.normal.airline_warning = warning_group
    let g:airline#themes#lucius#palette.normal_modified.airline_warning = warning_group

    let s:I1 = airline#themes#get_highlight('DiffAdd')
    let s:I2 = s:N2
    let s:I3 = s:N3
    let g:airline#themes#lucius#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
    let g:airline#themes#lucius#palette.insert_modified = g:airline#themes#lucius#palette.normal_modified
    let g:airline#themes#lucius#palette.insert.airline_warning = g:airline#themes#lucius#palette.normal.airline_warning
    let g:airline#themes#lucius#palette.insert_modified.airline_warning = g:airline#themes#lucius#palette.normal_modified.airline_warning

    let s:R1 = airline#themes#get_highlight('DiffChange')
    let s:R2 = s:N2
    let s:R3 = s:N3
    let g:airline#themes#lucius#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
    let g:airline#themes#lucius#palette.replace_modified = g:airline#themes#lucius#palette.normal_modified
    let g:airline#themes#lucius#palette.replace.airline_warning = g:airline#themes#lucius#palette.normal.airline_warning
    let g:airline#themes#lucius#palette.replace_modified.airline_warning = g:airline#themes#lucius#palette.normal_modified.airline_warning

    let s:V1 = airline#themes#get_highlight('Cursor')
    let s:V2 = s:N2
    let s:V3 = s:N3
    let g:airline#themes#lucius#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
    let g:airline#themes#lucius#palette.visual_modified = g:airline#themes#lucius#palette.normal_modified
    let g:airline#themes#lucius#palette.visual.airline_warning = g:airline#themes#lucius#palette.normal.airline_warning
    let g:airline#themes#lucius#palette.visual_modified.airline_warning = g:airline#themes#lucius#palette.normal_modified.airline_warning

    let s:IA = airline#themes#get_highlight('StatusLineNC')
    let g:airline#themes#lucius#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
    let g:airline#themes#lucius#palette.inactive_modified = {
                \ 'airline_c': [ modified_group[0], '', modified_group[2], '', '' ]
                \ }

    let g:airline#themes#lucius#palette.accents = {
                \ 'red': airline#themes#get_highlight('Constant'),
                \ }

endfunction

call airline#themes#lucius#refresh()
let g:airline_powerline_fonts=1
" let g:airline_solarized_bg='dark'
" let g:airline_theme='solarized'

" auto format rust code
let g:rustfmt_autosave = 1

set bg=dark
colorscheme lucius
LuciusDarkHighContrast

function s:setupWrap()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrap()
endfunction

let g:neomake_ruby_enabled_makers = [ 'mri', 'rubocop' ]
let g:neomake_ruby_rubocop_exe = 'chefstyle'

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.run} set ft=ruby
au BufRead,BufNewFile *.{markdown,md} call s:setupMarkup()
au BufRead,BufNewFile *.hjs set ft=handlebars
au BufRead,BufNewFile *.txt call s:setupWrap()
au FileType latex,tex,md,markdown setlocal spell
au BufRead,BufNewFile */.zsh/* set ft=zsh
au BufRead,BufNewFile */.zsh/**/* set ft=zsh
au BufRead,BufNewFile */my-dotfiles/zsh/**/* set ft=zsh

au BufRead,BufNewFile {Berksfile,metadata.rb,recipes/*.rb,resources/*.rb,libraries/*.rb,spec/unit/recipes/*.rb} set ft=ruby.chef
au FileType ruby.chef let b:neomake_ruby_rubocop_exe = 'cookstyle'

let g:go_fmt_command = "goimports"

call neomake#configure#automake('rw', 1000)
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1

set shortmess+=c
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

set backspace=indent,eol,start
filetype plugin indent on

map <leader>t :Files<CR>
map <leader>b :Buffers<CR>
map <leader>j :BTags<CR>
map <leader>J :Tags<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

map <silent> <leader>d <Plug>DashSearch
