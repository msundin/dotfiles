return {

  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.enabled = function()
        return vim.bo.filetype ~= "markdown"
      end
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    opts = function(_, opts)
      opts.filetypes = vim.tbl_deep_extend("force", opts.filetypes or {}, {
        markdown = false,
      })
    end,
  },
}
