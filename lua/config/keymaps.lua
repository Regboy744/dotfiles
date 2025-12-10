-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- -- Scape
-- vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })

-- -- Save file
-- vim.keymap.set("n", "qq", ":w<CR>", { desc = "Save file with qq" })

-- vim.keymap.set("n", "<leader>ff", function()
--   require("vscode").action("workbench.action.quickOpen")
-- end, { desc = "Find files" })

-- -- Alternative options:

-- -- For fuzzy file finder (like telescope)
-- vim.keymap.set("n", "<C-p>", function()
--   require("vscode").action("workbench.action.quickOpen")
-- end, { desc = "Quick open files" })

-- -- For search in files (find text in files)
-- vim.keymap.set("n", "<leader>fg", function()
--   require("vscode").action("workbench.action.findInFiles")
-- end, { desc = "Find in files" })

-- -- For recent files
-- vim.keymap.set("n", "<leader>fr", function()
--   require("vscode").action("workbench.action.openRecent")
-- end, { desc = "Recent files" })

-- -- Add these to your keymaps.lua

-- -- Toggle explorer (open/close)
-- vim.keymap.set("n", "<leader>e", function()
--   require("vscode").action("workbench.action.toggleSidebarVisibility")
-- end, { desc = "Toggle Explorer" })

-- -- Focus explorer (open and focus)
-- vim.keymap.set("n", "<leader>E", function()
--   require("vscode").action("workbench.view.explorer")
-- end, { desc = "Focus Explorer" })

-- vim.keymap.set("n", "<leader>bb", function()
--   require("vscode").action("workbench.action.showAllEditors")
-- end, { desc = "Show all buffers" })
--

-- Common keymaps (work in both Neovim and VSCode)
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })
vim.keymap.set("n", "qq", ":w<CR>", { desc = "Save file with qq" })

-- Environment-specific keymaps
if vim.g.vscode then
  -- VSCode-specific keymaps
  vim.keymap.set("n", "<leader>ff", function()
    require("vscode").action("workbench.action.quickOpen")
  end, { desc = "Find files" })

  vim.keymap.set("n", "<C-p>", function()
    require("vscode").action("workbench.action.quickOpen")
  end, { desc = "Quick open files" })

  vim.keymap.set("n", "<leader>fg", function()
    require("vscode").action("workbench.action.findInFiles")
  end, { desc = "Find in files" })

  vim.keymap.set("n", "<leader>fr", function()
    require("vscode").action("workbench.action.openRecent")
  end, { desc = "Recent files" })

  vim.keymap.set("n", "<leader>e", function()
    require("vscode").action("workbench.action.toggleSidebarVisibility")
  end, { desc = "Toggle Explorer" })

  vim.keymap.set("n", "<leader>E", function()
    require("vscode").action("workbench.view.explorer")
  end, { desc = "Focus Explorer" })

  vim.keymap.set("n", "<leader>bb", function()
    require("vscode").action("workbench.action.showAllEditors")
  end, { desc = "Show all buffers" })

  --  Move cursor by lines (more like native Vim)
  vim.keymap.set("n", "<C-d>", function()
    require("vscode").action("cursorMove", { args = { to = "down", by = "line", value = 10 } })
  end, { desc = "Move down 10 lines" })

  vim.keymap.set("n", "<C-u>", function()
    require("vscode").action("cursorMove", { args = { to = "up", by = "line", value = 10 } })
  end, { desc = "Move up 10 lines" })
else
  -- Native Neovim keymaps (LazyVim already provides these by default)
  -- LazyVim's <leader>ff = Telescope find_files
  -- LazyVim's <leader>fg = Telescope live_grep
  -- LazyVim's <leader>fr = Telescope oldfiles
  -- LazyVim's <leader>e = Neo-tree toggle
end
