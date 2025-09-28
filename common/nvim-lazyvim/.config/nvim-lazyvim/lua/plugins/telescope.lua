return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          flex = {
            flip_columns = 120, -- Switch to horizontal layout on wider screens
            flip_lines = 40, -- Switch based on height
          },
          vertical = {
            preview_height = 0.7,
            prompt_position = "bottom",
            mirror = false,
            preview_cutoff = 10,
            width = 0.9,
            height = 0.9,
          },
          horizontal = {
            preview_width = 0.6,
            preview_cutoff = 10,
            width = 0.9,
            height = 0.9,
          },
        },
        -- Alternative: force preview to always show
        preview = {
          hide_on_startup = false,
        },
        -- Ensure proper window sizing
        winblend = 0,
        wrap_results = true,
        scroll_strategy = "limit",
      },
    })
  end,
}
