""""""""""""""""""""""""""""""""""""
""         Vim Config V2.1        ""
"" PROJECT: Quarter of Refinement ""
""             @jemoka            ""
""""""""""""""""""""""""""""""""""""

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

"#DEVELOPER TOOLS#"
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-repeat'
Plug 'honza/vim-snippets'
Plug '/usr/local/opt/fzf'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'dkarter/bullets.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'tpope/vim-speeddating'
"Plug 'vim-scripts/taglist.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'KeitaNakamura/tex-conceal.vim'

"#NEW lANGUAGES#"
Plug 'lervag/vimtex'
Plug 'ianks/vim-tsx'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
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

set termguicolors
let ayucolor="dark"
colorscheme ayu
"let g:darkspace_italics=1
let g:airline_theme='ayu_dark'

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
let g:vimtex_view_method = "mupdf"

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

"#Auto-Fcitx#"
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

"set ttimeoutlen=150
""Exit insert mode
"autocmd InsertLeave * call Fcitx2en()
""Enter insert mode
"autocmd InsertEnter * call Fcitx2zh()
"----------------------------------"

""-=-=-=-=Keyboard Shortcuts-=-=-="" 
inoremap jj <Esc>
noremap <C-j> <C-W>
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
tnoremap j<Esc> <C-\><C-n>
"----------------------------------"

""=-=-=-=Interface Settings=-=-=-="" 
set number
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors
set mouse=a
set textwidth=0 
set wrapmargin=0
set display+=lastline
set foldmethod=indent
hi clear Conceal 
hi Conceal cterm=NONE ctermbg=NONE ctermfg=darkblue
augroup PythonCustomization
   :autocmd FileType python syn match pythonStatement "\(\W\|^\)\@<=self\([\.,)]\)\@="
augroup END
"----------------------------------"

