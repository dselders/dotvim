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
set stl=[B%n]\ %f%m\ [%{&ff}]\ [%{&fo}]\ %y\ %=%5l/%L\ %4c
"set statusline +=%1*\ %n\ %*
"set statusline +=%2*%{&fo}\ %*
"set statusline +=%5*%{&ff}%*
"set statusline +=%3*%y%*
"set statusline +=%4*\ %<%F%*
"set statusline +=%2*%m%*
"set statusline +=%1*%=%5l%*
"set statusline +=%2*/%L%*
"set statusline +=%1*%4c\ %*

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
set ttyfast
set gdefault
set listchars=tab:▸\ ,trail:·,eol:¬
let mapleader=","
filetype plugin on

" Highlighting
set t_Co=256
colorscheme solarized
set bg=light
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
        set guifont=Inconsolata\ for\ Powerline:h13
        colorscheme solarized
        set bg=light
		set lines=48 columns=132
		set transparency=1
    endif

	if has("gui_win32")
		set guifont=Consolas:h10:cANSI
		set bg=dark
		colorscheme solarized
		set lines=48 columns=87
	endif
    if has ("gui_gtk2")
        set guifont=Inconsolata\ 12
        colorscheme solarized
		set lines=48 columns=87
    endif
endif

" Keyboard Mappings
nnoremap <tab> %
vnoremap <tab> %
nnoremap <leader>ww :set invwrap<cr>:set wrap?<cr>
nnoremap <leader>p :set invpaste<cr>:set paste?<cr>
nnoremap <leader>cd :lcd %:h<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>q gqip
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j
nnoremap <leader>s :Scratch<cr>
noremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>li :set list!<CR>
nnoremap <leader>ev :e ~/.vim/vimrc<cr>
noremap <leader><tab> :bnext<cr>
if has("autocmd")
	if has("gui_win32")
		autocmd! bufwritepost _vimrc source $MYVIMRC
	else
		autocmd! bufwritepost .vimrc source $MYVIMRC
	endif
endif
if has("gui_macvim")
	nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
endif

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

" Filetypes
if has ("autocmd")
	augroup FileTypeDetect
		autocmd!
		autocmd BufNew,BufNewFile,BufRead *.txt,*.md,*.mmd :setfiletype markdown
		autocmd BufNew,BufNewFile,BufRead *.j2 :setfiletype jinja
	augroup END
	augroup FTOptions
		autocmd!
		autocmd FileType markdown setlocal wrap
		autocmd FileType markdown setlocal linebreak
		autocmd FileType markdown setlocal showbreak=…
		autocmd FileType markdown setlocal formatoptions=qrn1
		autocmd FileType markdown setlocal colorcolumn=80
		autocmd FileType markdown setlocal spell
		autocmd FileType jinja setlocal ts=2 sts=2 sw=2
		autocmd FileType yaml setlocal ts=2 sts=2 sw=2
	augroup END
end

" Syntastic
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }
let g:syntastic_python_checkers = ['pyflakes']

" Airline
noremap <leader>ar :AirlineRefresh<cr>

if !exists("g:airline_symbols")
	let g:airline_symbols = {}
endif

let g:airline_powerline_fonts=1
let g:airline_theme="solarized"
let g:airline#extensions#branch#empty_message  =  "No SCM"
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=1

" Bufferline
let g:bufferline_echo=0

" Fugitive
noremap <leader>gs :Gstatus<cr>
noremap <leader>gd :Gdiff<cr>
noremap <leader>gp :Gpush<cr>

" Gitgutter
let g:gitgutter_highlight_lines=1

" Line numbers
function! NumberToggle()
	if(&relativenumber == 1)
		set nornu
		set number
	else
		set relativenumber
	endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
