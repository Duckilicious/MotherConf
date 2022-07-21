" Required when connecting over SSH
syntax on

" Set gui colors if supported
if has('termguicolors')
       set termguicolors
end

set nocompatible              " be iMproved, required
filetype off                  " required

if !has('nvim')
	" Set name of terminal to xterm-256colors
	" which describes Xterm with 256 colors enabled
	set term=xterm-256color
endif

" Fast paste from clipboard
noremap <M-v> "+p
" noremap <M-v> :read !pbpaste<CR>

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
" Library plugins:
Plug 'xolox/vim-misc'

" Fuzzy search plugins:
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Note: Scroll fzf preview with mouse or shift-up/down
" (Also bind other keys to preview-up/preview-down action)

" Code-navigation plugins:
Plug 'ludovicchabant/vim-gutentags'	" Automatically manage and update ctags
Plug 'preservim/nerdtree'		" Display files and directories in tree pane
Plug 'ryanoasis/vim-devicons'		" Add icons to nerdtree files and directories

" Git plugins:
Plug 'tpope/vim-fugitive'		" git-ls, git log, git blame from inside vim
Plug 'jreybert/vimagit' 		" Git workflow from inside vim
Plug 'airblade/vim-gitgutter'		" Git highlights

" Text-editing plugins:
Plug 'tpope/vim-commentary'		" Comment stuff by marking and then pressing gc
Plug 'haya14busa/incsearch.vim' 	" Highlight search match when typing search term
Plug 'junegunn/vim-easy-align'		" Easily align selected text by delimiter
Plug 'tpope/vim-sleuth' 		" Automatically detect indentation of files

" Programming-languages plugins:
Plug 'rust-lang/rust.vim'				" Rust
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }	" Go
Plug 'puremourning/vimspector' 			" Multi-language integrated debugger

" LSPs (Language Server Protocols) support + auto-completion capabilities
Plug 'neoclide/coc.nvim', {'branch': 'release'}	" LSP manager (Install / Update / UnInstall) + auto-completion
" Automatically install following coc extensions
 let g:coc_global_extensions = ['coc-clangd', 'coc-pyright', 'coc-go', 'coc-rust-analyzer']

" Clipboard over ssh
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" UI/UX plugins:
Plug 'christoomey/vim-tmux-navigator'	" Navigate between vim splits and tmux panes transparently
					" (Without caring which is vim split and which is tmux pane)
Plug 'vim-airline/vim-airline'		" Advanced vim status-line & tabs-line
Plug 'wincent/terminus' 		" Change vim cursor shape on insert-mode
Plug 'octol/vim-cpp-enhanced-highlight' " Enhanced C++ syntax highlighting
Plug 'bfrg/vim-cpp-modern'		" Modern C++ syntax highlighting
Plug 'blueyed/vim-diminactive'		" Dim inactive windows
Plug 'masukomi/vim-markdown-folding'	" Automatically add foldings to Markdown files
Plug 'inkarkat/vim-ingo-library'	" Prerequisite of the mark plugin
Plug 'machakann/vim-highlightedyank'
Plug 'chriskempson/base16-vim'

Plug 'inkarkat/vim-mark' " Mark vim words
Plug 'rhysd/vim-clang-format' " Clang formatter

Plug 'xolox/vim-notes' " Notes
Plug 'frazrepo/vim-rainbow' "Color matching brackets

" Initialize plugin system
" (All of your Plugins must be added before the following line)
call plug#end()

" More esc
imap jj <Esc>
nmap gb :Git blame<CR>
set number " Also show current absolute line
set showcmd " Show (partial) command in status line.

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=precedes:«,extends:»,tab:▸~,space:·
set list

" Use Tab for auto-completion navigation
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <CR> to accept auto-completion suggestion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Key-binding to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Key-bindings for LSP diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)

" Utility to push item to tagstack
function! TagstackPush(item)
	let tagstack = gettagstack()
	let curidx = tagstack['curidx']
	let winid = winnr()

	if curidx == (tagstack['length'] + 1)
		call add(tagstack['items'], a:item)
		let tagstack['length'] = curidx
	else
		let tagstack['items'][curidx-1] = a:item
	endif

	call settagstack(winid, tagstack, 'r')
	call settagstack(winid, {'curidx' : curidx + 1})
endfunction

"Coc Stuff
"
" Command to LSP to format current buffer
command! -nargs=0 CocFormat :call CocAction('format')
" Command to LSP to fold current buffer
command! -nargs=? CocFold :call CocAction('fold', <f-args>)

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

