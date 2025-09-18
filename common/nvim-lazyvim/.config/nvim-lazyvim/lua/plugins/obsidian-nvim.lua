return {
  "obsidian-nvim/obsidian.nvim",
  -- event = "FileType markdown",
  -- cond = function()
  --   local path = vim.api.nvim_buf_get_name(0)
  --   local home = vim.fn.expand("~")
  --   return path:match(home .. "/obsidian%-vaults/")
  -- end,
  -- event = { "BufReadPre", "BufNewFile" },
  -- cond = function()
  --   local path = vim.api.nvim_buf_get_name(0) -- full path of the buffer
  --   local cwd = vim.fn.getcwd()
  --   local home = vim.fn.expand("~")
  --
  --   local in_vault_path = path:match(home .. "/obsidian%-vaults/")
  --   local in_vault_cwd = cwd:match(home .. "/obsidian%-vaults/personal") or cwd:match(home .. "/obsidian%-vaults/work")
  --
  --   return in_vault_path or in_vault_cwd
  -- end,
  -- cond = function()
  --   local cwd = vim.fn.getcwd()
  --   local home = vim.fn.expand("~")
  --   return cwd:match(home .. "/obsidian%-vaults/personal") ~= nil or cwd:match(home .. "/obsidian%-vaults/work") ~= nil
  -- end,
  -- -- event = {
  -- --   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  -- --   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  -- --   "BufReadPre " .. vim.fn.expand("~") .. "/obsidian-vaults/**",
  -- --   "BufNewFile " .. vim.fn.expand("~") .. "/obsidian-vaults/**",
  -- --   --   'BufReadPre ' .. vim.fn.expand '~' .. '/mattias/obsidian-vaults/personal/**',
  -- --   --   'BufNewFile ' .. vim.fn.expand '~' .. '/mattias/obsidian-vaults/personal/**',
  -- -- },
  -- event = "BufReadPre",
  -- cond = function()
  --   local path = vim.api.nvim_buf_get_name(0) -- full path of the buffer
  --   local home = vim.fn.expand("~")
  --   return path:match(home .. "/obsidian%-vaults/")
  -- end,
  -- event = function()
  --   local home = vim.fn.expand("~")
  --   return {
  --     "BufReadPre " .. home .. "/obsidian-vaults/**",
  --     "BufNewFile " .. home .. "/obsidian-vaults/**",
  --   }
  -- end,
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  -- event = "VeryLazy",
  -- ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   'BufReadPre '
  --     .. vim.fn.expand '~'
  --     .. '/mattias/obsidian-vaults/work/**',
  --   'BufNewFile ' .. vim.fn.expand '~' .. '/mattias/obsidian-vaults/work/**',
  --   'BufReadPre ' .. vim.fn.expand '~' .. '/mattias/obsidian-vaults/personal/**',
  --   'BufNewFile ' .. vim.fn.expand '~' .. '/mattias/obsidian-vaults/personal/**',
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  keys = {
    -- Paste image
    {
      "<leader>op",
      function()
        vim.cmd("Obsidian paste_img")
      end,
      desc = "Paste image",
    },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian-vaults/personal",
      },
      {
        name = "work",
        path = "~/obsidian-vaults/work",
      },
    },
    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "inbox",

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*".
    -- log_level = vim.log.levels.INFO,

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "notes/_periodic/_daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%y%m%d-%A",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%A, %-d %B %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "templates/daily-note-nvim",
      workdays_only = false,
    },

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = true,
      -- Enables completion using blink.cmp
      blink = false,
      min_chars = 2,
    },

    vim.keymap.set("n", "<leader>onn", "<cmd>ObsidianNew<CR>", { desc = "Obsidian new note" }),
    vim.keymap.set("n", "<leader>ont", "<cmd>ObsidianNewFromTemplate<CR>", { desc = "Obsidian new template note" }),
    vim.keymap.set("n", "<leader>ond", "<cmd>ObsidianToday<CR>", { desc = "Obsidian new daily note for today" }),
    vim.keymap.set("n", "<leader>onl", "<cmd>ObsidianLinkNew<CR>", { desc = "Obsidian new link" }),
    vim.keymap.set("n", "<leader>off", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian find file" }),
    vim.keymap.set(
      "n",
      "<leader>osg",
      "<cmd>ObsidianSearch<CR>",
      { desc = "Obsidian find in file and filename with grep" }
    ),
    vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Obsidian open note in app" }),
    vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "Obsidian tags" }),
    vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Obsidian links" }),
    vim.keymap.set("n", "<leader>obl", "<cmd>ObsidianBacklinks<CR>", { desc = "Obsidian backlinks" }),
    vim.keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<CR>", { desc = "Obsidian daily notes" }),
    -- vim.keymap.set(
    --   "n",
    --   "<leader>ov",
    --   "<cmd>ObsidianWorkspace<CR>",
    --   { desc = "Obsidian switch to other vault/workspace" }
    -- ),
    vim.keymap.set(
      "n",
      "<leader>ornf",
      "<cmd>ObsidianRename<CR>",
      { desc = "[O]bsidian [r]e[n]ame [f]ile e.g. hub name and all backlinks" }
    ),

    --------------
    -- obsidian --
    --------------
    --
    -- >>> op/ow/od # from shell, navigate to vault (optional)
    --
    -- # NEW NOTE
    -- >>> ))) <leader>onn
    -- >>> ))) # add tag, e.g. fact / blog / video / etc..
    -- >>> ))) # add hubs, e.g. "[[python]]", "[[machine-learning]]", etc...
    --
    -- # END OF DAY/WEEK REVIEW
    -- >>> or # review notes in inbox
    -- >>>
    -- >>> ))) <leader>ok # inside vim now, move to zettelkasten
    -- >>> ))) <leader>od # or delete
    -- >>>
    -- >>> og # organize saved notes from zettelkasten into notes/[tag] folders
    -- >>> ou # sync local with Notion
    --
    -- navigate to vault
    -- vim.keymap.set(
    --   "n",
    --   "<leader>op",
    --   ":cd ~/obsidian-vaults/personal/<cr>",
    --   { desc = "Obsidian switch to personal vault/workspace" }
    -- ),
    -- vim.keymap.set(
    --   "n",
    --   "<leader>ow",
    --   ":cd ~/obsidian-vaults/work/<cr>",
    --   { desc = "Obsidian switch to work vault/workspace" }
    -- ),
    --
    -- strip date from note title and replace dashes with spaces
    -- must have cursor on title
    -- vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
    --
    -- for review workflow
    -- move file in current buffer to zettelkasten folder
    vim.keymap.set("n", "<leader>ok", function()
      local currentdir = vim.loop.cwd()
      local filepath = vim.fn.expand("%:p")
      local targetdir = currentdir .. "/zettelkasten"
      local cmd = string.format("mv '%s' '%s'", filepath, targetdir)
      vim.fn.system(cmd)
      vim.cmd("bd")
    end, { noremap = true, silent = true, desc = "Obsidian move reviewed OK file to zettelkasten directory" }),
    vim.keymap.set(
      "n",
      "<leader>orm",
      ":!mv '%:p' .trash<cr>:bd<cr>",
      { desc = "Obsidian move reviewed NOK file to .trash directory" }
    ),
    -- vim.keymap.set('n', '<leader>otom', '<cmd>ObsidianTomorrow<CR>', { desc = 'Obsidian daily note for tomorrow' }),
    -- vim.keymap.set('n', '<leader>oyes', '<cmd>ObsidianYesterday<CR>', { desc = 'Obsidian daily note for yesterday' }),
    -- Where to put new notes. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "notes_subdir",

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Öa-ö0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return os.date("%y%m%d-%H%M") .. "_" .. suffix
      -- return tostring(os.time()) .. '-' .. suffix
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    -- Optional, customize how wiki links are formatted. You can set this to one of:
    --  * "use_alias_only", e.g. '[[Foo Bar]]'
    --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
    --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
    --  * "use_path_only", e.g. '[[foo-bar.md]]'
    -- Or you can set it to a function that takes a table of options and returns a string, like this:
    wiki_link_func = function(opts)
      return require("obsidian.util").wiki_link_id_prefix(opts)
    end,

    -- Optional, customize how markdown links are formatted.
    markdown_link_func = function(opts)
      return require("obsidian.util").markdown_link(opts)
    end,

    -- Either 'wiki' or 'markdown'.
    preferred_link_style = "wiki",

    -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
    ---@return string
    image_name_func = function()
      -- Prefix image names with timestamp.
      -- return string.format('%s-', os.time())
      return os.date("%y%m%d-%H%M_")
    end,

    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    disable_frontmatter = false,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = {
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
        date = os.date("%Y-%m-%d"),
        hub = "",
        hubs = {},
      }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    -- Optional, for templates (see below).
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      local os_name = vim.loop.os_uname().sysname

      if os_name == "Darwin" then
        -- This block will execute if the operating system is macOS
        vim.fn.jobstart({ "open", url }) -- Mac OS
      elseif os_name == "Linux" then
        -- This block will execute if the operating system is Linux
        vim.fn.jobstart({ "xdg-open", url }) -- linux
      else
        -- Optional: handle other operating systems if necessary
        print("Unsupported operating system")
      end
    end,

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'snacks.pick' or 'mini.pick'.
      name = "telescope.nvim",
      -- name = "fzf-lua",
      -- name = "snacks.pick",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
    },

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
    sort_by = "modified",
    sort_reversed = true,

    -- Set the maximum number of lines to read from notes on disk when performing certain searches.
    search_max_lines = 1000,

    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
    -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
    open_notes_in = "current",

    -- Optional, define your own callbacks to further customize behavior.
    callbacks = {
      -- Runs at the end of `require("obsidian").setup()`.
      ---@param client obsidian.Client
      post_setup = function(client) end,

      -- Runs anytime you enter the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      enter_note = function(client, note) end,

      -- Runs anytime you leave the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      leave_note = function(client, note) end,

      -- Runs right before writing the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      pre_write_note = function(client, note) end,

      -- Runs anytime the workspace is set/changed.
      ---@param client obsidian.Client
      ---@param workspace obsidian.Workspace
      post_set_workspace = function(client, workspace) end,
    },

    -- Optional, configure additional syntax highlighting / extmarks.
    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    ui = {
      enable = true, -- set to false to disable all additional syntax features
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Use bullet marks for non-checkbox lists.
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      -- Replace the above with this if you don't have a patched font:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },

    checkbox = {
      order = { " ", "x", ">", "~", "!" },
    },

    -- Specify how to handle attachments.
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "assets/images", -- This is the default
      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },

  -- {
  --   "saghen/blink.cmp",
  --   dependencies = { "saghen/blink.compat" },
  --   opts = {
  --     sources = {
  --       default = { "obsidian", "obsidian_new", "obsidian_tags" },
  --       providers = {
  --         obsidian = {
  --           name = "obsidian",
  --           module = "blink.compat.source",
  --         },
  --         obsidian_new = {
  --           name = "obsidian_new",
  --           module = "blink.compat.source",
  --         },
  --         obsidian_tags = {
  --           name = "obsidian_tags",
  --           module = "blink.compat.source",
  --         },
  --       },
  --     },
  --   },
  -- },
}
