" Set gui colors if supported
if has('termguicolors')
       set termguicolors
end

if !has('nvim')
	" Set name of terminal to xterm-256colors
	" which describes Xterm with 256 colors enabled
	set term=xterm-256color
endif

" set background=dark
let base16colorspace=256
"let g:base16_shell_path="~/dev/others/base16/templates/shell/scripts/"
hi Comment term=bold cterm=NONE ctermfg=245 gui=NONE guifg=#928374
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material
" call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")

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
" Set vertical split color
highlight VertSplit cterm=none ctermfg=lightgray ctermbg=black gui=none guifg=#D4D4D4 guibg=#2D2D30
" Set different color for inactive windows
highlight ColorColumn ctermbg=236 guibg=#2D2D2D
