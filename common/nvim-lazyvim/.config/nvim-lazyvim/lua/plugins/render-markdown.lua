return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    heading = {
      -- Turn on / off heading icon & background rendering.
      enabled = false,
    },
    bullet = {
      -- Turn on / off list bullet rendering
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      -- Padding to add to the left of bullet point.
      -- Output is evaluated depending on the type.
      -- | function | `value(context)` |
      -- | integer  | `value`          |
      left_pad = 0,
      -- Padding to add to the right of bullet point.
      -- Output is evaluated using the same logic as 'left_pad'.
      right_pad = 0,
      -- Highlight for the bullet icon.
      -- Output is evaluated using the same logic as 'icons'.
      highlight = "RenderMarkdownBullet",
      -- Highlight for item associated with the bullet point.
      -- Output is evaluated using the same logic as 'icons'.
      scope_highlight = {},
      -- Priority to assign to scope highlight.
      scope_priority = nil,
    },
    checkbox = {
      right_pad = 2,
      unchecked = {
        -- Replaces '[ ]' of 'task_list_marker_unchecked'.
        icon = "󰄱 ",
        -- Highlight for the unchecked icon.
        highlight = "RenderMarkdownTodo",
        -- Highlight for item associated with unchecked checkbox.
        scope_highlight = nil,
      },
      checked = {
        -- Replaces '[x]' of 'task_list_marker_checked'.
        icon = " ",
        -- Highlight for the checked icon.
        highlight = "RenderMarkdownDone",
        -- Highlight for item associated with checked checkbox.
        scope_highlight = nil,
      },
      custom = {
        -- [" "] = { char = "󰄱", hl_group = "obsidiantodo" },
        -- ["~"] = { char = "󰰱", hl_group = "obsidiantilde" },
        -- ["!"] = { char = "", hl_group = "obsidianimportant" },
        -- [">"] = { char = "", hl_group = "obsidianrightarrow" },
        -- ["x"] = { char = "", hl_group = "obsidiandone" },
        important = {
          raw = "[!]",
          rendered = " ",
          highlight = "RenderMarkdownImportant",
          scope_highlight = nil,
        },
        cancelled = { raw = "[-]", rendered = "󰬟 ", highlight = "RenderMarkdownCancelled", scope_highlight = nil },
        inProgress = { raw = "[/]", rendered = " ", highlight = "RenderMarkdownInProgress", scope_highlight = nil },
        postponed = { raw = "[>]", rendered = "󰥔 ", highlight = "RenderMarkdownPostponed", scope_highlight = nil },
        question = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownQuestion", scope_highlight = nil },
      },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Define highlight groups
    vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = "#88C0D0" })
    vim.api.nvim_set_hl(0, "RenderMarkdownDone", { fg = "#A3BE8C" })
    vim.api.nvim_set_hl(0, "RenderMarkdownImportant", { fg = "#D08F70" })
    vim.api.nvim_set_hl(0, "RenderMarkdownCancelled", { fg = "#646A76" })
    vim.api.nvim_set_hl(0, "RenderMarkdownInProgress", { fg = "#88C0D0" })
    vim.api.nvim_set_hl(0, "RenderMarkdownPostponed", { fg = "#81A1C1" })
    vim.api.nvim_set_hl(0, "RenderMarkdownQuestion", { fg = "#B988B0" })
  end,
}
