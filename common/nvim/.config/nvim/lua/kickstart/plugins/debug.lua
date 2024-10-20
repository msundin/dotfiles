-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'sebdah/vim-delve',
    'Mgenuit/nvim-dap-kotlin',
    'mfussenegger/nvim-dap-python',
  },

  -- opts = function()
  --   local dap = require 'dap'
  --   if not dap.adapters.kotlin then
  --     dap.adapters.kotlin = {
  --       type = 'executable',
  --       command = 'kotlin-debug-adapter',
  --       options = { auto_continue_if_many_stopped = false },
  --     }
  --   end
  --
  --   dap.configurations.kotlin = {
  --     {
  --       type = 'kotlin',
  --       request = 'launch',
  --       name = 'This file',
  --       -- may differ, when in doubt, whatever your project structure may be,
  --       -- it has to correspond to the class file located at `build/classes/`
  --       -- and of course you have to build before you debug
  --       mainClass = function()
  --         local root = vim.fs.find('src', { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ''
  --         local fname = vim.api.nvim_buf_get_name(0)
  --         -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
  --         return fname:gsub(root, ''):gsub('main/kotlin/', ''):gsub('.kt', 'Kt'):gsub('/', '.'):sub(2, -1)
  --       end,
  --       projectRoot = '${workspaceFolder}',
  --       jsonLogFile = '',
  --       enableJsonLogging = false,
  --     },
  --     {
  --       -- Use this for unit tests
  --       -- First, run
  --       -- ./gradlew --info cleanTest test --debug-jvm
  --       -- then attach the debugger to it
  --       type = 'kotlin',
  --       request = 'attach',
  --       name = 'Attach to debugging session',
  --       port = 5005,
  --       args = {},
  --       projectRoot = vim.fn.getcwd,
  --       hostName = 'localhost',
  --       timeout = 2000,
  --     },
  --   }
  -- end,

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    -- vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    -- vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    -- vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    -- vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    -- vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    -- vim.keymap.set('n', '<leader>B', function()
    --   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    -- end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>dt', dap.continue, { desc = ':DapUiToggle<CR>' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>dso', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>dsot', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dbc', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
    require('dap-python').setup '~/repos/python/python-debug-test/debug-test-env/bin/python'
    -- require('nvim-dap-kotlin').setup {
    --   dap_command = 'kotlin-debug-adapter',
    --   project_root = '${workspaceFolder}',
    --   enable_logging = false,
    --   log_file_path = '',
    -- }
    -- require('dap').defaults.kotlin.auto_continue_if_many_stopped = false
    -- dap.adapters.kotlin = {
    --   type = 'executable',
    --   command = 'kotlin-debug-adapter',
    --   options = { auto_continue_if_many_stopped = false },
    -- }
    --
    -- dap.configurations.kotlin = {
    --   {
    --     type = 'kotlin',
    --     request = 'launch',
    --     name = 'This file',
    --     -- may differ, when in doubt, whatever your project structure may be,
    --     -- it has to correspond to the class file located at `build/classes/`
    --     -- and of course you have to build before you debug
    --     mainClass = function()
    --       local root = vim.fs.find('src', { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ''
    --       local fname = vim.api.nvim_buf_get_name(0)
    --       -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
    --       return fname:gsub(root, ''):gsub('main/kotlin/', ''):gsub('.kt', 'Kt'):gsub('/', '.'):sub(2, -1)
    --     end,
    --     projectRoot = '${workspaceFolder}',
    --     jsonLogFile = '',
    --     enableJsonLogging = false,
    --   },
    --   {
    --     -- Use this for unit tests
    --     -- First, run
    --     -- ./gradlew --info cleanTest test --debug-jvm
    --     -- then attach the debugger to it
    --     type = 'kotlin',
    --     request = 'attach',
    --     name = 'Attach to debugging session',
    --     port = 5005,
    --     args = {},
    --     projectRoot = vim.fn.getcwd,
    --     hostName = 'localhost',
    --     timeout = 2000,
    --   },
    -- }
  end,
}
