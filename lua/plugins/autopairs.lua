return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        vue = { "string", "template_string" },
        java = false,
      },
      fast_wrap = {},
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = { "html", "javascript", "typescript", "vue", "svelte" },
    opts = {},
  },
}
