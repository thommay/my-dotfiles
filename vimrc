set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'tpope/vim-unimpaired'
" This stomps all over the return mapping that ncm2_ultisnips uses
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rake'
Plug 'w0rp/ale'
Plug 'uber/prototool', { 'rtp':'vim/prototool' }
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'mattn/webapi-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'neomake/neomake'
Plug 'dougireton/vim-chef', { 'for': 'ruby.chef' }
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'autozimu/LanguageClient-neovim' , { 'branch': 'next', 'do': ':bash install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'roxma/ncm-rct-complete'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
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
Plug 'Helcaraxan/schemalang-vim'
Plug 'tpope/vim-speeddating'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/utl.vim'
Plug 'jceb/vim-orgmode'

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

let g:deoplete#enable_at_startup = 1

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" auto format rust code
let g:rustfmt_autosave = 1

set bg=dark
colorscheme solarized

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
au FileType markdown,md let vim_markdown_preview_toggle=2
au BufRead,BufNewFile */.zsh/* set ft=zsh
au BufRead,BufNewFile */.zsh/**/* set ft=zsh
au BufRead,BufNewFile */my-dotfiles/zsh/**/* set ft=zsh
au BufRead,BufNewFile {BUILD,BUILD.bazel} set ft=bzl

au BufRead,BufNewFile {Berksfile,metadata.rb,recipes/*.rb,resources/*.rb,libraries/*.rb,spec/unit/recipes/*.rb} set ft=ruby.chef
au FileType ruby.chef let b:neomake_ruby_rubocop_exe = 'cookstyle'

let g:go_fmt_command = "goimports"

call neomake#configure#automake('rw', 1000)
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
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

map <leader>t :GFiles<CR>
map <leader>b :Buffers<CR>
map <leader>j :BTags<CR>
map <leader>J :Tags<CR>
map <leader>i :GoIfErr<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

map <silent> <leader>d <Plug>DashSearch

" lightline/airline handles the mode display
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'spell', 'paste'], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ], [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ] ],
  \ },
  \ 'component_expand': {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head',
  \   'spell': 'LightlineShowSpell',
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \}

function! LightlineShowSpell()
  let spellang = printf(" [%s]", toupper(substitute(&spelllang, ',', '/', 'g')))
  if &spell
    if winwidth(0) >= 90
      return "SPELL" . spellang
    else
      return "SPELL"
    endif
  endif
  return ''
endfunction

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<tab>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-b>"
let g:UltiSnipsRemoveSelectModeMappings = 0

let g:ale_linters = {
\   'proto': ['prototool'],
\}

au FileType proto let b:ale_lint_on_text_changed = 'never'

let g:org_agenda_files = ['~/org/*.org']
