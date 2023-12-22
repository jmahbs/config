return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = "VeryLazy",
  -- lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/Documents/work",
      },
    },

  },
}
