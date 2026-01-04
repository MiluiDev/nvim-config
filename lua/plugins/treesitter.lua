return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "python", "go", "javascript", "typescript",
        "rust", "lua", "java", "c", "cpp",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}

