return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "K", false }, -- conflicts with `go buffer right` in Neovim with corne
          { "gh", vim.lsp.buf.hover, desc = "Goto Hover Documentation" },
          { "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame" },
        },
      },
    },
  },
}