function! GotoTag(goto_kind)
	let tag_name = expand('<cword>')
	let curpos = getcurpos()
	let curpos[0] = bufnr()
	if CocAction('jump' . a:goto_kind)
		let tagstack_item = {'tagname' : tag_name, 'from' : curpos}
		call TagstackPush(tagstack_item)
	endif
endfunction

" Key-bindings for LSP code navigation
" nmap <silent> ,d <Plug>(coc-definition)
" nmap <silent> ,i <Plug>(coc-implementation)
" nmap <silent> ,r <Plug>(coc-references)
nmap <silent> ,g :call GotoTag("Definition")<CR>
nmap <silent> ,i :call GotoTag("Implementation")<CR>
nmap <silent> ,v :call GotoTag("References")<CR>
nmap <silent> ,V :pop<CR>
nnoremap <silent> ,h :call CocAction('doHover')<CR>
nmap <silent> ,b :CocList outline<CR>
nmap <silent> ,s :CocList -I symbols<CR>
nmap <silent> ,I :CocCommand document.showIncomingCalls<CR>
nmap <silent> ,O :CocCommand document.showOutgoingCalls<CR>
nnoremap <silent> <leader>d :<C-u>CocList diagnostics<cr>

" Key-bindings for LSP actions
nmap ,rn <Plug>(coc-rename)
nmap ,a <Plug>(coc-codeaction)
nmap ,f <Plug>(coc-fix-current)
nmap ,fo <Plug>(coc-format-selected)

" Set LSP signs for status-line
let g:coc_status_error_sign = '✗'
let g:coc_status_warning_sign = '⚠'
let g:airline#extensions#coc#warning_symbol = '⚠ '
let g:airline#extensions#coc#error_symbol = '✗ '

let g:airline_symbols = {}
let g:airline_symbols.colnr = '  %'
let g:airline_symbols.maxlinenr = ' ☰ '

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=750
let g:go_highlight_function_calls = 1

" Disable vim-go key-bindings (prefer coc.nvim key-bindings)
let g:go_def_mapping_enabled = 0

" Automatically fold sections in figutive git diffs
autocmd FileType git setlocal foldmethod=syntax

" Copy indent from current line when starting a new line
set autoindent
set copyindent
" Automatically detect correct indentation for new lines.
" Enable auto-indentation only on specific filetypes because other filetypes
" may have specially purposed indentation tools (e.g. gofmt) or
" auto-indentation is not unwanted (e.g. *.txt files).
let g:sleuth_automatic = 0
autocmd BufReadPost *.c,*.h,*.cpp,*.hh,*.cc,*.py :Sleuth

" Configure vim-linux-coding-style plugin on which directories to apply
" Linux coding style
let g:linuxsty_patterns = [ "/linux/" ]

" Tmux navigator bindings
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <S-Up> :TmuxNavigateUp<cr>

" Resize vim splits
nnoremap <S-l> :vertical resize +1<CR>
nnoremap <S-h> :vertical resize -1<CR>
nnoremap <S-j> :resize -1<CR>
nnoremap <S-k> :resize +1<CR>

" Fuzzy text search

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" Fuzzy search on text using ripgrep (rg)
"nnoremap <leader>r :Rg<CR>
nnoremap <leader>R :Rg<Space><C-r><C-w>

