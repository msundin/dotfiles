return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          auto_close = true,
          follow = true,
        },
      },
      -- Global win config applies to explorer too
      win = {
        input = {
          keys = {
            -- Arrow key navigation in picker input
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

            -- Open in splits
            ["<cr>"] = "confirm",
            ["<c-|>"] = "confirm_vsplit",
            ["<c-->"] = "confirm_split",
            ["<c-t>"] = "confirm_tab",

            -- File operations
            a = "explorer_add",
            d = "explorer_del",
            r = "explorer_rename",
            y = "explorer_copy",
            x = "explorer_cut",
            p = "explorer_paste",

            -- View options
            ["<c-p>"] = "preview",
            ["<c-h>"] = "explorer_hidden",

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
