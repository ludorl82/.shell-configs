" General settings
set number
set bs=2
set tabstop=2 shiftwidth=2 expandtab
set smartindent
set history=2000
set mouse=a
set encoding=UTF-8
set timeout ttimeoutlen=50 " Set faster escape with ctrl left bracket
set completeopt-=preview " For No Previews

" Popup window settings
let g:popup_window_id = -1
let g:popup_buf_id = -1

" Cursor shape settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" Colorscheme
colorscheme jellybeans

" Coc settings
let g:coc_disable_startup_warning = 1 " Disable coc warning
let g:copilot_filetypes = {'*': v:true} " Enable copilot for markdown

" Airline settings
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols = get(g:, 'airline_symbols', {})
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Language server settings
let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start'],
    \ 'bash': ['bash-language-server', 'start']
    \ }

" Key mappings
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Copilot mappings
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-E> copilot#AcceptLine("\<CR>")
imap <silent><script><expr> <C-F> copilot#AcceptWord("\<CR>")
imap <silent><script><expr> <Tab> copilot#Next()
imap <silent><script><expr> <S-Tab> copilot#Previous()
imap <silent><script><expr> <C-K> copilot#Dismiss()

" Function definitions
function! SuggestOneCharacter()
    let suggestion = copilot#Accept("")
    let bar = copilot#TextQueuedForInsertion()
    return bar[0]
endfunction

function! TogglePopupWindow(shouldDisplay) " Bind C-n to toggle a popup window with CopilotChat prompt
    let l:shouldDisplay = a:shouldDisplay
    if l:shouldDisplay == 2
        if g:popup_window_id == -1 || !nvim_win_is_valid(g:popup_window_id)
            let l:shouldDisplay = 1
        else
            let l:shouldDisplay = 0
        endif
    endif
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.8)
    let row = (&lines - height) / 2
    let col = (&columns - width) / 2
    let opts = {'relative': 'editor', 'width': width, 'height': height, 'row': row, 'col': col}
    if l:shouldDisplay
        if g:popup_window_id == -1 || !nvim_win_is_valid(g:popup_window_id)
            if g:popup_buf_id == -1 || !nvim_buf_is_valid(g:popup_buf_id)
                let g:popup_buf_id = nvim_create_buf(v:false, v:true)
            endif
            let g:popup_window_id = nvim_open_win(g:popup_buf_id, v:true, opts)
        endif
    else
        if g:popup_window_id != -1 && nvim_win_is_valid(g:popup_window_id)
            call nvim_win_hide(g:popup_window_id)
        endif
    endif
endfunction

function! YankToClip(regname)
    call writefile(getreg(a:regname,1,1),'/home/ludorl82/tmp/vim-yank')
    call system('/home/ludorl82/.shell-scripts/scripts/pbcopy.sh < /home/ludorl82/tmp/vim-yank')
endfunction

" More key mappings
imap <silent><script><expr> <Right> SuggestOneCharacter()
nnoremap <C-w>n :new<CR><C-w><C-r>:resize 8<CR>:CopilotChat<Space>
nnoremap <C-w>N :tnew<CR><CR>:CopilotChat<Space>
nnoremap <silent> <C-n> :call TogglePopupWindow(2)<CR>
xnoremap Y "zy :call YankToClip('z')<CR>h

" FZF settings
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = {  'window':  {  'width': 0.9, 'height': 0.6  }  }

" CopilotChat prompts
let g:copilot_prompts = {
  \ 'Explain': 'Please explain how the following code works.',
  \ 'Review': 'Please review the following code and provide suggestions for improvement.',
  \ 'Tests': 'Please explain how the selected code works, then generate unit tests for it.',
  \ 'Refactor': 'Please refactor the following code to improve its clarity and readability.',
  \ 'Summarize': 'Please summarize the following text.',
  \ 'Spelling': 'Please correct any grammar and spelling errors in the following text.',
  \ 'Wording': 'Please improve the grammar and wording of the following text.',
  \ 'Concise': 'Please rewrite the following text to make it more concise.'
\ }

" CopilotChat key mappings
nnoremap <C-w>cce :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Explain'] . ': ' . getreg('0')<CR>
nnoremap <C-w>cct :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Tests'] . ': ' . getreg('0')<CR>
nnoremap <C-w>ccr :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Review'] . ': ' . getreg('0')<CR>
nnoremap <C-w>ccR :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Refactor'] . ': ' . getreg('0')<CR>
nnoremap <C-w>ccs :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Summarize'] . ': ' . getreg('0')<CR>
nnoremap <C-w>ccS :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Spelling'] . ': ' . getreg('0')<CR>
nnoremap <C-w>ccw :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Wording'] . ': ' . getreg('0')<CR>
nnoremap <C-w>ccc :call TogglePopupWindow(1)<CR>:execute 'CopilotChat' g:copilot_prompts['Concise'] . ': ' . getreg('0')<CR>
