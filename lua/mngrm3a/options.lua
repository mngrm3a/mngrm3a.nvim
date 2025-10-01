-- Editor Appearance
-- Enable true color support in terminal
vim.opt.termguicolors = true
-- Cursor appearance for different modes
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:block,r-cr:hor80,o:hor50,v-c-i-ci-ve:blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
-- Highlight current line
vim.opt.cursorline = true
-- Show sign column with width of 3
vim.opt.signcolumn = "yes:3"
-- Highlight column at 80 characters
vim.opt.colorcolumn = "80"
-- Keep 8 lines above/below cursor when scrolling
vim.opt.scrolloff = 8

-- Line Numbers
-- Show absolute line numbers
vim.opt.nu = true
-- Show relative line numbers
vim.opt.relativenumber = true

-- Indentation and Formatting
-- Number of spaces a tab counts for
vim.opt.tabstop = 4
-- Number of spaces for soft tab (backspace)
vim.opt.softtabstop = 4
-- Number of spaces for indentation
vim.opt.shiftwidth = 4
-- Convert tabs to spaces
vim.opt.expandtab = true
-- Auto-indent new lines based on previous line
vim.opt.smartindent = true
-- Disable line wrapping
vim.opt.wrap = false

-- Whitespace Visualization
-- Define characters for whitespace visualization
vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<"
-- Enable whitespace visualization
vim.opt.list = true

-- Spell Checking
-- Set spellcheck languages
vim.opt.spelllang = { "en_us", "de_de" }
-- Enable spellcheck
vim.opt.spell = true

-- File and Undo Management
-- Disable swap file creation
vim.opt.swapfile = false
-- Disable backup files
vim.opt.backup = false
-- Set directory for undo files
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
-- Enable persistent undo
vim.opt.undofile = true

-- Search
-- Disable highlight of search matches
vim.opt.hlsearch = false
-- Enable incremental search
vim.opt.incsearch = true

-- Miscellaneous
-- Allow @ in filenames
vim.opt.isfname:append("@-@")
-- Time (ms) before triggering CursorHold event
vim.opt.updatetime = 400
