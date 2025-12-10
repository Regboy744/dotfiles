return {
  -- add blink.compat
  {
    "saghen/blink.compat",
    -- use v2.* for blink.cmp v1.*
    version = "2.*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      -- add source
      { "dmitmel/cmp-digraphs" },
    },
    opts = {
      -- ═══════════════════════════════════════════════════════════
      -- 🎯 ENABLED SETTINGS
      -- ═══════════════════════════════════════════════════════════
      -- FIX: just remove it in the future
      -- enabled = function()
      --   return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
      -- end,

      -- ═══════════════════════════════════════════════════════════
      -- 🚫 CMDLINE SETTINGS
      -- ═══════════════════════════════════════════════════════════
      cmdline = {
        enabled = true,
      },

      -- ═══════════════════════════════════════════════════════════
      -- ⌨️ KEYMAP SETTINGS
      -- ═══════════════════════════════════════════════════════════
      keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },
        ["<CR>"] = { "accept", "fallback" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      -- ═══════════════════════════════════════════════════════════
      -- 🎨 APPEARANCE SETTINGS
      -- ═══════════════════════════════════════════════════════════
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      -- ═══════════════════════════════════════════════════════════
      -- ✨ COMPLETION SETTINGS
      -- ═══════════════════════════════════════════════════════════
      completion = {
        keyword = {
          range = "prefix",
        },

        accept = {
          auto_brackets = {
            enabled = false,
          },
        },

        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },

        -- 🎨 MENU APPEARANCE
        menu = {
          auto_show = function(ctx)
            -- Don't show after closing parenthesis
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            if col == 0 then
              return true
            end
            local char_before = line:sub(col, col)

            if char_before == ")" or char_before == "}" or char_before == "]" then
              return false
            end

            return true
          end,
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          scrollbar = true,
          direction_priority = { "s", "n" },

          draw = {
            columns = {
              { "kind_icon", "label", gap = 1 },
              { "kind" },
            },

            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },

        -- 📚 DOCUMENTATION WINDOW
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 0,
          treesitter_highlighting = true,
          window = {
            border = "rounded",
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:Visual,Search:None",
            direction_priority = {
              menu_north = { "e", "w", "n", "s" },
              menu_south = { "e", "w", "s", "n" },
            },
            scrollbar = true,
          },
        },

        -- 👻 GHOST TEXT
        ghost_text = {
          enabled = false,
        },
      },

      -- ═══════════════════════════════════════════════════════════
      -- 📝 SNIPPETS
      -- ═══════════════════════════════════════════════════════════
      snippets = {
        preset = "default",
      },

      -- ═══════════════════════════════════════════════════════════
      -- ✍️ SIGNATURE HELP
      -- ═══════════════════════════════════════════════════════════
      signature = {
        enabled = false,
        window = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        },
      },

      -- ═══════════════════════════════════════════════════════════
      -- 📦 SOURCES
      -- ═══════════════════════════════════════════════════════════
      sources = {
        -- remember to enable your providers here
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          -- create provider
          digraphs = {
            -- IMPORTANT: use the same name as you would for nvim-cmp
            name = "digraphs",
            module = "blink.compat.source",

            -- all blink.cmp source config options work as normal:
            score_offset = -3,

            -- this table is passed directly to the proxied completion source
            -- as the `option` field in nvim-cmp's source config
            opts = {
              -- this is an option from cmp-digraphs
              cache_digraphs_on_start = true,
            },
          },
        },
      },
    },
  },
}
