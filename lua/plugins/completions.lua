return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
    version = "*",
    config = function(_, opts)
      local colors = {
        { "BlinkCmpKindText", "#a6adc8" },
        { "BlinkCmpKindMethod", "#f38ba8" },
        { "BlinkCmpKindFunction", "#89b4fa" },
        { "BlinkCmpKindConstructor", "#fab387" },
        { "BlinkCmpKindField", "#94e2d5" },
        { "BlinkCmpKindVariable", "#cba6f7" },
        { "BlinkCmpKindClass", "#f9e2af" },
        { "BlinkCmpKindInterface", "#89dceb" },
        { "BlinkCmpKindModule", "#a6e3a1" },
        { "BlinkCmpKindProperty", "#f2cdcd" },
        { "BlinkCmpKindKeyword", "#cba6f7" },
        { "BlinkCmpKindSnippet", "#a6e3a1" },
        { "BlinkCmpKindFile", "#89dceb" },
        { "BlinkCmpKindFolder", "#94e2d5" },
      }

      for _, color in ipairs(colors) do
        vim.api.nvim_set_hl(0, color[1], { fg = color[2] })
      end
      require("luasnip.loaders.from_vscode").lazy_load()

      require("blink.cmp").setup(opts)
    end,
    opts = {
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      -- ... your existing keymap and appearance config ...
      keymap = {
        preset = "default",
        ["<Esc>"] = { "hide", "hide_documentation", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets" },
        min_keyword_length = 2,
        -- providers = {
        --   lsp = {
        --     min_keyword_length = 1,
        --     score_offset = 100,
        --   },
        --   snippets = {
        --     min_keyword_length = 0,
        --     score_offset = -100,
        --   },
        --   path = {
        --     min_keyword_length = 2,
        --   },
        -- },
      },
      -- fuzzy = {
      --   sorts = {
      --     -- Balanced: Strong fuzzy matches override kind priority
      --     function(a, b)
      --       local kind_priority = {
      --         [5] = 1,
      --         [6] = 2,
      --         [3] = 3,
      --         [2] = 4,
      --         [4] = 5,
      --         [10] = 6,
      --         [7] = 7,
      --         [8] = 8,
      --         [9] = 9,
      --         [14] = 10,
      --         [15] = 15,
      --         [1] = 20,
      --       }
      --
      --       local a_priority = kind_priority[a.kind] or 99
      --       local b_priority = kind_priority[b.kind] or 99
      --       local score_a = a.score or 0
      --       local score_b = b.score or 0
      --
      --       -- Exact or very strong matches override kind priority
      --       if score_a >= 80 or score_b >= 80 then
      --         return score_a > score_b
      --       end
      --
      --       -- Large score difference overrides kind priority
      --       local score_diff = math.abs(score_a - score_b)
      --       if score_diff > 20 then
      --         return score_a > score_b
      --       end
      --
      --       -- Use kind priority for similar scores
      --       if a_priority ~= b_priority then
      --         return a_priority < b_priority
      --       end
      --
      --       return score_a > score_b
      --     end,
      --     "sort_text",
      --     "label",
      --   },
      --   use_frecency = true,
      --   use_proximity = true,
      -- },
      fuzzy = {
        use_frecency = true,
        use_proximity = true,
      },
      -- ... rest of your completion config ...
      completion = {
        trigger = {
          prefetch_on_insert = true,
          show_on_keyword = true,
          show_on_backspace = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          treesitter_highlighting = true,
          window = {
            border = "rounded",
          },
        },
        menu = {
          border = "rounded",
          draw = {
            columns = { { "kind_icon", "label", gap = 1 }, { "kind" } },
            components = {
              kind_icon = {
                ellipsis = false,
                width = { max = 2 },
                text = function(ctx)
                  return ctx.kind_icon .. " "
                end,
              },
              label = {
                width = { fill = true, max = 50 },
                text = function(ctx)
                  return ctx.label .. ctx.label_detail
                end,
              },
              kind = {
                width = { max = 12 },
                text = function(ctx)
                  return ctx.kind
                end,
              },
            },
          },
        },
        ghost_text = { enabled = false },
      },
    },
    opts_extend = { "sources.default" },
  },
}
