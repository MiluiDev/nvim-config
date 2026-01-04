
return {
	-- DAP core
	{
		"mfussenegger/nvim-dap",
	},

	-- Instalar adapters con Mason (opcional pero cómodo)
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		opts = {
			ensure_installed = { "python" }, -- instala debugpy
			automatic_setup = true,
		},
	},

	-- Python DAP helper (usa debugpy)
	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap_python = require("dap-python")
			-- debugpy instalado por mason:
			dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

			-- (opcional) test runners
			-- dap_python.test_runner = "pytest"
		end,
	},

	-- UI (opcional, pero recomendado)

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.55 },
							{ id = "watches", size = 0.20 },
							{ id = "breakpoints", size = 0.15 },
							{ id = "stacks", size = 0.10 },
						},
						position = "left",
						size = 50, -- 👈 más ancho (columnas)
					},
					{
						elements = { "repl", "console" },
						position = "bottom",
						size = 0.30, -- 👈 30% de alto
					},
				},
			})

			dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui"] = function() dapui.close() end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			show_stop_reason = true,
			commented = false,      -- si lo pones true, lo muestra como comentario
			virt_text_pos = "eol",  -- end of line
			all_frames = false,
		},
	},
	-- Keymaps básicos DAP
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff4d4d" })
			vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#ff784f" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#ffb86c" })

			-- 🔴 Icono del breakpoint
			vim.fn.sign_define("DapBreakpoint", {
				text = "●",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F12>", dap.step_out)
			vim.keymap.set("n", "<F2>", dap.toggle_breakpoint)

			vim.keymap.set("n", "<F3>", function()
				require("dap").clear_breakpoints()
			end)
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
		end,
	},
}
