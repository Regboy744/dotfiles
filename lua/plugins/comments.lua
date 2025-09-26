-- TypeScript-aware commenting plugin for better code commenting
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/ts-comments.nvim",
      opts = {
        lang = {
          vue = "<!-- %s -->",
          html = "<!-- %s -->",
          javascript = { "// %s", "/* %s */" },
          typescript = { "// %s", "/* %s */" },
          lua = "-- %s",
        },
      },
    },
  },
  config = function()
    require("Comment").setup()
  end,
}
