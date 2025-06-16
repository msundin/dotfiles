return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    -- Disable auto-selection
    opts.preselect = cmp.PreselectMode.None
    opts.completion.completeopt = "menu,menuone,noselect"

    -- Enter only confirms if you explicitly selected something
    opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })

    -- Optional: Use Tab/Shift-Tab to navigate and select
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        -- Keep LazyVim's snippet/AI behavior
        return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
      end
    end, { "i", "s" })

    opts.mapping["<S-Tab>"] = cmp.mapping.select_prev_item()

    return opts
  end,
}
