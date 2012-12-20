" vimrc
" David Selders
"

" Basics 
call pathogen#infect()
call pathogen#helptags()
set nocompatible

" Editing 
set showmode
set nowrap
set ts=4 sts=4 sw=4 noexpandtab
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set showmatch
set ignorecase
set smartcase
set scrolloff=4
set hlsearch
set incsearch
set fileformats="unix,mac,dos"
set fo=tcq

" Fix Vim's broken regex handling
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
nnoremap / /\v
vnoremap / /\v

" Folding 
set foldenable
set foldcolumn=3
set foldlevelstart=0
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Editor Layout 
set termencoding=utf-8
set encoding=utf-8
set laststatus=2
set cmdheight=2
set statusline=
set statusline +=%1*\ %n\ %*
set statusline +=%2*%{&fo}\ %*
set statusline +=%5*%{&ff}%*
set statusline +=%3*%y%*
set statusline +=%4*\ %<%F%*
set statusline +=%2*%m%*
set statusline +=%1*%=%5l%*
set statusline +=%2*/%L%*
set statusline +=%1*%4c\ %*

" ViM Behavior 
set ruler
set hidden
set history=1000
set undolevels=1000
if v:version >=730
	set undofile
	if has("gui_win32")
		set directory=~/vimfiles/tmp,c:/temp,c:/tmp
	else
		set undodir=~/.vim/.tmp,~/tmp,/tmp
	endif
endif
set nobackup
set noswapfile
	if has("gui_win32")
		set directory=~/vimfiles/tmp,c:/temp,c:/tmp
	else
		set directory=~/.vim/.tmp,~/tmp,/tmp
	endif
set wildmenu
set wildignore=*.swp,*.bak,*.pyc
set title
set vb t_vb= 
set showcmd
set nomodeline
set cursorline
set gdefault
set listchars=tab:▸\ ,eol:¬
let mapleader = ","
let g:mapleader = ","
nnoremap <tab> %
vnoremap <tab> %
nnoremap <leader><space> :noh<cr>
if has("gui_macvim")
	nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
endif
nmap <leader>l :set list!<CR>
nmap <leader>v :edit $MYVIMRC<CR>
if has("autocmd") 
	if has("gui_win32")
		autocmd! bufwritepost _vimrc source $MYVIMRC
	else
		autocmd! bufwritepost .vimrc source $MYVIMRC 
	endif
endif
filetype plugin on

" Highlighting 
set t_Co=256
colorscheme solarized
set bg=dark
syntax on
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59 

" GUI settings 
if has("gui_running")
    " Remove toolbar, left scrollbar and right scrollbar
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    if has("gui_macvim")
        set guifont=Monaco:h10
        colorscheme solarized
        set bg=dark
		set lines=48 columns=132
    endif

	if has("gui_win32")
		set guifont=Consolas:h10:cANSI
		set bg=light
		colorscheme solarized
		set lines=48 columns=132
	endif
    if has ("gui_gtk2")
        colorscheme blackboard
		set lines=48 columns=132
    endif
endif

" Keyboard Mappings 
"cabbrev help tab help
nmap <silent> <leader>] :NERDTreeToggle<CR>
nmap <silent> <leader>[ :TMiniBufExplorer<CR>

" MiniBufExpl 
let g:miniBufExplSplitBelow=0
let g:miniBufExpleMinSize=1
let g:miniBufExplMaxSize=4
let g:miniBufExplMapCTabSwitchBufs=1

" Tabular 
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Tmux & Clipboard 
set clipboard=unnamed
