












let g:coc_global_extensions = ['coc-clangd', 'coc-pyright', 'coc-go', 'coc-rust-analyzer']

" Use Tab for auto-completion navigation
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1):
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <CR> to accept auto-completion suggestion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Key-binding to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Key-bindings for LSP diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)

" Command to LSP to format current buffer
command! -nargs=0 CocFormat :call CocAction('format')
" Command to LSP to fold current buffer
command! -nargs=? CocFold :call CocAction('fold', <f-args>)

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


let g:coc_fzf_preview = 'right:60%'
nmap <silent><nowait> ,ra <Plug>(coc-codelens-action)

" Disable vim-go key-bindings (prefer coc.nvim key-bindings)
let g:go_def_mapping_enabled = 0

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

