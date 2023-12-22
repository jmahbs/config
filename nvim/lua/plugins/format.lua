return {
  "elentok/format-on-save.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- both required for stylua custom handling
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = function(_, opts)
    -- local cached_stylua_configs = {}
    -- local find_stylua_config = function()
    -- end

    local formatters = require "format-on-save.formatters"

    opts.formatter_by_ft = {
      go = formatters.lsp,
      lua = formatters.lsp,
      markdown = formatters.prettierd,
      json = formatters.prettierd,
      yaml = formatters.prettierd,
      typescript = {
        formatters.if_file_exists({
          pattern = ".eslintrc.*",
          formatter = formatters.eslint_d_fix
        })
      },
      typescriptreact = {
        formatters.if_file_exists({
          pattern = ".eslintrc.*",
          formatter = formatters.eslint_d_fix,
        })
      }
    }
    opts.experiments = {
      partial_update = 'diff', -- or 'line-by-line'
    }
  end,
}
