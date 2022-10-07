:set number
:set bs=2
:set tabstop=2 shiftwidth=2 expandtab
:set smartindent
:set history=2000
:set mouse=a
:let &t_SI.="\e[5 q" "SI = INSERT mode
:let &t_SR.="\e[4 q" "SR = REPLACE mode
:let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" Set faster escape with ctrl left bracket
set timeout ttimeoutlen=50

set encoding=UTF-8

:set completeopt-=preview " For No Previews

:colorscheme jellybeans

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start'],
    \ 'bash': ['bash-language-server', 'start']
    \ }

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
map <F5> :NERDTreeToggle<CR>

let b:coc_suggest_disable = 1

let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = {  'window':  {  'width': 0.9, 'height': 0.6  }  }

function YankToClip(regname)
    call writefile(getreg(a:regname,1,1),'/home/ludorl82/tmp/vim-yank')
    call system('/home/ludorl82/.shell-scripts/scripts/pbcopy.sh < /home/ludorl82/tmp/vim-yank')
endfunction
xnoremap Y "zy :call YankToClip('z')<CR>h

:cnoremap <C-N> <Down>
:cnoremap <C-P> <Up>
