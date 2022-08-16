let g:airline#extensions#coc#warning_symbol = '⚠ '
let g:airline#extensions#coc#error_symbol = '✗ '

let g:airline_symbols = {}
let g:airline_symbols.colnr = '  %'
let g:airline_symbols.maxlinenr = ' ☰ '

" vim-airline tab-line configuration
let g:airline#extensions#tabline#enabled = 0
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
