filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'

Bundle 'kien/ctrlp.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'janko-m/vim-test'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on

syntax on

set showmode
set relativenumber
set ruler
set tabstop=2
set shiftwidth=2
set expandtab
set incsearch
set smartcase
set ignorecase
set hlsearch
set visualbell
set nobackup
set nowritebackup
set backspace=indent,eol,start
set noswapfile
set list
set encoding=utf-8
set listchars=tab:›\.,trail:.,extends:#,nbsp:.
set autoindent
set wildmenu
set autoread
set splitright
set splitbelow
set notimeout
set ttimeout
set ttimeoutlen=10

let mapleader=','
set background=dark
colorscheme gruvbox

imap jk <ESC>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" insert pry breakpoint
map <leader>p <CR>ibinding.pry<CR><ESC>

" remove all pry breakpoints
map <leader>rp :g/binding/d<CR><ESC>

" insert py breakpoint
map <leader>º <CR>iimport pdb; pdb.set_trace()<CR><ESC>

" remove all py breakpoints
map <leader>rº :g/set_trace/d<CR><ESC>

setlocal spell spelllang=en_us
hi SpellBad cterm=underline ctermfg=yellow

autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell

nnoremap <leader>w  :w<cr>
nnoremap <leader>q  :wq<cr>
nnoremap <leader>fq :q!<cr>

" Running tests
nnoremap <silent> <leader>T :TestNearest<CR>
nnoremap <silent> <leader>t :TestFile<CR>
nnoremap <silent> <leader>v :TestVisit<CR>

" Clear search highlights
nnoremap <leader><space> : :nohlsearch<cr>

" Edit and source vim config
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>

" Search and replace on current file
nnoremap <leader>ss :%s/\<<C-r><C-w>\>//g<Left><Left>

" Rails helpers
nnoremap <leader>sc :sp db/schema.rb<cr>
nnoremap <leader>co :vsp app/controllers<cr>
nnoremap <leader>ro :vsp config/routes.rb<cr>
nnoremap <leader>mo :vsp app/models<cr>

" Search all files
" by default it searches only on ruby files
nnoremap <leader>faf :!ag --ruby<space>

" Search all files word under the cursor
" by default it searches only on ruby files
nnoremap <leader>fw :!ag --ruby <C-r><C-w>

" Search for 'def foo'
nnoremap <silent> ,fd :!ag 'def <cword>'<CR>

" Open project explorer
nnoremap <leader>ef :Vexplore<CR>

" Open file on current dir
cnoremap <expr> %% expand('%:h').'/'
map <leader>ed :vsp %%

" format an entire file
nnoremap <leader>fef ggVG=

" Remove all whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Reload file and throw away any changes
nnoremap <leader>rel :edit!<cr>

map <leader>nt :tabnext<cr>

" Open current split as a new tab
map <leader>sp <C-W>T<cr>

" Sometimes I forgot my leader commands
map <leader>lea :!grep --color leader ~/dotfiles/vimrc <cr>

nnoremap <C-f> /
nnoremap <C-h> B
nnoremap <C-l> W

nnoremap Y y$
nnoremap ºº $
nnoremap qq  _

" long lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Do not show that stupid window
map q: :q
map ? *

let g:ctrlp_working_path_mode = '0'

autocmd Filetype java setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype py setlocal ts=4 sw=4 sts=0 expandtab
au BufRead,BufNewFile *.go set filetype=go

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
set wildignore+=*.DS_Store                        " OSX bullshit
set wildignore+=*.pyc                             " Python byte code
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " Images
set wildignore+=.hg,.git,.svn                     " Version control stuff
set wildignore+=go/pkg                            " Go static files
set wildignore+=go/bin                            " Go bin files

" Merge a tab into a split in the previous window (thanks Ben Orenstein)
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction

nmap <leader>mm :call MergeTabs()<CR>

" Rename current file (thanks Gary Bernhardt)
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map <leader>ren :call RenameFile()<cr>

" Open changed files (thanks Gary Bernhardt)
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "vsp " . filename
  endfor
endfunction
nmap <leader>cf :call OpenChangedFiles()<CR>

"git commands
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif
