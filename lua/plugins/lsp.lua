return {
  -- ============================================================================
  -- MASON PACKAGE MANAGER
  -- Handles installation and management of language servers, formatters, and linters
  -- ============================================================================
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },

  -- ============================================================================
  -- NEOVIM LSP CONFIGURATION
  -- Main LSP setup with all language server configurations
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- ========================================================================
      -- JAVASCRIPT/TYPESCRIPT ECOSYSTEM
      -- ========================================================================

      -- ESLint Language Server
      -- Provides linting and auto-fixing for JavaScript/TypeScript
      lspconfig.eslint.setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        on_new_config = function(config, new_root_dir)
          config.settings.workspaceFolder = {
            uri = vim.uri_from_fname(new_root_dir),
            name = vim.fn.fnamemodify(new_root_dir, ":t"),
          }
        end,
      })

      -- Vue.js TypeScript Language Server (vtsls)
      -- Handles TypeScript/JavaScript with Vue.js support
      local mason_registry = require("mason-registry")
      local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"

      lspconfig.vtsls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_language_server_path,
                  languages = { "vue" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      })

      -- ========================================================================
      -- WEB DEVELOPMENT LANGUAGES
      -- ========================================================================

      -- HTML Language Server
      -- Provides HTML completions and validation
      lspconfig.html.setup({
        filetypes = { "html", "ejs" },
        capabilities = capabilities,
      })

      -- CSS Language Server
      -- Provides CSS completions, validation, and color decorators
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })

      -- Tailwind CSS Language Server
      -- Provides Tailwind CSS intellisense and completions
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
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
      })

      -- ========================================================================
      -- PROGRAMMING LANGUAGES
      -- ========================================================================

      -- Lua Language Server
      -- Provides Lua support (especially for Neovim config)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- Python Language Server (Pyright)
      -- Provides Python support with type checking
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      -- ========================================================================
      -- MARKUP/DATA LANGUAGES
      -- ========================================================================

      -- XML Language Server (LemMinX)
      -- Provides XML validation and completions
      lspconfig.lemminx.setup({
        capabilities = capabilities,
      })

      -- ========================================================================
      -- LSP KEYBINDINGS AND AUTOCOMMANDS
      -- Configure key mappings when LSP attaches to buffer
      -- ========================================================================
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- Standard LSP keybindings for all other language servers
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = ev.buf })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = ev.buf })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references", buffer = ev.buf })

          -- Common keybindings for all language servers
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", buffer = ev.buf })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = ev.buf })
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Display errors" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Display symbol info", buffer = ev.buf })
        end,
      })
    end,
  },
}
