return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<Cmd>LazyGit<CR>" }
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>hs", "<Cmd>Gitsigns<CR>" },
      { "<leader>hd", "<Cmd>Gitsigns diffthis<CR>" },
      { "<leader>hR", "<Cmd>Gitsigns resetBuffer<CR>" }
    }
  }
}
