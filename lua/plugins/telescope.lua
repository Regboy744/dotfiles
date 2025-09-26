return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Optional icons
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>ft", "<cmd>Telescope themes<cr>", desc = "Browse themes" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, -- Single line borders
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.npm/",
          "%.vscode/",
          "__pycache__/",
        },
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            ["<Esc>"] = require("telescope.actions").close,
          },
        },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              winblend = 10,
              width = 0.5,
              prompt = " ",
              results_height = 15,
              preview_cutoff = 120,
            }),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },

  {
    "andrew-george/telescope-themes",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("themes")
      -- Add keymap for themes
      vim.keymap.set("n", "<leader>ft", "<cmd>Telescope themes<cr>", { desc = "Browse themes" })
    end,
  },

  -- Optional: Better file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },

  -- Optional: Project management
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
    },
    config = function()
      require("telescope").load_extension("project")
    end,
  },
}
