-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- using lazy.nvim

  -- see debug lua config file
  -- { 'Mgenuit/nvim-dap-kotlin', config = function() end },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      label = {
        -- uppercase = false,
        -- ignore = 'qzxybgvjmk',
      },
    },

    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },

  {
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local Path = require 'plenary.path'
      require('session_manager').setup {
        sessions_dir = Path:new(vim.fn.stdpath 'data', 'sessions'), -- The directory where session files are stored.
        path_replacer = '__', -- Replace path separators in the session filename.
        colon_replacer = '++', -- Replace colons in the session filename.
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
        autosave_last_session = true,
        autosave_only_in_session = false,
      }
      vim.api.nvim_create_user_command('SaveSession', function()
        require('session_manager').save_current_session()
      end, { desc = 'Save current session' })

      vim.api.nvim_create_user_command('LoadSession', function()
        require('session_manager').load_last_session()
      end, { desc = 'Load last session' })
      vim.api.nvim_set_keymap('n', '<Leader>mss', ':SaveSession<CR>', { desc = '[m]anaging [s]essions [s]ave', noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>msl', ':LoadSession<CR>', { desc = '[m]anaging [s]essions [l]oad', noremap = true, silent = true })
    end,
  },

  {
    'tyru/open-browser.vim',
    config = function()
      -- Set up a key mapping to open URLs under the cursor with <Leader> + Enter
      vim.api.nvim_set_keymap('n', '<Leader><CR>', '<Plug>(openbrowser-smart-search)', {})
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = { theme = 'onenord' },

        sections = {
          lualine_c = {
            { 'filename', path = 0 }, -- 0 = Just filename, 1 = Relative path, 2 = Absolute path
          },
        },
        inactive_sections = {
          lualine_c = {
            { 'filename', path = 0 },
          },
        },
      }
    end,
  },

  {
    'akinsho/bufferline.nvim',
    -- version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup {}
    end,
  },

  {
    'tpope/vim-fugitive',
  },

  {
    -- amongst your other plugins
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      opts = {--[[ things you want to change go here]]
        direction = 'float',
      },
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        timeout = 3000, -- Seems to be in addtion to 3000 ms default, so e.g. 2000 here gives 3000 ms total
      }
      vim.notify = require 'notify' -- Set notify as the default notification handler
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    enabled = true,
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        messages = {
          enabled = true, -- enable messages feature in noice
          view = 'notify', -- use notify for message view
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-s>'] = { 'actions.select', opts = { vertical = false, horizontal = true }, desc = 'Open the entry in a horizontal split' },
          ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a veritcal split' },
          ['<C-h>'] = false,
          ['<M-h>'] = 'actions.select_split',
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      -- vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '-', require('oil').toggle_float)
    end,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
    },
    config = true,
  },

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --   }
  -- },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      -- vim.keymap.set('n', '<C-e>', function()
      --   toggle_telescope(harpoon:list())
      -- end, { desc = 'Open harpoon window' })

      vim.keymap.set('n', '<leader>i', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<leader>b', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '1', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '2', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '3', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '4', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '5', function()
        harpoon:list():select(5)
      end)
      vim.keymap.set('n', '6', function()
        harpoon:list():select(6)
      end)
      vim.keymap.set('n', '7', function()
        harpoon:list():select(7)
      end)
      vim.keymap.set('n', '8', function()
        harpoon:list():select(8)
      end)
      vim.keymap.set('n', '9', function()
        harpoon:list():select(9)
      end)
      vim.keymap.set('n', '0', function()
        harpoon:list():select(0)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>e', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<leader>n', function()
        harpoon:list():next()
      end)
    end,
  },

  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = false,
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
    --     .. '/mattias/nextcloud/obsidian-vaults/work/**',
    --   'BufNewFile ' .. vim.fn.expand '~' .. '/mattias/nextcloud/obsidian-vaults/work/**',
    --   'BufReadPre ' .. vim.fn.expand '~' .. '/mattias/nextcloud/obsidian-vaults/personal/**',
    --   'BufNewFile ' .. vim.fn.expand '~' .. '/mattias/nextcloud/obsidian-vaults/personal/**',
    -- },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/nextcloud/obsidian-vaults/personal',
        },
        {
          name = 'work',
          path = '~/nextcloud/obsidian-vaults/work',
        },
      },
      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = 'inbox',

      -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
      -- levels defined by "vim.log.levels.*".
      -- log_level = vim.log.levels.INFO,

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'notes/dailies',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%y%m%d-%A',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%A, %-d %B %Y',
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = 'templates/daily-note-nvim',
      },

      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
      -- way then set 'mappings = {}'.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ['<leader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      vim.keymap.set('n', '<leader>onn', '<cmd>ObsidianNew<CR>', { desc = 'Obsidian new note' }),
      vim.keymap.set('n', '<leader>ont', '<cmd>ObsidianTemplate<CR>', { desc = 'Obsidian new template note' }),
      vim.keymap.set('n', '<leader>ond', '<cmd>ObsidianToday<CR>', { desc = 'Obsidian new daily note for today' }),
      vim.keymap.set('n', '<leader>off', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Obsidian find file' }),
      vim.keymap.set('n', '<leader>ofg', '<cmd>ObsidianSearch<CR>', { desc = 'Obsidian find in file and filename with grep' }),
      vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianOpen<CR>', { desc = 'Obsidian open note in app' }),
      vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianTags<CR>', { desc = 'Obsidian tags' }),
      vim.keymap.set('n', '<leader>ol', '<cmd>ObsidianLinks<CR>', { desc = 'Obsidian links' }),
      vim.keymap.set('n', '<leader>obl', '<cmd>ObsidianBacklinks<CR>', { desc = 'Obsidian backlinks' }),
      vim.keymap.set('n', '<leader>od', '<cmd>ObsidianDailies<CR>', { desc = 'Obsidian daily notes' }),
      vim.keymap.set('n', '<leader>ov', '<cmd>ObsidianWorkspace<CR>', { desc = 'Obsidian switch to other vault/workspace' }),
      vim.keymap.set('n', '<leader>ornf', '<cmd>ObsidianRename<CR>', { desc = '[O]bsidian [r]e[n]ame [f]ile e.g. hub name and all backlinks' }),

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
      vim.keymap.set('n', '<leader>op', ':cd ~/nextcloud/obsidian-vaults/personal/<cr>', { desc = 'Obsidian switch to personal vault/workspace' }),
      vim.keymap.set('n', '<leader>ow', ':cd ~/nextcloud/obsidian-vaults/work/<cr>', { desc = 'Obsidian switch to work vault/workspace' }),
      --
      -- strip date from note title and replace dashes with spaces
      -- must have cursor on title
      -- vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
      --
      -- for review workflow
      -- move file in current buffer to zettelkasten folder
      vim.keymap.set('n', '<leader>ok', function()
        local currentdir = vim.loop.cwd()
        local filepath = vim.fn.expand '%:p'
        local targetdir = currentdir .. '/zettelkasten'
        local cmd = string.format("mv '%s' '%s'", filepath, targetdir)
        vim.fn.system(cmd)
        vim.cmd 'bd'
      end, { noremap = true, silent = true, desc = 'Obsidian move reviewed OK file to zettelkasten directory' }),
      vim.keymap.set('n', '<leader>orm', ":!mv '%:p' .trash<cr>:bd<cr>", { desc = 'Obsidian move reviewed NOK file to .trash directory' }),
      -- vim.keymap.set('n', '<leader>otom', '<cmd>ObsidianTomorrow<CR>', { desc = 'Obsidian daily note for tomorrow' }),
      -- vim.keymap.set('n', '<leader>oyes', '<cmd>ObsidianYesterday<CR>', { desc = 'Obsidian daily note for yesterday' }),
      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = 'notes_subdir',

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Öa-ö0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return os.date '%y%m%d-%H%M' .. '_' .. suffix
        -- return tostring(os.time()) .. '-' .. suffix
      end,

      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
      ---@return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix '.md'
      end,

      -- Optional, customize how wiki links are formatted. You can set this to one of:
      --  * "use_alias_only", e.g. '[[Foo Bar]]'
      --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      --  * "use_path_only", e.g. '[[foo-bar.md]]'
      -- Or you can set it to a function that takes a table of options and returns a string, like this:
      wiki_link_func = function(opts)
        return require('obsidian.util').wiki_link_id_prefix(opts)
      end,

      -- Optional, customize how markdown links are formatted.
      markdown_link_func = function(opts)
        return require('obsidian.util').markdown_link(opts)
      end,

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = 'wiki',

      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      image_name_func = function()
        -- Prefix image names with timestamp.
        -- return string.format('%s-', os.time())
        return os.date '%y%m%d-%H%M_'
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
          date = os.date '%Y-%m-%d',
          hub = '',
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
        folder = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        local os_name = vim.loop.os_uname().sysname

        if os_name == 'Darwin' then
          -- This block will execute if the operating system is macOS
          vim.fn.jobstart { 'open', url } -- Mac OS
        elseif os_name == 'Linux' then
          -- This block will execute if the operating system is Linux
          vim.fn.jobstart { 'xdg-open', url } -- linux
        else
          -- Optional: handle other operating systems if necessary
          print 'Unsupported operating system'
        end
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = false,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = 'telescope.nvim',
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
          -- Create a new note from your query.
          new = '<C-x>',
          -- Insert a link to the selected note.
          insert_link = '<C-l>',
        },
      },

      -- Optional, sort search results by "path", "modified", "accessed", or "created".
      -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
      -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
      sort_by = 'modified',
      sort_reversed = true,

      -- Set the maximum number of lines to read from notes on disk when performing certain searches.
      search_max_lines = 1000,

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
      -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
      open_notes_in = 'current',

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
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
          ['x'] = { char = '', hl_group = 'ObsidianDone' },
          ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
          ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
          ['!'] = { char = '', hl_group = 'ObsidianImportant' },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = '•', hl_group = 'ObsidianBullet' },
        external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = 'ObsidianRefText' },
        highlight_text = { hl_group = 'ObsidianHighlightText' },
        tags = { hl_group = 'ObsidianTag' },
        block_ids = { hl_group = 'ObsidianBlockID' },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = '#f78c6c' },
          ObsidianDone = { bold = true, fg = '#89ddff' },
          ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
          ObsidianTilde = { bold = true, fg = '#ff5370' },
          ObsidianImportant = { bold = true, fg = '#d73128' },
          ObsidianBullet = { bold = true, fg = '#89ddff' },
          ObsidianRefText = { underline = true, fg = '#c792ea' },
          ObsidianExtLinkIcon = { fg = '#c792ea' },
          ObsidianTag = { italic = true, fg = '#89ddff' },
          ObsidianBlockID = { italic = true, fg = '#89ddff' },
          ObsidianHighlightText = { bg = '#75662e' },
        },
      },

      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = 'assets/images', -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format('![%s](%s)', path.name, path)
        end,
      },
    },
  },

  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
