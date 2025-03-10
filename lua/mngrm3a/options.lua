vim.opt.guicursor =
"n-v-c:block,i-ci-ve:block,r-cr:hor80,o:hor50,v-c-i-ci-ve:blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.cursorline = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

-- time after the last keypress in ms until CursorHold is triggered
vim.opt.updatetime = 400

vim.opt.signcolumn = "yes:3"
vim.opt.colorcolumn = "80"

vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<"
vim.opt.list = true;

vim.opt.spelllang = { "en_us", "de_de" }
vim.opt.spell = true
