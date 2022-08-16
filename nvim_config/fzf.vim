" Fuzzy search on git-grep
function! FzfGitGrep(query)
	let grep_command = 'git grep --line-number ' . shellescape(a:query)
	let fzf_color_option = split(fzf#wrap()['options'])[0]
	let opts = {'options': fzf_color_option . ' --prompt "GitGrep> "'}
	call fzf#vim#grep(grep_command, 0, fzf#vim#with_preview(opts), 0)
endfunction

let $FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""

" Define BLines with preview window based on rg
command! -bang -nargs=* BLinesPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:60%'))

" Customize the git log options used by Commits/BCommits
let g:fzf_commits_log_options = '--color=always --abbrev-commit --date=relative --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold cyan)%an%Creset"'
" Customize Commits preview window
command! -bar -bang -range=% Commits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#commits({'window': { 'width': 0.95, 'height': 0.95 }}, <bang>0)
command! -bar -bang -range=% BCommits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#buffer_commits({'window': { 'width': 0.95, 'height': 0.95 }}, <bang>0)

" Fuzzy search spelling corrections
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction

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


