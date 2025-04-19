return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
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
            ["<a-d>"] = { "inspect", mode = { "n", "i" } },
            ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
            ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } }, -- Doesn't work due to yabai wiht Colemak
            ["<a-b>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<PageDown>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<PageUp>"] = { "preview_scroll_up", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
