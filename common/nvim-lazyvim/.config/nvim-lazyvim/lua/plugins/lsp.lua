return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a keymap
    keys[#keys + 1] = { "K", false }
    -- add a keymap
    keys[#keys + 1] = { "gh", vim.lsp.buf.hover, desc = "Goto Hover Documentation" }
    keys[#keys + 1] = { "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame" }
  end,
}
