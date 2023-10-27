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
  { "lewis6991/gitsigns.nvim" }
}
