-- This is a recommended plugin configuration based on your goal of mastering
-- JavaScript, TypeScript, and Vue.js. It disables redundant or unnecessary
-- plugins to keep your editor fast and easy to maintain.

return {
  -- ==========================================================================
  -- SECTION 1: ESSENTIAL PLUGINS (ENABLED)
  -- These are the core plugins that will actively help you in your daily work.
  -- ==========================================================================

  -- AI/Completion
  { "github/copilot.vim", enabled = false }, -- Essential for productivity

  -- Testing
  { "nvim-neotest/neotest", enabled = false },
  { "thenbe/neotest-playwright", enabled = false }, -- Perfect for your JS/TS stack

  -- UI/Focus
  { "folke/zen-mode.nvim", enabled = false }, -- Great for distraction-free coding

  -- ==========================================================================
  -- SECTION 2: REDUNDANT PLUGINS (DISABLED)
  -- These plugins do a job that is already handled by another plugin above.
  -- You should only have one plugin per task.
  -- ==========================================================================

  -- Icons: Disabled because nvim-web-devicons is enabled.
  { "mini.icons", enabled = false },

  -- Auto Pairs: Disabled because nvim-autopairs is enabled.
  { "mini.pairs", enabled = false },

  -- Rainbow Brackets: Disabled because nvim-treesitter's built-in 'rainbow' module is used instead.
  { "hiphish/rainbow-delimiters.nvim", enabled = true },

  -- ==========================================================================
  -- SECTION 3: PLUGINS NOT NEEDED FOR YOUR STACK (DISABLED)
  -- These are for languages or tools outside of your JS/TS/Vue focus.
  -- ==========================================================================

  { "Hoffs/omnisharp-extended-lsp.nvim", enabled = false }, -- For C#/.NET development
  { "nativetests/nuget.nvim", enabled = false }, -- For the .NET package manager
  { "p00f/ts-comments.nvim", enabled = false }, -- Superseded by the more powerful 'Comment.nvim'
  { "jpmcb/typr.nvim", enabled = false }, -- A typing tutor, not a core development tool
  -- 'volt' is not a standard Neovim plugin and can likely be removed entirely.

  -- ==========================================================================
  -- SECTION 4: COLOR SCHEMES (CHOOSE ONE)
  -- A good theme is important! Pick your favorite, enable it, and disable the rest.
  -- I've enabled Catppuccin as a great starting point.
  -- ==========================================================================
  { "catppuccin/nvim", enabled = false },
  { "rebelot/kanagawa.nvim", enabled = false },
  { "projekt0n/github-nvim-theme", enabled = false },
  { "craftzdog/solarized-osaka.nvim", enabled = false },
  { "onedarkpro.nvim", enabled = false },
  { "oxocarbon.nvim", enabled = false },
}
