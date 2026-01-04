return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "pyright", "ruff" },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "ruff", "black", "isort" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local function pick_venv_python(root_dir)
        local candidates = {
          root_dir .. "/env/bin/python",
          root_dir .. "/.venv/bin/python",
          root_dir .. "/venv/bin/python",
        }
        for _, p in ipairs(candidates) do
          if vim.loop.fs_stat(p) then
            return p
          end
        end
      end

      vim.lsp.config("pyright", {
		settings = { python = { analysis = {diagnosticMode = "workspace", }} },
        on_init = function(client)
          local root_dir = client.config.root_dir or vim.fn.getcwd()
          local venv_python = pick_venv_python(root_dir)

          if venv_python then
            client.config.settings = client.config.settings or {}
            client.config.settings.python = client.config.settings.python or {}
            client.config.settings.python.pythonPath = venv_python
            client.config.settings.python.analysis = client.config.settings.python.analysis or {}
            client.config.settings.python.analysis.autoImportCompletions = true

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end

          return true
        end,
      })
      vim.lsp.enable("pyright") 
      vim.lsp.config("ruff", {
        root_dir = function(fname)
          return vim.fs.root(fname, { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" })
        end,
      })
      vim.lsp.enable("ruff")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = true })
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = true })

          vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = false })
          end, { buffer = true, desc = "Format (Conform: ruff)" })

          vim.keymap.set("n", "<leader>l", function()
            require("conform").format({
              async = true,
              lsp_fallback = false,
              formatters = { "ruff_fix", "ruff_organize_imports" },
            })
          end, { buffer = true, desc = "Ruff: fix + organize imports" })
        end,
      })
    end,
  },
}

