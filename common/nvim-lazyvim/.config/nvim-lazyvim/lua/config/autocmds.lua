-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Spellcheck but only for markdown
vim.api.nvim_create_augroup("Markdown", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "Markdown",
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en", "sv" }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "Markdown",
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.opt_local.spell = false
    end
  end,
})
