" Required when connecting over SSH
syntax on

set nocompatible              " be iMproved, required
filetype off                  " required

set number " Also show current absolute line
set showcmd " Show (partial) command in status line.
" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=precedes:«,extends:»,tab:▸~,space:·
set list

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=750
let g:go_highlight_function_calls = 1

" Copy indent from current line when starting a new line
set autoindent
set copyindent
" Automatically detect correct indentation for new lines.
" Enable auto-indentation only on specific filetypes because other filetypes
" may have specially purposed indentation tools (e.g. gofmt) or
" auto-indentation is not unwanted (e.g. *.txt files).
let g:sleuth_automatic = 0

" Configure vim-linux-coding-style plugin on which directories to apply
" Linux coding style

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

let g:taboo_tab_format = ' %N %f%m %d '
let g:taboo_renamed_tab_format = ' %N %l%m %d '
let g:taboo_unnamed_tab_label = '[No Name]'

set nocursorline
set norelativenumber
set foldlevel=0
set foldmethod=manual

let g:gasCppComments = 1

" Search case-insensitive
set ignorecase
" Search case-sensitive if pattern contains an upper-case character
set smartcase

" vim-sneak configuration
let g:sneak#use_ic_scs = 1  " Case sensitivty by ignorecase & smartcase settings
let g:sneak#s_next = 1      " Press s again to move to next match
let g:sneak#label = 1       " Allows quick jump by labels

" Setup vim command auto-completion to show menu with options
" and not auto-complete with first option
set wildmode=longest:full,full
set wildmenu

" Don't break long lines
set wrap!
let g:gitgutter_highlight_lines = 0

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

set noswapfile

" Enable mouse in all vim modes
set mouse=a

" Fix backspace in insert-mode in new VIM versions
set backspace=indent,eol,start

let g:linuxsty_patterns = [ "/linux/" ]

let g:tmux_navigator_no_mappings = 1

set expandtab ts=8 sw=8 ai
