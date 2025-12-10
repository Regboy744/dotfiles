return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  -- For class="..." in template
                  { 'class="([^"]*)"', 1 },
                  -- For :class="'...'" dynamic classes
                  { ":class=\"'([^']*)'\"", 1 },
                  -- For :class="[...]" array syntax
                  { ':class="\\[([^\\]]*)\\]"', 1 },
                  -- For :class="{...}" object syntax
                  { ':class="\\{([^\\}]*)\\}"', 1 },
                },
              },
              validate = true,
              lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidScreen = "error",
                invalidVariant = "error",
                invalidConfigPath = "error",
                invalidTailwindDirective = "error",
                recommendedVariantOrder = "warning",
              },
            },
          },
        },
      },
    },
  },
}
