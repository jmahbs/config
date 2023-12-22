return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = 'auto',
        icons_enabled = true,
        component_separators = '|',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = { 'branch', 'diff', {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn' },

          diagnostics_color = {
            error = 'DiagnosticError',
            warn  = 'DiagnosticWarn',
          },
          symbols = { error = 'E', warn = 'W' },
          colored = true,
          update_in_insert = false,
          always_visible = false,
        }
        },
        lualine_y = { 'filetype' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end,
}
