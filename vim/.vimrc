set nocompatible              " be iMproved, required
filetype off                  " required

" Plug Manager
call plug#begin('~/.vim/plugged')

" Completers/Syntax
Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py --clang-completer --system-libclang --gocode-completer' }
" ^ Optionally add --system-boost, currently repo version of boost is out of date.
" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'

" Functionality
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'aperezdc/vim-template'

" fzf
Plug 'junegunn/fzf.vim'

" Tmux
Plug 'edkolev/tmuxline.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Language specific
" Polyglot
Plug 'sheerun/vim-polyglot'

" C/C++
Plug 'jdevlieghere/llvm.vim'
Plug 'brookhong/cscope.vim'

" Golang (Replaced by polyglot)
" Plug 'fatih/vim-go'

" Haskell
Plug 'eagletmt/neco-ghc'
" Plug 'neovimhaskell/haskell-vim'

" LaTeX
" Plug 'lervag/vimtex'

" TS (Replaced by polyglot)
" Plug 'leafgarland/typescript-vim'

" Codefmt
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" Plug 'rhysd/vim-clang-format'

" Appearance
"Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'

" Colorschemes
" Plug 'tomasr/molokai'
Plug 'chriskempson/base16-vim'
Plug 'daviesjamie/vim-base16-lightline'

" All Plugins must be added before this line
call plug#end()              " required
filetype plugin indent on    " required
call glaive#Install()

" Main Settings

" Keyboard remaps
let mapleader = ','
let localmapleader = ','
inoremap jk <Esc>

" Note: this actually broke vim by causing it to start in replace mode. This
" serves as a reminder not to do that this in future :p
" noremap <Esc> <Nop>

" LaTeX
" 80 char cutoff
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>
let g:LatexBox_latexmk_async=1
let g:LatexBox_viewer='mupdf'
" This sometimes needs to be turned off if using minted.
" let g:LatexBox_custom_indent=0

" codefmt
augroup autoformat_settings
	autocmd FileType bzl,BUILD,WORKSPACE AutoFormatBuffer buildifier
	autocmd FileType go AutoFormatBuffer gofmt
	autocmd FileType c,cpp,proto,javascript,cc,typescipt,ts AutoFormatBuffer clang-format
	autocmd FileType python AutoFormatBuffer yapf
	autocmd FileType html,css,json AutoFormatBuffer js-beautify
augroup END

" Colorscheme
syntax enable
" colorscheme molokai
" let g:rehash256 = 1 	" 256 color terminal support
let g:base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-ashes

" Add fuzzy finder to runtime path
set runtimepath+=/usr/share/fzf/
nmap ; :Buffers<cr>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" Fast terminal
set ttyfast

" General
set number
set spell
" Set rulers off by 1 as otherwise the last char is on the rule. 101 is for
" MidSun. 81 is for everything else.
set colorcolumn=81,101

" GUI if using gvim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar

" CTags
set tags=tags;
let g:cscope_silent=1

" Functions
function! HighlightRepeats() range
    let l:lineCounts={}
    let l:lineNum=a:firstline
    while l:lineNum <= a:lastline
        let l:lineText=getline(l:lineNum)
        if l:lineText !=# '' " Use the case sensitive form for repeats.
            let l:lineCounts[l:lineText]=(has_key(l:lineCounts, l:lineText) ? l:lineCounts[l:lineText] : 0) + 1
        endif
        let l:lineNum=l:lineNum + 1
    endwhile
    exe 'syn clear Repeat'
    for l:lineText in keys(l:lineCounts)
        if l:lineCounts[l:lineText] >= 2
            exe 'syn match Repeat "^' . escape(l:lineText, '".\^$*[]') . '$"'
        endif
    endfor
endfunction
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

" Cscope (CTags are often better)
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" ALE
let g:ale_lint_on_text_changed = 'never'

" Airline
" set laststatus=2
" set ttimeoutlen=50
" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled = 1

" Airline Theme
" let g:airline_theme='base16'

" Lightline
let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list=1
" let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_c_checkers = ['clang_check', 'clang_tidy', 'gcc']
" let g:syntastic_c_clang_check_post_args = ''
" let g:syntastic_c_clang_tidy_post_args = ''
" let g:syntastic_cpp_checkers = ['clang_check', 'clang_tidy', 'gcc']
" let g:syntastic_cpp_clang_check_post_args = ''
" let g:syntastic_cpp_clang_tidy_post_args = ''
" let g:syntastic_vim_checkers = ['vint']
" let g:syntastic_check_on_open = 0

" YCM
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_server_python_interpreter = '/bin/python2'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist=['~/.vim/*']
let g:ycm_always_populate_location_list = 0
let g:ycm_auto_trigger=1
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_enable_diagnostic_signs=1
let g:ycm_max_diagnostics_to_display=10000
let g:ycm_min_num_identifier_candidate_chars=0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_open_loclist_on_ycm_diags=1
let g:ycm_show_diagnostics_ui=1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist={
            \ 'vim' : 1,
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'md' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'infolog' : 1,
            \ 'mail' : 1
            \}
map <F9> :YcmCompleter FixIt<CR>

" YCM Debug
" let g:ycm_server_use_vim_stdout = 1
" let g:ycm_server_log_level = 'debug'

if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" OmniFunction
let g:haskellmode_completion_ghc = 0
set omnifunc=syntaxcomplete#Complete
augroup omnifunc_set
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END
nnoremap <F12> :YcmDiags<CR>
nnoremap <silent> <Leader>yd :YcmDiags<CR>
nnoremap <silent> <Leader>fi :YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>gt :YcmCompleter GoTo<CR>

" Language specific settings
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set cindent
augroup codefmt_set
  autocmd FileType c,cpp,cc,h setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType bzl setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

" Friendly cat
" echom \"=^..^= ~Welcome Nyaa!~"
