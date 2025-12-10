-- return {
--   "numToStr/Comment.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   config = function()
--     require("Comment").setup({
--       padding = true,
--       sticky = true,
--       ignore = "^$",

--       -- Required fields (even though we disable mappings)
--       toggler = {
--         line = "gcc",
--         block = "gbc",
--       },

--       opleader = {
--         line = "gc",
--         block = "gb",
--       },

--       extra = {
--         above = "gcO",
--         below = "gco",
--         eol = "gcA",
--       },

--       -- Disable all default mappings since we'll use custom ones
--       mappings = {
--         basic = false,
--         extra = false,
--       },

--       -- Custom hook to detect file types and Vue sections
--       pre_hook = function(ctx)
--         -- Get the current buffer's filetype
--         local filetype = vim.bo.filetype

--         -- Handle standalone JS/TS files (not Vue)
--         if
--           filetype == "javascript"
--           or filetype == "typescript"
--           or filetype == "javascriptreact"
--           or filetype == "typescriptreact"
--         then
--           return "// %s"
--         elseif filetype == "css" or filetype == "scss" or filetype == "less" then
--           return "/* %s */"
--         elseif filetype ~= "vue" then
--           -- For other file types, return nil to use defaults
--           return nil
--         end

--         -- Vue file specific logic (your original working code)
--         local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
--         local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

--         local in_script = false
--         local in_style = false

--         for i = cursor_line, 1, -1 do
--           if lines[i] then
--             if lines[i]:match("<%s*script") then
--               in_script = true
--               break
--             elseif lines[i]:match("<%s*style") then
--               in_style = true
--               break
--             elseif lines[i]:match("<%s*/script") or lines[i]:match("<%s*/template") or lines[i]:match("<%s*/style") then
--               break
--             end
--           end
--         end

--         -- Return the appropriate comment string for Vue sections
--         if in_script then
--           return "// %s"
--         elseif in_style then
--           return "/* %s */"
--         else
--           return "<!-- %s -->"
--         end
--       end,

--       post_hook = function() end,
--     })

--     -- Custom keybindings
--     vim.keymap.set("n", "gcc", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment line" })
--     vim.keymap.set("v", "gc", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment selection" })
--     -- vim.keymap.set("n", "gbc", "<Plug>(comment_toggle_blockwise_current)", { desc = "Toggle block comment line" })
--     -- vim.keymap.set("v", "gb", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Toggle block comment selection" })
--   end,
-- }
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = false,
        extra = false,
      },
      -- This replaces your entire custom pre_hook function!
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      post_hook = function() end,
    })
    -- Custom keybindings (keep as-is)
    vim.keymap.set("n", "gcc", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment line" })
    vim.keymap.set("v", "gc", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment selection" })
    vim.keymap.set("n", "gbc", "<Plug>(comment_toggle_blockwise_current)", { desc = "Toggle block comment line" })
    vim.keymap.set("v", "gb", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Toggle block comment selection" })
  end,
}
