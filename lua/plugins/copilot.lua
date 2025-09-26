return {
  "github/copilot.vim",
  config = function()
    -- Disable Copilot by default
    vim.g.copilot_enabled = false

    -- One-liner toggle
    vim.keymap.set("n", "<leader>cp", function()
      local cmd = vim.g.copilot_enabled and "disable" or "enable"
      vim.cmd("Copilot " .. cmd)
      vim.g.copilot_enabled = not vim.g.copilot_enabled
    end, { desc = "Toggle Copilot" })
  end,
}