" Fuzzy search on git-grep
function! FzfGitGrep(query)
	let grep_command = 'git grep --line-number ' . shellescape(a:query)
	let fzf_color_option = split(fzf#wrap()['options'])[0]
	let opts = {'options': fzf_color_option . ' --prompt "GitGrep> "'}
	call fzf#vim#grep(grep_command, 0, fzf#vim#with_preview(opts), 0)
endfunction
nnoremap <leader>fa :call FzfGitGrep('')<CR>
nnoremap <leader>F :call FzfGitGrep(expand('<cword>'))<CR>

" Fuzzy search on git-ls and ls
nnoremap <leader>l :GFiles<CR>
nnoremap <leader>k :Files<CR>

let $FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""
" Fuzzy search tags in project
nnoremap <leader>t :Tags<CR>
nnoremap <leader>T :Tags<Space><C-R><C-W><CR>

" Fuzzy search tags in current buffer
nnoremap <leader>b :BTags<CR>
nnoremap <leader>B :BTags<Space><C-R><C-W><CR>

" :Commits, :BCommits, :Lines, :BLines
nnoremap <leader>v :Commits<CR>
nnoremap <leader>c :BCommits<CR>

" Define BLines with preview window based on rg
command! -bang -nargs=* BLinesPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:60%'))
nnoremap <C-l> :BLinesPreview<CR>

" Customize the git log options used by Commits/BCommits
let g:fzf_commits_log_options = '--color=always --abbrev-commit --date=relative --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold cyan)%an%Creset"'
" Customize Commits preview window
command! -bar -bang -range=% Commits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#commits({'window': { 'width': 0.95, 'height': 0.95 }}, <bang>0)
command! -bar -bang -range=% BCommits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#buffer_commits({'window': { 'width': 0.95, 'height': 0.95 }}, <bang>0)

" Save shortcut
nnoremap <CR> :w<CR>

" Jump to tag under cursor shortcut
nnoremap tj :tj<Space><C-R><C-W><CR>

" Search with highlighting
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" NERDTree (files and directories tree) shortcut
map tt :NERDTreeToggle<CR>

" Tabs management shortcuts
noremap <silent> <S-t> :tabedit<CR>
noremap <silent> ]t :tabn<CR>
noremap <silent> [t :tabp<CR>
noremap <silent> tc :tabclose<CR>
noremap <silent> to :tabonly<CR>
noremap <silent> tm :tabmove -1<CR>
noremap <silent> t, :tabmove +1<CR>

" #gt - Go to tab number #
" :tabmove #: Moves current tab to position #
function! TabRename()
	let tab_name = input('Enter tab name: ')
	execute 'TabooRename ' . tab_name
endfunction
noremap <silent> tn :call TabRename()<CR>
let g:taboo_tab_format = ' %N %f%m %d '
let g:taboo_renamed_tab_format = ' %N %l%m %d '
let g:taboo_unnamed_tab_label = '[No Name]'

" vim-airline tab-line configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline_section_y = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#zoomwintab#enabled = 1
let g:airline#extensions#zoomwintab#status_zoomed_in = 'Zoomed In'

" vim-airline color for inactive status-lines (Horizontal splits)
let g:airline_inactive_collapse = 1
let g:airline_inactive_alt_sep = 1
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
	if g:airline_theme == 'codedark'
		for colors in values(a:palette.inactive)
			" ctermfg - colors[2]
			" ctermbg - colors[3]
			let colors[3] = 238
		endfor
	endif
endfunction

" Reminder for useful default shortcuts:
"
" Recording:
" q[a-z] - Starts recording of letter [a-z]
" q - Stops recording
" @[a-z] - Do recording of letter [a-z]
" @@ - Do last recording
" X@@ - Do last recording X times

"
" Marks:
" m[a-z] - Create local mark of letter [a-z]
" '[a-z] - Jump to local mark of letter [a-z]
" m[A-Z] and '[A-Z] - Same as above but global mark
" :marks - Show all marks

set background=dark
let base16colorspace=256
let g:base16_shell_path="~/dev/others/base16/templates/shell/scripts/"
colorscheme base16-gruvbox-dark-hard

" Brighter comments
call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")

" Set visual selection color
" highlight Visual cterm=bold ctermbg=black ctermfg=NONE
" Set search match color
highlight Search cterm=bold ctermbg=darkblue ctermfg=NONE gui=bold guibg=#264F78 guifg=NONE
highlight IncSearch cterm=bold ctermbg=darkblue ctermfg=NONE gui=bold guibg=#264F78 guifg=NONE
" Set matching brackets color
highlight MatchParen cterm=bold ctermbg=darkblue ctermfg=NONE gui=bold guibg=#264F78 guifg=NONE
" Set folded text color
highlight Folded cterm=none ctermfg=lightgray ctermbg=black gui=none guifg=#D4D4D4 guibg=#2D2D30
" Set figutive git diff colors (Same as "git diff" command)
highlight diffFile cterm=bold gui=bold
highlight diffNewFile cterm=bold gui=bold
highlight diffLine cterm=none ctermfg=darkblue gui=none guifg=#264F78
highlight diffAdded cterm=none ctermfg=darkgreen gui=none guifg=#54b84b
highlight diffRemoved cterm=none ctermfg=darkred gui=none guifg=#d63636
" Set color of extra whitespace at the end of lines
highlight ExtraWhitespace ctermbg=darkred guibg=#d63636
" Set color of spelling erorrs
highlight SpellBad cterm=underline ctermfg=darkred gui=underline guifg=#d63636
" Set color of cursor line
"highlight CursorLine ctermbg=235 guibg=#2b2b2b
set nocursorline
set norelativenumber
set foldlevel=0
set foldmethod=manual

" Set vertical split color
highlight VertSplit cterm=none ctermfg=lightgray ctermbg=black gui=none guifg=#D4D4D4 guibg=#2D2D30
" Set different color for inactive windows
highlight ColorColumn ctermbg=236 guibg=#2D2D2D


" Show characters exceeding column 130
autocmd BufWinEnter *.c,*.h,*.cpp,*.hh,*.cc,*.py,*.js let w:m2=matchadd('ErrorMsg', '\%>130v.\+', -1)

" Highlight extra whitespace at the end of lines
autocmd BufWinEnter *.c,*.h,*.cpp,*.hh,*.cc,*.py,*.js match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertEnter *.c,*.h,*.cpp,*.hh,*.cc,*.py,*.js match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave *.c,*.h,*.cpp,*.hh,*.cc,*.py,*.js match ExtraWhitespace /\s\+$/

" Set fzf colors to match vim colorscheme
" (See: https://github.com/junegunn/fzf/wiki/Color-schemes)
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'SpecialKey'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'String'],
  \ 'info':    ['fg', 'Comment'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'StorageClass'],
  \ 'pointer': ['fg', 'Error'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Show fzf window at bottom
" (Default behaviour before fzf commit c60ed1758315 ("[vim] Change the default layout to use popup window"))
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:60%', '?']
let g:coc_fzf_preview = 'right:60%'

" Spellchecking shortcuts:
" set spell - Enable spell-checking
" set nospell - Disable spell-checking
" ]s - Move to next misspelled word
" [s - Move to previous misspelled word
" z= - Suggest spelling correction
" zg - Add word to spelling dictionary

" Fuzzy search spelling corrections
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction
nnoremap z= :call FzfSpell()<CR>

" Enable mouse in all vim modes
set mouse=a

" Fix backspace in insert-mode in new VIM versions
set backspace=indent,eol,start

" Do not use swapfiles
set noswapfile

" Shortcut to switch from vertical to horizontal split
nnoremap <silent> <leader>wh <C-w>t<C-w>K
" Shortcut to switch from horizontal to vertical split
nnoremap <silent> <leader>wv <C-w>t<C-w>H

" Shortcuts for vimspector
nmap <F5>	<Plug>VimspectorContinue
nmap dc 	<Plug>VimspectorContinue
nmap <S-F5>	<Plug>VimspectorStop
nmap ds 	<Plug>VimspectorStop
nmap <C-S-F5>	<Plug>VimspectorRestart
nmap dr 	<Plug>VimspectorRestart
nmap <F6>	<Plug>VimspectorPause
nmap dp 	<Plug>VimspectorPause
nmap <F9>	<Plug>VimspectorToggleBreakpoint
nmap db 	<Plug>VimspectorToggleBreakpoint
nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>db   <Plug>VimspectorToggleConditionalBreakpoint
nmap <S-F9>	<Plug>VimspectorAddFunctionBreakpoint
nmap df 	<Plug>VimspectorAddFunctionBreakpoint
nmap <F10>	<Plug>VimspectorStepOver
nmap dn 	<Plug>VimspectorStepOver
nmap <F11>	<Plug>VimspectorStepInto
nmap di 	<Plug>VimspectorStepInto
nmap <S-F11>	<Plug>VimspectorStepOut
nmap do 	<Plug>VimspectorStepOut
nnoremap dq :VimspectorReset<CR>
"let g:vimspector_enable_mappings = 'HUMAN'
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" Set syntax highlighting for non-standard extensions
autocmd BufNewFile,BufRead *.nasm set syntax=nasm
autocmd BufNewFile,BufRead *.S set syntax=gas
let g:gasCppComments = 1

" Search case-insensitive
set ignorecase
" Search case-sensitive if pattern contains an upper-case character
set smartcase

" vim-sneak configuration
let g:sneak#use_ic_scs = 1 	" Case sensitivty by ignorecase & smartcase settings
let g:sneak#s_next = 1		" Press s again to move to next match
let g:sneak#label = 1		" Allows quick jump by labels

" Setup vim command auto-completion to show menu with options
" and not auto-complete with first option
set wildmode=longest:full,full
set wildmenu

" Don't break long lines
set wrap!

" Set terminal colors to gnome terminal tango palette
" This is done in order to have nicer colors in vim preview windows
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

"Give 's' same functionallity as in in vim
nmap s xi
vmap s xi

"Set marker plug
nmap ,m <Plug>MarkToggle

"Set Git Gutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
let g:gitgutter_highlight_lines = 0

autocmd BufWinEnter *.c,*.h,*.cpp,*.hh,*.cc setlocal cc=130

" EbsServerAsyncFramework jump to StateMachine start_state
nnoremap ,c /<C-r><C-W>::start_state<CR>

" Zoom in/out of panes
noremap zz <c-w>_ \| <c-w>\|
noremap zo <c-w>=

noremap ra :RainbowToggle<CR>

" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/go/bin")
