-- Enhanced TypeScript/React/Next.js support
-- Works for any TypeScript project, not just this monorepo

return {
  -- ============================================================================
  -- Neotest: Add Vitest Adapter
  -- ============================================================================
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-vitest"] = {
        -- Filter out node_modules
        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      }
      return opts
    end,
  },

  -- ============================================================================
  -- LSP: Enhanced TypeScript Settings
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.vtsls = opts.servers.vtsls or {}

      -- Enhanced settings for TypeScript
      opts.servers.vtsls.settings = vim.tbl_deep_extend("force", opts.servers.vtsls.settings or {}, {
        typescript = {
          preferences = {
            -- Prefer relative imports for better monorepo support
            importModuleSpecifier = "relative",
            -- Use project's TypeScript version
            useWorkspaceTsdk = true,
          },
          inlayHints = {
            -- Comprehensive inlay hints
            parameterNames = { enabled = "all" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
        },
      })

      return opts
    end,
  },

  -- ============================================================================
  -- Auto-commands for TypeScript Files
  -- ============================================================================
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local ts_group = vim.api.nvim_create_augroup("TypeScriptEnhanced", { clear = true })

      -- Auto-format on save for TypeScript/JavaScript files
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = ts_group,
        pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
        callback = function()
          vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
        end,
      })

      -- Optional: Auto-organize imports on save
      -- Uncomment if you want this behavior (can be slow/annoying):
      --
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = ts_group,
      --   pattern = { "*.ts", "*.tsx" },
      --   callback = function()
      --     vim.lsp.buf.code_action({
      --       apply = true,
      --       context = {
      --         only = { "source.organizeImports" },
      --         diagnostics = {},
      --       },
      --     })
      --   end,
      -- })

      return opts
    end,
  },
}
