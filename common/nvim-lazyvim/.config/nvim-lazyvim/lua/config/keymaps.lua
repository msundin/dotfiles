-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Wrap handling
map("n", "<leader>tw", ":ToggleWrap<CR>", { silent = true })
map("n", "<leader>tn", ":ToggleNumber<CR>", { silent = true })
map("n", "<leader>tc", ":ToggleColorColumn<CR>", { silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
-- qwerty
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Colmak-DH
map("n", "<C-m>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-i>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-n>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-e>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Buffer Navigation
map("n", "J", ":bprevious<CR>", { silent = true })
map("n", "K", ":bnext<CR>", { silent = true })

-- Jump List Navigation
map("n", "H", "<C-o>", { silent = true })
map("n", "L", "<C-i>", { silent = true })

-- Misc
map("n", "<leader>pf", ':lua print(vim.fn.expand("%:p"))<CR>', { desc = "[p]rint [f]iles" })

-- Key mapping to reload the current buffer
map("n", "<Leader>rl", ":e!<CR>", { silent = true })

-- Run applications
map("n", "<leader>rrk", "<cmd>KotlinRun<CR>", { desc = "Compile and run Kotlin code" })

-- Obsidian rename tag
map(
  "n",
  "<leader>ornt",
  '<cmd>lua rename_tag_in_vault(vim.fn.input("Old tag: "), vim.fn.input("New tag: "))<CR>',
  { silent = true, desc = "[O]bsidian [r]e[n]ame [t]ag everywhere in the vault" }
)

-- TODO: Move to scripts file

function RunKotlin()
  local filename = vim.fn.expand("%")
  local output = string.gsub(filename, "%.kt$", "")
  vim.cmd("!kotlinc " .. filename .. " -include-runtime -d " .. output .. ".jar && java -jar " .. output .. ".jar")
end

vim.api.nvim_create_user_command("KotlinRun", RunKotlin, {})

-- Define a global function to rename tags in all Markdown files, including YAML frontmatter
_G.rename_tag_in_vault = function(old_tag, new_tag)
  -- Enable UTF-8 pattern matching
  vim.o.encoding = "utf-8"
  -- utf8 = require 'utf8'

  -- Convert tags to lowercase to ensure matching is consistent
  old_tag = old_tag:lower()
  new_tag = new_tag:lower()

  -- Escape special pattern matching characters in the tag names
  local function escape_pattern(str)
    -- Escape magic characters: ( ) . % + - * ? [ ] ^ $
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
  end

  old_tag = escape_pattern(old_tag)
  new_tag = escape_pattern(new_tag)

  -- Get all markdown files in the vault
  local files = vim.fn.glob("**/*.md", false, true)

  for _, file in ipairs(files) do
    -- Read the entire file content at once with UTF-8 encoding
    local file_handle = io.open(file, "r")
    if file_handle then
      file_handle:setvbuf("full")
      local content = file_handle:read("*all")
      file_handle:close()

      -- Store original ending state
      local ends_with_newline = content:match("\n$")

      -- Split content into lines while preserving empty lines
      local lines = {}
      for line in content:gmatch("([^\n]*)\n?") do
        table.insert(lines, line)
      end

      -- Update the lines with tag replacements
      local in_frontmatter = false
      local frontmatter_count = 0

      for i, line in ipairs(lines) do
        -- Detect the start and end of YAML frontmatter
        if line:match("^%-%-%-%s*$") then
          in_frontmatter = not in_frontmatter
          frontmatter_count = frontmatter_count + 1
        end

        -- Replace tags in frontmatter under 'tags:' list
        if in_frontmatter and frontmatter_count <= 2 and line:match("^%s*%- ") then
          lines[i] = line:gsub("^(%s*%- )(" .. old_tag .. ")%s*$", "%1" .. new_tag)
        end

        -- Replace inline tags like #old_tag in the rest of the file
        if not in_frontmatter or frontmatter_count > 2 then
          -- Match whole tags, handling various boundary cases
          local function replace_tag(text)
            -- Replace tags followed by space, punctuation, or end of line
            text = text:gsub("#" .. old_tag .. "([%s%p])", "#" .. new_tag .. "%1")
            text = text:gsub("#" .. old_tag .. "$", "#" .. new_tag)

            -- Handle standalone tags
            if text == "#" .. old_tag then
              text = "#" .. new_tag
            end

            return text
          end

          lines[i] = replace_tag(lines[i])
        end
      end

      -- Write the updated content back to the file
      file_handle = io.open(file, "w")
      if file_handle then
        -- Join lines with newlines, respecting original ending
        local output = table.concat(lines, "\n")
        if ends_with_newline and not output:match("\n$") then
          output = output .. "\n"
        elseif not ends_with_newline and output:match("\n$") then
          output = output:sub(1, -2)
        end

        file_handle:write(output)
        file_handle:close()
      end
    end
  end

  print("Tag rename complete!")
end

-- Spellcheck but only for markdown
vim.api.nvim_create_augroup("Markdown", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "Markdown",
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en", "sv" }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "Markdown",
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.opt_local.spell = false
    end
  end,
})

-- Function to check if file is in special directory
local function is_in_special_dir(filepath)
  local special_dir = vim.fn.expand("~/obsidian-vaults")
  special_dir = vim.fn.fnamemodify(special_dir, ":p")
  filepath = vim.fn.fnamemodify(filepath, ":p")
  return string.sub(filepath, 1, #special_dir) == special_dir
end

-- Function to toggle between default wrap, smart wrap, and no wrap
vim.api.nvim_create_user_command("ToggleWrap", function()
  -- Get buffer-local wrap state
  local wrap_state = vim.b.wrap_state or 0

  -- For all directories: ensure sequence Default -> Smart -> No wrap
  if wrap_state == 0 then -- Currently Default
    wrap_state = 1 -- Go to Smart
  elseif wrap_state == 1 then -- Currently Smart
    wrap_state = 2 -- Go to No wrap
  elseif wrap_state == 2 then -- Currently No wrap
    wrap_state = 0 -- Back to Default
  end

  -- Save the new state back to buffer-local variable
  vim.b.wrap_state = wrap_state

  if wrap_state == 0 then -- Default wrap
    vim.wo.wrap = true
    vim.wo.linebreak = false
    vim.wo.breakindent = false
    vim.wo.showbreak = ""
    vim.cmd('echo "Default wrap ON"')
  elseif wrap_state == 1 then -- Smart wrap
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.wo.showbreak = "↪ "
    vim.cmd('echo "Smart wrap ON"')
  else -- No wrap (state 2)
    vim.wo.wrap = false
    vim.wo.linebreak = false
    vim.wo.breakindent = false
    vim.wo.showbreak = ""
    vim.cmd('echo "Wrap OFF"')
  end
end, {})

-- Function to cycle through number settings
vim.api.nvim_create_user_command("ToggleNumber", function()
  local number_state = vim.b.number_state or 0
  number_state = (number_state + 1) % 3

  if number_state == 0 then -- No numbers
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd('echo "Line numbers OFF"')
  elseif number_state == 1 then -- Absolute numbers
    vim.wo.number = true
    vim.wo.relativenumber = false
    vim.cmd('echo "Absolute line numbers"')
  else -- Relative numbers with current line number
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.cmd('echo "Relative line numbers"')
  end

  vim.b.number_state = number_state
end, {})

-- Function to toggle color column
vim.api.nvim_create_user_command("ToggleColorColumn", function()
  if vim.wo.colorcolumn == "80" then
    vim.wo.colorcolumn = ""
    vim.cmd('echo "Color column OFF"')
  else
    vim.wo.colorcolumn = "80"
    vim.cmd('echo "Color column ON"')
  end
end, {})

-- Create augroup
local defaultSettings = vim.api.nvim_create_augroup("DefaultSettings", { clear = true })

-- Function to apply settings
local function apply_settings(filepath)
  if is_in_special_dir(filepath) then
    -- Special directory settings (Smart wrap)
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.wo.showbreak = "↪ "
    vim.bo.textwidth = 0
    vim.bo.wrapmargin = 0
    vim.opt_local.formatoptions = ""
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.wo.colorcolumn = ""
    vim.b.wrap_state = 1
    vim.b.number_state = 2
  else
    -- Default settings for other files
    vim.wo.wrap = true
    vim.wo.linebreak = false
    vim.wo.breakindent = false
    vim.wo.showbreak = ""
    vim.bo.textwidth = 0
    vim.bo.wrapmargin = 0
    vim.opt_local.formatoptions = ""
    vim.wo.colorcolumn = ""
    vim.b.wrap_state = 0
    vim.b.number_state = 0
  end
end

-- Initialize default settings for all buffers
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWinEnter" }, {
  group = defaultSettings,
  pattern = "*",
  callback = function()
    local filepath = vim.fn.expand("%:p")
    vim.schedule(function()
      apply_settings(filepath)
    end)
  end,
})

-- Ensure format options stay cleared after FileType events
vim.api.nvim_create_autocmd("FileType", {
  group = defaultSettings,
  pattern = "*",
  callback = function()
    local filepath = vim.fn.expand("%:p")
    vim.schedule(function()
      if is_in_special_dir(filepath) then
        vim.opt_local.formatoptions = ""
      end
    end)
  end,
})
