return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- carga temprano
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/", -- NEW: sesiones centralizadas
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
  },
}

