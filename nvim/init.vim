""""""""""""""""""""""""""""""""""""
""         Vim Config V2.1        ""
"" PROJECT: Quarter of Refinement ""
""             @jemoka            ""
""""""""""""""""""""""""""""""""""""
"" Deprecated?

""-=-=-=-=-=Plugin Setup=-=-=-=-=-"" 
syntax on
set nocompatible
filetype plugin on
filetype indent on
"----------------------------------"

""-=-=-=-=-=-=Plugins-=-=-=-=-=-=-"" 
call plug#begin('~/.vim/plugged')

"#AUTOCOMPLETE#"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"#NAVIGATION PLUGINS#"
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

"#DA THEME#"
Plug 'niklas-8/vim-darkspace'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntk148v/vim-horizon'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'

"#DEVELOPER TOOLS#"
Plug 'cespare/vim-toml'
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
Plug 'radenling/vim-dispatch-neovim'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-repeat'
Plug 'honza/vim-snippets'
"Plug 'vimwiki/vimwiki'
Plug 'm-pilia/vim-mediawiki'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'floobits/floobits-neovim'
"Plug 'sillybun/vim-repl'
Plug 'michal-h21/vim-zettel'
"Plug 'ivanov/vim-ipython'
"Plug 'jpalardy/vim-slime'
"Plug 'bfredl/nvim-ipy'
Plug 'kovisoft/slimv'
Plug 'urbainvaes/vim-ripple'
Plug 'vimlab/split-term.vim'
Plug 'goerz/jupytext.vim'
Plug 'BurntSushi/ripgrep'
Plug 'ihsanturk/neuron.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'dkarter/bullets.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/taglist.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'leafgarland/typescript-vim'
Plug 'robertbasic/vim-hugo-helper'
Plug 'KeitaNakamura/tex-conceal.vim'

"#NEW lANGUAGES#"
Plug 'Olical/conjure', {'tag': 'v4.22.1'}
Plug 'lervag/vimtex'
Plug 'ianks/vim-tsx'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'peterhoeg/vim-qml'
"Plug 'szymonmaszke/vimpyter'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

"#NICETIES#"
Plug 'mtth/scratch.vim'
Plug 'junegunn/goyo.vim'
Plug 'mattn/calendar-vim'
Plug 'junegunn/limelight.vim'

call plug#end()
"-----------------------------------"

""-=-=-=Plugin Configurations=-=-=-"" 
"#THEME: ayu.vim"

"let ayucolor="dark"
"colorscheme horizon
"let g:darkspace_italics=1
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if (has("termguicolors"))
  set termguicolors
endif

let ayucolor="mirage" " for mirage version of theme
colorscheme ayu
let g:airline_theme='ayu_mirage'

"#AIRLINE#"
set ttimeoutlen=50

"#NERDTREE#"
let g:NERDTreeHighlightFolders = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

"#INCSEARCH#"
"basic (exact) search -- default
map / <Plug>(incsearch-easymotion-/)
map ? <Plug>(incsearch-easymotion-?)
map g/ <Plug>(incsearch-easymotion-stay)
"hlsearch and highlighting
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
"fuzzy match and easymotion
"a.k.a. pro search -- non-default
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
noremap <silent><expr> <Space>?  incsearch#go(<SID>config_easyfuzzymotion({'command': '?'}))
noremap <silent><expr> <Space>g/ incsearch#go(<SID>config_easyfuzzymotion({'is_stay': 1}))

"#AUTOCOMPLETE#"
" Disable for md, tex, and vim
"autocmd BufNew,BufEnter *.md execute 
""silent! CocDisable"

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "jk"
let g:UltiSnipsJumpForwardTrigger = "jk"
let g:UltiSnipsJumpBackwardTrigger = "kj"
" change the updatetime to prevent lag
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" use <TAB> to trigger completion, and C-n to trigger next
" similarly, use <S-TAB> to trigger completeion backwards, and C-p etc...
"call coc#config('python', {'pythonPath': "/usr/local/bin/python3.9"})
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB>
      \ pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<S-TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"inoremap <expr><S-TAB> pumvisible() ? 
" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" GoTo code definition
nmap <silent> rd <Plug>(coc-definition)
nmap <silent> ry <Plug>(coc-type-definition)
nmap <silent> ri <Plug>(coc-implementation)
nmap <silent> rr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Use <C-l> for trigger snippet expand.
imap jk <Plug>(coc-snippets-expand)
imap kj <Plug>(coc-snippets-expand)
let g:coc_snippet_next = 'jk'
let g:coc_snippet_prev = 'kj'

"#VIMTEX#"
let g:tex_flavor='latex'
let g:vimtex_view_method = "skim"

"#TEXCONCEAL#"
set conceallevel=2
let g:tex_conceal='abdgm'

"#GOYO AND LIMELIGHT#"
noremap <Leader>g :Goyo<CR>
"makeing sure Goyo quits when needed, and engage limelight
function! s:goyo_enter()
  Limelight
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction
function! s:goyo_leave()
  Limelight!
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  hi clear Conceal 
  hi Conceal cterm=NONE ctermbg=NONE ctermfg=darkblue
endfunction
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

"#SCRATCH.VIM#"
"scratch opening settings
let g:scratch_autohide=1
nmap <c-i> :ScratchPreview<CR>
"set project-specific presistence file
let g:scratch_persistence_file = '.__scratch__'

"#VIMJUPYTER#"
autocmd Filetype ipynb nmap <silent><Leader>jc :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>js :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>jn :VimpyterStartNteract<CR>

"#Vim-Zettel#"
let g:vimwiki_markdown_link_ext = 1
let g:zettel_format = "KB%y%m%d%H%M%S"
let g:zettel_link_format="[[%link]]"
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always -t markdown"
nnoremap <leader>zn :ZettelNew<space>
nnoremap <leader>Z :ZettelOpen<ENTER>

"#vim-ripple#"
let g:ripple_repls = {
            \ "python": ["ipython", "\<c-u>\<esc>[200~", "\<esc>[201~", 1],
            \ "markdown": ["ipython", "\<c-u>\<esc>[200~", "\<esc>[201~", 1],
            \ "scheme": "guile",
            \ "sh": "bash"
            \ }

"#EasyFuzzyMotion#"
map <Leader> <Plug>(easymotion-prefix)

"#Jsdoc#"
nmap <silent> <leader>jd <Plug>(jsdoc)

"#Vim-R#"
let R_assign = 0

"#Hugo#"
noremap <Leader>hn :HugoHelperDateIsNow<CR>
noremap <Leader>hd :HugoHelperDraft<CR>
noremap <Leader>hu :HugoHelperUndraft<CR>

"#MediaWiki#"
let g:vim_mediawiki_site = 'wiki.sanity.gq'
"----------------------------------"

""-=-=-=-=Keyboard Shortcuts-=-=-="" 
map <Space> <Leader>
let g:mapleader=" "
inoremap jj <Esc>
noremap <C-j> <C-W>
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
tnoremap j<Esc> <C-\><C-n>
"----------------------------------"

""=-=-=-=Interface Settings=-=-=-="" 
set nu rnu
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors
set mouse=a
set textwidth=0 
set wrapmargin=0
set display+=lastline
set foldmethod=indent
set timeoutlen=1000 ttimeoutlen=0
hi clear Conceal 
hi Conceal cterm=NONE ctermbg=NONE ctermfg=darkblue
augroup PythonCustomization
   :autocmd FileType python syn match pythonStatement "\(\W\|^\)\@<=self\([\.,)]\)\@="
augroup END
"----------------------------------"

