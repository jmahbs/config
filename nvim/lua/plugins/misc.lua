return {
  "tpope/vim-obsession",

  {
    "tpope/vim-surround",
    event = { "VeryLazy" },
  },

  {
    "tpope/vim-unimpaired",
    event = { "VeryLazy" },
  },

  {
    "tpope/vim-vinegar",
    keys = { "-" },
  },

  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
    keys = {
      { "<leader>a", "<Cmd>A<CR>" },
    },
    config = function()
      vim.g["projectionist_heuristics"] = {
        ["go.mod"] = {
          ["*.go"] = {
            type = "source",
            alternate = "{}_test.go",
          },
          ["*_test.go"] = {
            type = "test",
            alternate = "{}.go",
          },
        },
        ["src/*.ts"] = {
          ["*.ts"] = {
            type = "source",
            alternate = "{}.test.ts",
          },
          ["*.test.ts"] = {
            type = "test",
            alternate = "{}.ts",
          },
          ["*.tsx"] = {
            type = "source",
            alternate = "{}.test.tsx"
          },
          ["*.test.tsx"] = {
            type = "test",
            alternate = "{}.tsx"
          }
        },
      }
    end,
  },

  {
    "knubie/vim-kitty-navigator",
    event = { "VeryLazy" },
    build = { "cp ./*.py ~/.config/kitty/" },
    init = function()
      vim.api.nvim_create_autocmd("filetype", {
        group = vim.api.nvim_create_augroup("KittyNavigatorNetrwMapOverride", {}),
        pattern = "netrw",
        -- <C-l> is used to NetrwRefresh, which I never use
        command = [[
          nunmap <buffer> <c-l>
          nmap <buffer> <c-l> <Cmd>KittyNavigateRight<CR>
        ]],
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  {
    "windwp/nvim-projectconfig",
    event = { "VeryLazy" },
    opts = {
      project_dir = "~/.local/share/projectconfig/",
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    init = function()
      extend_palette {
        {
          name = "markdown preview",
          cmd = "MarkdownPreview",
          show = function()
            return vim.bo.filetype == "markdown"
          end,
        },
      }
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { 'takac/vim-hardtime' }
}
