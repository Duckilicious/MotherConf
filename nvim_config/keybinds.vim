let mapleader = " " " map leader to Space"

" Fast paste from clipboard
noremap <M-v> "+p
" noremap <M-v> :read !pbpaste<CR>

" More esc
imap jj <Esc>
nmap gb :Git blame<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

"Set Git Gutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

vnoremap <leader>c :OSCYank<CR>
nmap <leader>y <Plug>OSCYank

" Bufferline
nnoremap <silent><leader>b :BufferLineCycleNext<CR>
nnoremap <silent><leader>p :BufferLineCyclePrev<CR>
nnoremap <silent><leader>be :BufferLineSortByExtension<CR>
"nnoremap <silent><leader>bd :BufferLineSortByDirectory<CR>"
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><leader>$ <Cmd>BufferLineGoToBuffer -1<CR>

"Set marker plug
nmap ,m <Plug>MarkToggle

" Shortcut to switch from vertical to horizontal split
nnoremap <silent> <leader>wh <C-w>t<C-w>K
" Shortcut to switch from horizontal to vertical split
nnoremap <silent> <leader>wv <C-w>t<C-w>H

" Tabs management shortcuts
noremap <silent> <S-t> :tabedit<CR>
noremap <silent> ]t :tabn<CR>
noremap <silent> [t :tabp<CR>
noremap <silent> tc :tabclose<CR>
noremap <silent> to :tabonly<CR>
noremap <silent> tm :tabmove -1<CR>
noremap <silent> t, :tabmove +1<CR>

" Jump to tag under cursor shortcut
nnoremap tj :tj<Space><C-R><C-W><CR>

" Fuzzy search tags in project
nnoremap <leader>t :Tags<CR>
nnoremap <leader>T :Tags<Space><C-R><C-W><CR>

" :Commits, :BCommits, :Lines, :BLines
nnoremap <leader>v :Commits<CR>
"nnoremap <leader>c :BCommits<CR>


" Tmux navigator bindings
nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <S-Up> :TmuxNavigateUp<cr>

" Resize vim splits
nnoremap <S-l> :vertical resize +1<CR>
nnoremap <S-h> :vertical resize -1<CR>
nnoremap <S-j> :resize -1<CR>
nnoremap <S-k> :resize +1<CR>

" Fuzzy search on text using ripgrep (rg)
"nnoremap <leader>r :Rg<CR>
nnoremap <leader>R :Rg<Space><C-r><C-w>

" Fuzzy search on git-ls and ls
nnoremap <leader>l :Files<CR>
nnoremap <leader>k :GFiles<CR>

" Save shortcut
nnoremap <CR> :w<CR>
" Search with highlighting
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" NERDTree (files and directories tree) shortcut
map tt :NERDTreeToggle<CR>

function! TabRename()
	let tab_name = input('Enter tab name: ')
	execute 'TabooRename ' . tab_name
endfunction
noremap <silent> tn :call TabRename()<CR>

nnoremap <C-l> :BLinesPreview<CR>

" Shortcuts for vimspector
nmap dc 	<Plug>VimspectorContinue
"nmap ds 	<Plug>VimspectorStop
"nmap dr 	<Plug>VimspectorRestart
"nmap dp 	<Plug>VimspectorPause
nmap db 	<Plug>VimspectorToggleBreakpoint
"nmap <leader>db   <Plug>VimspectorToggleConditionalBreakpoint
"nmap df 	<Plug>VimspectorAddFunctionBreakpoint
"nmap dn 	<Plug>VimspectorStepOver
"nmap di 	<Plug>VimspectorStepInto
"nmap do 	<Plug>VimspectorStepOut
"nnoremap dq :VimspectorReset<CR>

nnoremap z= :call FzfSpell()<CR>
" Fuzzy text search
nnoremap <leader>F :call FzfGitGrep(expand('<cword>'))<CR>
nnoremap <leader>fa :call FzfGitGrep('')<CR>
" Fuzzy search via Ag
nnoremap <leader>la :Ag<CR>
" Close all open buffers
nnoremap <leader>bd :%bd\|e#\|bd#<cr>\|'"
