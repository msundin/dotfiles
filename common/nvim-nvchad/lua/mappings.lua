require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree"})
map("n", "<leader>k", ":bn<CR>", { desc = "Move next buffer" })
map("n", "<leader>j", ":bp<CR>", { desc = "Move previous buffer" })
map("n", "<CR>", "<CR><Cmd>cclose<CR>", { desc = "Close suggestion window after selection" })
-- nomap("n", "gd")
-- nomap("n", "gr")
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP Telescope pop-up instead of new window", noremap = true })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP Telescope pop-up instead of new window", noremap = true })

map("i", ">", ">gv", { desc = "indent" })

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})
  augroup END
]]

--     ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
--     ["<leader>k"] = { ":bn<CR>", "Next buffer" },
--     ["<leader>j"] = { ":bp<CR>", "Previous buffer" },
--
--     -- other mappings
--     [";"] = { ":", "enter command mode", opts = { nowait = true } },
--     --  format with conform
--     ["<leader>fm"] = {
--       function()
--         require("conform").format()
--       end,
--       "formatting",
--     },
--     ["<CR>"] = { "<CR><Cmd>cclose<CR>", "Close suggestion window after selection" },
--     ["gd"] = { "<cmd>Telescope lsp_references<CR>", "Use Telescope pop-up instead of new window" },
--     ["gr"] = { "<cmd>Telescope lsp_references<CR>", "Use Telescope pop-up instead of new window" },
--   },
--   v = {
--     -- my own mappings
--     ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
--
--     -- other mappings
--     [">"] = { ">gv", "indent" },
--   },
-- }

-- more keybinds!

