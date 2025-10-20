return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      width = 35,
      position = "left",

      preview = {
        enabled = true,
        width = 0.5,
        auto_preview = true,
      },

      keys = {
        -- Vim-style navigation (for when on base layer)
        h = "close_directory",
        l = "open_directory_or_file", -- You like opening files with l ✅
        j = "next",
        k = "prev",

        -- Arrow key navigation (for when on arrow layer)
        ["<left>"] = "close_directory",
        ["<right>"] = "open_directory_or_file",
        ["<down>"] = "next",
        ["<up>"] = "prev",

        -- Open actions
        ["<cr>"] = "open",
        ["<c-|>"] = "open_vsplit", -- Visual mnemonic ✅
        ["<c-->"] = "open_split", -- Visual mnemonic ✅
        ["<c-t>"] = "open_tab",

        -- File operations
        a = "create",
        d = "delete",
        r = "rename",
        y = "copy",
        x = "cut",
        p = "paste",

        -- View options
        ["<c-p>"] = "toggle_preview",
        ["<c-h>"] = "toggle_hidden",

        -- Directory navigation
        ["~"] = "cd_home",
        ["-"] = "cd_parent",
        ["."] = "cd_cwd",

        -- Quit
        q = "close",
        ["<esc>"] = "close",
      },

      auto_close = true,
      follow_file = true,
    },
  },
}
