return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          -- Use sidebar layout with preview in main window
          layout = {
            preset = "sidebar",
            preview = "main", -- Preview in main Neovim window (to the right)
          },
        },
      },
      win = {
        input = {
          keys = {
            -- Arrow key navigation in input
            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            -- Vim-style navigation
            h = "explorer_close",
            l = "confirm",
            j = "list_down",
            k = "list_up",

            -- Arrow key navigation (for ZMK arrow layer)
            ["<Left>"] = "explorer_close",
            ["<Right>"] = "confirm",
            ["<Down>"] = "list_down",
            ["<Up>"] = "list_up",

            -- Open in splits (visual mnemonics)
            ["<cr>"] = "confirm",
            ["<leader>|"] = "vsplit",
            ["<leader>-"] = "split",
            ["<leader>t>"] = "tab",

            -- View options
            ["<leader>p"] = "toggle_preview",
            ["<leader>h"] = "toggle_hidden",

            -- Directory navigation
            ["-"] = "explorer_up",

            -- Quit
            q = "close",
            ["<esc>"] = "close",
          },
        },
      },
    },
  },
}
