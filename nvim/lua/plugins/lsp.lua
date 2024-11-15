local border = "rounded"

--  disabling text hovers as was clashing with noice
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
--
-- vim.lsp.handlers["textDocument/signatureHelp"] =
--     vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    close_events = {
      "BufLeave",
      "CursorMoved",
      "InsertEnter",
      "FocusLost",
    },
    source = "if_many",
    prefix = "",
    header = "",
    scope = "cursor",
    border = border,
  },
})

map("n", "]e", vim.diagnostic.goto_next)
map("n", "[e", vim.diagnostic.goto_prev)

local augroup_highlight = vim.api.nvim_create_augroup("UserLspHighlight", {})

local function clear_autocmd_highlight(bufnr)
  vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup_highlight })
end

local function autocmd_highlight(bufnr)
  clear_autocmd_highlight(bufnr)
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    group = augroup_highlight,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave" }, {
    group = augroup_highlight,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

local augroup_lsp_config = vim.api.nvim_create_augroup("UserLspConfig", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup_lsp_config,
  callback = function(args)
    local opts = { buffer = args.buf }
    map("n", "<leader>c", vim.lsp.buf.code_action, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", "<cmd>Telescope lsp_declaration<cr>", opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>r", vim.lsp.buf.rename, opts)
    map("n", "gr", "<cmd>Telescope lsp_references<cr>")
    map("n", "gi", function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentHighlightProvider then
      autocmd_highlight(args.buf)
    end

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_set_option(args.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = augroup_lsp_config,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method("textDocument/documentHighlight") then
      clear_autocmd_highlight(args.buf)
    end
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      opts.servers = {
        cssls = {},
        rust_analyzer = {
          keys = {
            { "K",          "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
            { "<leader>cR", "<cmd>RustCodeAction<cr>",   desc = "Code Action (Rust)" },
            { "<leader>dr", "<cmd>RustDebuggables<cr>",  desc = "Run Debuggables (Rust)" },
          },
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              experimentalPostfixCompletions = true,
              usePlaceholders = true,
              analyses = {
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
              },
            },
          },
        },
        html = {},
        pyright = {
          settings = {
            python = {
              venvPath = ".venv",
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
        tsserver = {},
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },
      }
    end,
    config = function(_, opts)
      -- require("neodev").setup {}
      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        local merged = vim.tbl_extend("error", {
          capabilities = capabilities,
        }, config)
        lspconfig[server].setup(merged)
      end
    end,
  },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = true,
  },
}
