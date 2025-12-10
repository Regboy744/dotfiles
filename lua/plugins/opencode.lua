return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- You already have snacks.nvim, so this just ensures it loads first
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- ===== CORE SETTINGS =====
      port = nil, -- Auto-detect opencode process (requires lsof)
      auto_reload = true, -- Auto-reload buffers when opencode edits them

      -- ===== COMPLETION SOURCES =====
      -- For blink.cmp integration (if you use it)
      auto_register_cmp_sources = { "opencode", "buffer" },

      -- ===== CONTEXTS =====
      -- These are placeholders you can use in prompts
      -- Default contexts are already great, but you can customize:
      contexts = {
        ["@buffer"] = function(context)
          return context:buffer()
        end,
        ["@buffers"] = function(context)
          return context:buffers()
        end,
        ["@cursor"] = function(context)
          return context:cursor_position()
        end,
        ["@selection"] = function(context)
          return context:visual_selection()
        end,
        ["@this"] = function(context)
          return context:this()
        end, -- Selection or cursor
        ["@visible"] = function(context)
          return context:visible_text()
        end,
        ["@diagnostics"] = function(context)
          return context:diagnostics()
        end,
        ["@quickfix"] = function(context)
          return context:quickfix()
        end,
        ["@diff"] = function(context)
          return context:git_diff()
        end,
        -- If you use grapple.nvim for file tagging:
        -- ["@grapple"] = function(context) return context:grapple_tags() end,
      },

      -- ===== PROMPTS =====
      -- Pre-defined prompts you can quickly select
      prompts = {
        ask = { prompt = "", ask = true, submit = true }, -- Custom question
        explain = { prompt = "Explain @this and its context", submit = true },
        optimize = { prompt = "Optimize @this for performance and readability", submit = true },
        document = { prompt = "Add comments documenting @this", submit = true },
        test = { prompt = "Add tests for @this", submit = true },
        review = { prompt = "Review @this for correctness and readability", submit = true },
        diagnostics = { prompt = "Explain @diagnostics", submit = true },
        fix = { prompt = "Fix @diagnostics", submit = true },
        diff = { prompt = "Review the following git diff for correctness and readability: @diff", submit = true },

        -- Custom prompts for Vue.js workflow
        vue_component = {
          prompt = "Review this Vue component using Composition API best practices: @this",
          submit = true,
        },
        tailwind_optimize = {
          prompt = "Optimize these TailwindCSS classes for better readability and maintainability: @this",
          submit = true,
        },
      },

      -- ===== COMMANDS =====
      commands = {
        ["session.new"] = "Start a new session",
        ["session.share"] = "Share the current session",
        ["session.interrupt"] = "Interrupt the current session",
        ["session.compact"] = "Compact the current session (reduce context size)",
        ["session.undo"] = "Undo the last action in the current session",
        ["session.redo"] = "Redo the last undone action in the current session",
        ["agent.cycle"] = "Cycle the selected agent",
      },

      -- ===== INPUT UI =====
      input = {
        prompt = "Ask opencode: ",
        icon = "󰚩 ",
        win = {
          title_pos = "left",
          relative = "cursor",
          row = -3, -- Shows 3 lines above cursor
          col = 0,
        },
      },

      -- ===== SELECT UI =====
      select = {
        prompt = "opencode: ",
        snacks = {
          preview = "preview",
          layout = {
            preset = "vscode",
            hidden = {},
          },
        },
      },

      -- ===== PERMISSIONS =====
      permissions = {
        enabled = true, -- Ask before opencode performs actions
        idle_delay_ms = 1000, -- Wait 1s after idle before asking
      },

      -- ===== PROVIDER (Terminal Integration) =====
      provider = {
        cmd = "opencode", -- Command to run
        enabled = "snacks", -- Use snacks.terminal
        snacks = {
          auto_close = true, -- Close terminal when opencode exits
          win = {
            position = "right", -- Terminal on right side
            enter = false, -- Don't focus terminal, stay in editor
            wo = {
              winbar = "", -- No window bar (opencode has its own footer)
            },
            bo = {
              filetype = "opencode_terminal", -- Custom filetype for targeting
            },
          },
        },
      },
    }
    -- Required for auto_reload to work
    vim.o.autoread = true
    -- ===== KEYMAPS =====
    -- Quick ask with context
    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode about this" })

    -- Select from all actions
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })

    -- Add to context (doesn't submit, just adds to prompt)
    vim.keymap.set({ "n", "x" }, "ga", function()
      require("opencode").prompt("@this")
    end, { desc = "Add to opencode" })

    -- Toggle opencode terminal
    vim.keymap.set({ "n", "t" }, "<C-S-.>", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    -- Scroll in opencode session
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "opencode half page up" })

    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "opencode half page down" })

    -- Since we're using Ctrl+a and Ctrl+x, remap increment/decrement
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
  end,
}
