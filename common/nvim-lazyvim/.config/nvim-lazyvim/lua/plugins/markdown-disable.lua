return {
  -- Disable Copilot for markdown files
  {
    "zbirenbaum/copilot.lua",
    opts = function(_, opts)
      -- Override the filetypes settings to disable markdown
      opts.filetypes = opts.filetypes or {}
      opts.filetypes.markdown = false

      -- Also disable suggestions for markdown
      opts.suggestion = opts.suggestion or {}
      opts.suggestion.disabled_filetypes = opts.suggestion.disabled_filetypes or {}
      table.insert(opts.suggestion.disabled_filetypes, "markdown")
    end,
  },

  -- Use autocommands to disable Blink for markdown files
  {
    "nvim-lua/plenary.nvim", -- This is a common dependency, likely already loaded
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- Try to disable completion engines when entering markdown files
          local bufnr = vim.api.nvim_get_current_buf()

          -- Attempt to disable Blink functionality for this buffer
          if package.loaded["blink.cmp"] then
            -- Create an empty completion source for this buffer
            vim.b[bufnr].blink_cmp_disabled = true

            -- Try to detach any active sources
            pcall(function()
              require("blink.cmp").detach_sources(bufnr)
            end)
          end

          -- Also disable Copilot for this buffer
          if package.loaded["copilot"] then
            pcall(function()
              require("copilot.suggestion").accept_word = false
              require("copilot.suggestion").accept_line = false
              require("copilot.suggestion").auto_trigger = false
            end)
          end
        end,
      })
    end,
  },
}
