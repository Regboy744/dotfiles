-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
--
-- Editor config
-- Indentation (you already have these)
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true -- Auto-indent new lines intelligently
-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true -- Shows absolute number on current line
-- Search
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- BUT case-sensitive if you use capitals
vim.opt.hlsearch = false -- Don't highlight all search matches (less noisy)
-- UI/UX
vim.opt.termguicolors = true -- Better colors
vim.opt.cursorline = true -- Highlight current line
vim.opt.signcolumn = "yes" -- Always show sign column (no text jumping)
vim.opt.wrap = false -- Don't wrap long lines
-- Splits
vim.opt.splitright = true -- Vertical splits open on the right
vim.opt.splitbelow = true -- Horizontal splits open below
-- Performance
vim.opt.updatetime = 250 -- Faster completion (default is 4000ms)
vim.opt.timeoutlen = 300 -- Faster key sequence timeout
-- Files
vim.opt.swapfile = false -- No .swp files
vim.opt.backup = false -- No backup files
vim.opt.undofile = true -- Save undo history to file
vim.opt.autowrite = true -- Auto-save when switching buffers
-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
---
