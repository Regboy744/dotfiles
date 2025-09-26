return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    -- vim.cmd.colorscheme("tokyonight-night")

    -- Create autocmd that runs after EVERYTHING
    vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
      callback = function()
        -- Main editor transparency
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
        vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
        vim.cmd("hi LineNr guibg=NONE ctermbg=NONE")
        vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")

        -- Telescope transparency
        vim.cmd("hi TelescopeNormal guibg=NONE")
        vim.cmd("hi TelescopeBorder guibg=NONE")
        vim.cmd("hi TelescopePromptNormal guibg=NONE")
        vim.cmd("hi TelescopeResultsNormal guibg=NONE")
        vim.cmd("hi TelescopePreviewNormal guibg=NONE")

        -- Other popup transparency
        vim.cmd("hi NormalFloat guibg=NONE")
        vim.cmd("hi FloatBorder guibg=NONE")
      end,
    })
  end,
}
