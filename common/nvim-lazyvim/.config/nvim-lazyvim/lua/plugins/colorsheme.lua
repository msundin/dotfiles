return {

  { "rmehri01/onenord.nvim" },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- {
  --   "AlexvZyl/nordic.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("nordic").load()
  --   end,
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-mocha", -- onenord, catppuccin-mocha, catppuccin-macchiato, catppuccin-frappe, catppuccin-latte
      colorscheme = "onenord",
      -- colorscheme = "nordic",
    },
  },
}
