return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local snippy = require "snippy"
    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          snippy.expand_snippet(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "snippy" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
  ---@param opts cmp.ConfigSchema
  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end
    require("cmp").setup(opts)
  end,
  -- config = function()
  --   local function has_words_before()
  --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --     return col ~= 0
  --         and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  --   end
  --
  --   local cmp = require "cmp"
  --   local snippy = require "snippy"
  --
  --   cmp.setup {
  --     preselect = cmp.PreselectMode.None,
  --     snippet = {
  --       expand = function(args)
  --         snippy.expand_snippet(args.body)
  --       end,
  --     },
  --     sources = cmp.config.sources({
  --       { name = "nvim_lsp" },
  --       { name = "nvim_lua" },
  --       { name = "snippy" },
  --     }, {
  --       { name = "buffer" },
  --       { name = "path" },
  --     }),
  --     mapping = cmp.mapping.preset.insert {
  --       ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  --       ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  --       ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  --       ["<C-e>"] = cmp.mapping {
  --         i = cmp.mapping.abort(),
  --         c = cmp.mapping.close(),
  --       },
  --       ["<CR>"] = cmp.mapping.confirm { select = true },
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --         elseif snippy.can_expand_or_advance() then
  --           snippy.expand_or_advance()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif snippy.can_jump(-1) then
  --           snippy.previous()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     },
  --     window = {
  --       documentation = {
  --         border = "rounded",
  --         -- This makes no sense to me...
  --         winhighlight = "FloatBorder:FloatBorder",
  --       },
  --     },
  --   }
  --
  --   cmp.setup.cmdline({ "/", "?" }, {
  --     mapping = cmp.mapping.preset.cmdline(),
  --     sources = {
  --       { name = "buffer" },
  --     },
  --   })
  --
  --   cmp.setup.cmdline(":", {
  --     mapping = cmp.mapping.preset.cmdline(),
  --     sources = cmp.config.sources({
  --       { name = "path" },
  --     }, {
  --       { name = "cmdline" },
  --     }),
  --   })
  -- end,
}
