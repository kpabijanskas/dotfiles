-- Leader should be set near the top
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Disable loading netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

-- Buffers should not be abbandoned
vim.o.hidden = true

-- Allow moving the cursor past last character in block visual
vim.o.virtualedit = "block"

-- termuicolors
vim.o.termuicolors = true

-- Always show the sign column
vim.o.signcolumn = "yes:2"

-- Tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true

-- Smart indenting
vim.o.smartindent = true

-- Line numbers
vim.o.relativenumber = true
vim.o.number = true

-- Briefly show matching brackets when they are inserted
vim.o.showmatch = true
vim.o.matchtime = 2

-- Always show status lines
vim.o.laststatus = 2

-- cmdline should always take 1 row
vim.o.cmdheight = 1

-- Window splitting preferences
vim.o.splitright = true
vim.o.splitbelow = true

-- Popup options
vim.o.wildmode = "list:full"
vim.o.wildoptions = "pum"

-- Completeopt:
--   - Show pupup
--   - Show menhu when only one option
--   - Don't select an option automatically, let me do that
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Folding
vim.o.foldmethod = "syntax"
-- Always start folder, otherwise I forget they exist
vim.o.foldlevel = 1
vim.o.foldlevelstart = 1
vim.o.foldcolumn = "4"

-- Don't give ins-completion-menu messages
vim.opt.shortmess:append("c")

-- Number of idle ms before swapfile is written
vim.o.updatetime = 100

-- Encoding
vim.o.encoding = "utf-8"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	checker = {
		enabled = true,
		notify = false,
		frequency = 86400, -- once a day
	},
})

-- Perl-style regex by default
vim.keymap.set("n", "/", "/\\v", {
	noremap = true,
	silent = true,
})
vim.keymap.set("x", "/", "/\\v", {
	noremap = true,
	silent = true,
})

-- -- Normal mode paste button that is not plagued by insert mode formatting
-- vim.keymap.set("n", "<leader>p", ":set paste<CR>:put *<CR>:set nopaste<CR>", {
-- 	noremap = true,
-- 	silent = true,
-- 	desc = "Paste",
-- })

-- Disable arrows
vim.keymap.set({ "n", "i", "x" }, "<up>", "<nop>", {})
vim.keymap.set({ "n", "i", "x" }, "<down>", "<nop>", {})
vim.keymap.set({ "n", "i", "x" }, "<left>", "<nop>", {})
vim.keymap.set({ "n", "i", "x" }, "<right>", "<nop>", {})

-- Disable F1
vim.keymap.set({ "n", "i", "x", "v" }, "<F1>", "<nop>", {})

