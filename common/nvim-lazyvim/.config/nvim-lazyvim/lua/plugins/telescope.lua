return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_height = 0.7,
            prompt_position = "bottom",
            mirror = false, -- Keep preview on top
          },
        },
      },
    })
  end,
}
