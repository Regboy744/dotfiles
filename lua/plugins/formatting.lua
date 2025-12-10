return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- LazyVim's defaults (keep these)
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },

      -- Add your formatters
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      vue = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
