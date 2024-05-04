if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0

  local api = vim.api
  api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "let &lines = max([5, &lines])"
    -- command = "set lines=max(3, 5)",
    -- command = "set lines= 20",
  })

  vim.g.firenvim_config.localSettings[".*"] = {
    selector = { "textarea", "CommentBox-container" },
  }
  -- local disable_plugins = {
  -- "hrsh7th/nvim-cmp",
  -- enabled = false,
  -- }

  -- Following can probably be removed when this is fixed
  -- https://github.com/hrsh7th/nvim-cmp/issues/1759
  -- local config = require("core.utils").load_config()
  -- require("lazy").setup(disable_plugins, config.lazy_nvim)
end
