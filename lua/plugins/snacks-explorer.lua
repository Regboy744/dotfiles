return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true },
    picker = {
      sources = {
        explorer = {
          sort = {
            fields = { "severity", "file", "lnum" },
          },
          tree = true,
          follow_file = true,

          -- Layout with custom width
          layout = {
            preset = "sidebar",
            layout = {
              width = 28, -- 35 columns wide
              min_width = 25, -- Minimum 25 columns
              position = "left", -- Left side
            },
          },

          formatters = {
            file = { filename_only = true },
          },
        },
      },
    },
  },
}
