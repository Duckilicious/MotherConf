return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Library plugins:
		use 'xolox/vim-misc'

	-- Fuzzy search plugins:
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'
	-- Note: Scroll fzf preview with mouse or shift-up/down
	-- (Also bind other keys to preview-up/preview-down action)

	-- Code-navigation plugins:
	use 'ludovicchabant/vim-gutentags'	-- Automatically manage and update ctags
	use 'preservim/nerdtree'		-- Display files and directories in tree pane
	use 'ryanoasis/vim-devicons'		-- Add icons to nerdtree files and directories

	-- Git plugins:
	use 'tpope/vim-fugitive'		-- git-ls, git log, git blame from inside vim
	use 'jreybert/vimagit' 		-- Git workflow from inside vim
	use 'airblade/vim-gitgutter'		-- Git highlights

	-- Text-editing plugins:
	use 'tpope/vim-commentary'		-- Comment stuff by marking and then pressing gc
	use 'haya14busa/incsearch.vim' 	-- Highlight search match when typing search term
	use 'junegunn/vim-easy-align'		-- Easily align selected text by delimiter
	use 'tpope/vim-sleuth' 		-- Automatically detect indentation of files

	-- Programming-languages plugins:
	use 'rust-lang/rust.vim'				-- Rust
	use {
		'fatih/vim-go',
		cmd = { 'do', ':GoUpdateBinaries'}
	} -- Go

	use 'puremourning/vimspector'-- Multi-language integrated debugger

	-- LSPs (Language Server Protocols) support + auto-completion capabilities
	use {
		'neoclide/coc.nvim',
		branch = 'release'
	}

	-- Clipboard over ssh
    use {
        'ojroques/vim-oscyank',
        branch = 'main'
    }

	-- UI/UX plugins:
	use 'christoomey/vim-tmux-navigator'	-- Navigate between vim splits and tmux panes transparently
						-- (Without caring which is vim split and which is tmux pane)
	use 'vim-airline/vim-airline'		-- Advanced vim status-line & tabs-line
	use 'wincent/terminus' 		-- Change vim cursor shape on insert-mode
	use 'octol/vim-cpp-enhanced-highlight' -- Enhanced C++ syntax highlighting
	use 'bfrg/vim-cpp-modern'		-- Modern C++ syntax highlighting
	use 'blueyed/vim-diminactive'		-- Dim inactive windows
	use 'masukomi/vim-markdown-folding'	-- Automatically add foldings to Markdown files
	use 'inkarkat/vim-ingo-library'	-- Prerequisite of the mark plugin
	use 'machakann/vim-highlightedyank'
	use 'chriskempson/base16-vim'

	use 'inkarkat/vim-mark' -- Mark vim words
	use 'rhysd/vim-clang-format' -- Clang formatter

	use 'xolox/vim-notes' -- Notes
	use 'frazrepo/vim-rainbow' -- Color matching brackets
	use 'justinmk/vim-sneak'
	use 'jiangmiao/auto-pairs'
	-- BufferLine
	use 'kyazdani42/nvim-web-devicons'
	use {
		'akinsho/bufferline.nvim',
		tag = 'v2.*'
	}
	use 'danilamihailov/beacon.nvim'
	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'mfussenegger/nvim-dap'
    use 'kamykn/spelunker.vim'
end)


