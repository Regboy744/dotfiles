-- File: ~/.config/nvim/lua/plugins/neotest-playwright.lua
-- This file configures neotest-playwright for LazyVim

return {
  -- Main neotest plugin configuration
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- Core dependencies that neotest needs
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- The Playwright adapter for neotest
      {
        "thenbe/neotest-playwright",
        dependencies = { "nvim-telescope/telescope.nvim" },
      },
    },

    -- Optional: Add keybindings for easier test running
    keys = {
      -- Run the test under cursor
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },

      -- Run all tests in current file
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run file tests",
      },

      -- Run all tests in project
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Run all tests",
      },

      -- Stop running tests
      {
        "<leader>ts",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop tests",
      },

      -- Show test output
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Show test output",
      },

      -- Toggle test summary panel
      {
        "<leader>tS",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary",
      },

      -- Debug nearest test (requires DAP setup)
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug nearest test",
      },

      -- Playwright specific commands
      {
        "<leader>tp",
        "<cmd>NeotestPlaywrightProject<cr>",
        desc = "Select Playwright project",
      },
      {
        "<leader>tr",
        "<cmd>NeotestPlaywrightRefresh<cr>",
        desc = "Refresh Playwright tests",
      },
    },

    config = function()
      -- Get neotest namespace for diagnostics
      local neotest_ns = vim.api.nvim_create_namespace("neotest")

      -- Configure virtual text for inline test results
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Show shorter messages inline
            local message = diagnostic.message:match("([^\n]+)\n?")
            return message and message:sub(1, 50) or diagnostic.message
          end,
        },
      }, neotest_ns)

      -- Main neotest setup
      require("neotest").setup({
        -- Configure adapters (test runners)
        adapters = {
          -- Playwright adapter configuration
          require("neotest-playwright").adapter({
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            },
          }),
        },

        -- General neotest configuration
        status = {
          enabled = true,
          signs = true, -- Show signs in sign column
          virtual_text = true, -- Show virtual text with test results
        },

        icons = {
          -- Test status icons (you can customize these)
          running = "⟳",
          passed = "✓",
          failed = "✗",
          skipped = "○",
          unknown = "?",
        },

        -- Floating window configuration
        floating = {
          border = "rounded",
          max_height = 0.8,
          max_width = 0.9,
        },

        -- Test discovery settings
        discovery = {
          enabled = true,
          concurrent = 1, -- Number of concurrent test discovery jobs
        },

        -- Running settings
        running = {
          concurrent = true, -- Run tests concurrently
        },

        -- Summary window settings
        summary = {
          animated = true, -- Animate the summary window
          follow = true, -- Follow current file in summary
          expand_errors = true, -- Auto-expand errors in summary
        },
      })
    end,
  },

  -- Optional: Add nvim-dap for debugging support
  {
    "mfussenegger/nvim-dap",
    optional = true,
    keys = {
      {
        "<leader>tD",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest Test",
      },
    },
  },

  -- Optional: Better test output display with trouble.nvim
  {
    "folke/trouble.nvim",
    optional = true,
    opts = function(_, opts)
      opts.modes = opts.modes or {}
      opts.modes.neotest = {
        mode = "neotest",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.4,
        },
      }
      return opts
    end,
  },
}

-- Additional configuration notes:
--
-- 1. PROJECT STRUCTURE EXAMPLE:
--    your-project/
--    ├── playwright.config.ts  (Playwright configuration)
--    ├── tests/
--    │   ├── example.spec.ts   (Your test files)
--    │   └── another.spec.ts
--    └── package.json
--
-- 2. PLAYWRIGHT CONFIG EXAMPLE (playwright.config.ts):
--    export default {
--      projects: [
--        { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
--        { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
--      ],
--    };
--
-- 3. TEST FILE EXAMPLE (tests/example.spec.ts):
--    import { test, expect } from '@playwright/test';
--
--    test('basic test', async ({ page }) => {
--      await page.goto('https://example.com');
--      await expect(page).toHaveTitle(/Example/);
--    });
--
-- 4. USAGE:
--    - Place cursor on a test and press <leader>tt to run it
--    - Press <leader>tf to run all tests in current file
--    - Press <leader>tS to see all tests in a summary panel
--    - Press <leader>to to see detailed test output
--
-- 5. TROUBLESHOOTING:
--    - Make sure you have Playwright installed: npm install -D @playwright/test
--    - Install browsers: npx playwright install
--    - Check that your playwright.config.ts is in project root
--    - Ensure TreeSitter TypeScript parser is installed: :TSInstall typescript
