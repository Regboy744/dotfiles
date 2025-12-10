return {
  "folke/which-key.nvim",
  dependencies = { "nvim-mini/mini.icons" }, -- Updated name
  config = function()
    require("which-key").setup()
  end,
}
