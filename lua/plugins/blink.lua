return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        preset = "none", -- IMPORTANTE: no usar default

        ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<CR>"] = { "fallback" }, -- Enter solo nueva línea
        ["<C-Space>"] = { "show" },
      },

      sources = {
        default = { "lsp", "snippets", "buffer", "path" },
      },
    },
  },
}

