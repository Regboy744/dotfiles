return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        -- theme = "dracula",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- Single statusline for all windows (cleaner look)
        refresh = {
          statusline = 100, -- Fast refresh for real-time updates
        },
      },
      sections = {
        -- Left side
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 3) -- Show only first 3 characters (NOR, INS, VIS)
            end,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = "#ff79c6" }, -- Pink color for git branch
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            diff_color = {
              added = { fg = "#50fa7b" }, -- Green
              modified = { fg = "#f1fa8c" }, -- Yellow
              removed = { fg = "#ff5555" }, -- Red
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 1, -- Relative path (perfect for web projects)
            shorting_target = 40,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
              newfile = "[New] ",
            },
          },
          {
            "diagnostics",
            sources = { "nvim_lsp", "nvim_diagnostic" },
            sections = { "error", "warn", "info", "hint" },
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰌶 ",
            },
            diagnostics_color = {
              error = { fg = "#ff5555" },
              warn = { fg = "#ffb86c" },
              info = { fg = "#8be9fd" },
              hint = { fg = "#50fa7b" },
            },
            update_in_insert = false, -- Don't update while typing
          },
        },
        -- Right side
        lualine_x = {
          {
            -- Show LSP server status
            function()
              local clients = vim.lsp.get_active_clients({ bufnr = 0 })
              if #clients == 0 then
                return "No LSP"
              end
              local client_names = {}
              for _, client in ipairs(clients) do
                table.insert(client_names, client.name)
              end
              return " " .. table.concat(client_names, ", ")
            end,
            color = { fg = "#bd93f9" }, -- Purple color
          },
          {
            "filesize",
            fmt = function(str)
              -- Only show if file is larger than 1KB
              local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
              if size > 1024 then
                return str
              end
              return ""
            end,
          },
        },
        lualine_y = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            icon = { align = "right" },
          },
          {
            "encoding",
            fmt = function(str)
              -- Only show if not UTF-8
              return str ~= "utf-8" and str or ""
            end,
          },
        },
        lualine_z = {
          { "progress" },
          { "location" },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = { modified = " ●", readonly = " " },
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      -- Extensions for better integration
      extensions = {
        "nvim-tree",
        "toggleterm",
        "quickfix",
      },
    })
  end,
}
