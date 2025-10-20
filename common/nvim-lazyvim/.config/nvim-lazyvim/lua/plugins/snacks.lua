return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      layout = "default",
      sources = {
        files = {
          hidden = false,
        },
      },
      matcher = {
        frecency = true, -- frecency bonus
        -- history_bonus = true, -- give more weight to chronological order
        -- sort_empty = true,
      },
      win = {
        -- input window
        input = {
          keys = {
            -- Replace Alt with Leader (avoid Aerospace WM conflicts)
            ["<leader>d"] = { "inspect", mode = { "n", "i" } },
            ["<leader>f"] = { "toggle_follow", mode = { "i", "n" } },
            ["<leader>h"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<leader>i"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<leader>m"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<leader>p"] = { "toggle_preview", mode = { "i", "n" } },
            ["<leader>w"] = { "cycle_win", mode = { "i", "n" } },
            ["<leader>."] = { "toggle_hidden", mode = { "i", "n" } }, -- Yazi-like
            ["<PageDown>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<PageUp>"] = { "preview_scroll_up", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
