" Highlight current symbol references after 'updatetime' have passed
" without cursor moving
autocmd CursorHold * silent call CocActionAsync('highlight')

" Define colors for LSP analysis
autocmd VimEnter * highlight CocErrorHighlight cterm=underline ctermfg=red gui=underline guifg=#F44747
autocmd VimEnter * highlight CocErrorSign ctermfg=red guifg=#F44747
autocmd VimEnter * highlight CocWarningHighlight cterm=underline ctermfg=yellow gui=underline guifg=#f2f266
autocmd VimEnter * highlight CocWarningSign ctermfg=yellow guifg=#f2f266
autocmd VimEnter * highlight CocHighlightText cterm=None ctermbg=black gui=None guibg=#3e3e3e
" Define color for C/C++ Type
autocmd BufWinEnter *.c,*.h,*.cpp,*.hh,*.cc highlight Type cterm=none ctermfg=43 guifg=#4EC9B0
" Define colors for LSP semantic highlighting
autocmd VimEnter * highlight link CocSem_class CocSem_type
" Utility to to jump with LSP and push current position to tagstack

" Automatically fold sections in figutive git diffs
autocmd FileType git setlocal foldmethod=syntax

autocmd BufReadPost *.c,*.h,*.cpp,*.hh,*.cc,*.py silent! :Sleuth

" Show characters exceeding column 80
autocmd BufWinEnter *.c,*.h,*.cpp,*.hh,*.cc let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
autocmd BufWinEnter *.py,*.js,*.rs let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Highlight extra whitespace at the end of lines
autocmd BufWinEnter *.c,*.h,*.cpp,*.hh,*.cc,*.py,*.js,*.rs match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertEnter *.c,*.h,*.cpp,*.hh,*.cc,*.py,*.js,*.rs match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave *.c,*.h,*.cpp,*.hh,*.cc,*.py,*.js,*.rs match ExtraWhitespace /\s\+$/

" Set syntax highlighting for non-standard extensions
autocmd BufNewFile,BufRead *.nasm set syntax=nasm
autocmd BufNewFile,BufRead *.S set syntax=gas
autocmd BufWinEnter *.c,*.h,*.cpp,*.hh,*.cc setlocal cc=80

au FileType gitcommit,gitrebase let g:gutentags_enabled=0
