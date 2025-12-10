return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/home/junior/.local/share/fnm/node-versions/v22.16.0/installation/lib/node_modules/@vue/language-server",
                languages = { "vue" },
              },
            },
          },
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        },
        volar = {},
        html = {},
        cssls = {},
        eslint = {},
      },
    },
  },
}
