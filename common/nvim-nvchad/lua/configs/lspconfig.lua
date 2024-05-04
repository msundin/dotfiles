-- EXAMPLE 
local nvchad_on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", 'pyright' }

local function on_attach(client, bufnr)
    -- Call the original on_attach from NVChad
    nvchad_on_attach(client, bufnr)

    -- Clear any existing 'gd' and 'gr' mappings in this buffer to avoid conflicts
    vim.api.nvim_buf_del_keymap(bufnr, 'n', 'gd')
    vim.api.nvim_buf_del_keymap(bufnr, 'n', 'gr')

    -- Set new 'gd' and 'gr' mappings
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { desc = "Use Telescope pop-up instead of new window", noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', { desc = "Use Telescope pop-up instead of new window", noremap = true, silent = true })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
