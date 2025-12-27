return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		explorer = {
			enabled = true,
			position = "left",
			width = 34,
			replace_netrw = true,
			ident = true,
			icons = true,
			git = true,
			win = {
				border = "rounded",
				wo = {
					number = false,
					relativenumber = false,
					signcolumn = "yes",
					foldcolumn = "0",
				},
			},
		},

		picker = {
			enabled = true,
			layout = { preset = "vertical" },
			formatters = {
				file = {
					dir_first = true,
					path = true,
					truncate = 80,
				},
			},
		},

		dashboard = {
			enabled = true,
			recents = { limit = 5 },
			projects = { enabled = true, limit = 5 },
		},

		notifier = {
			enabled = true,
			timeout = 5000,
			animate = false,
		},
	},

	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.files({ cwd = Snacks.git.get_root() or vim.fn.getcwd() })
			end,
			desc = "Find Files (root only)",
		},
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
	},
}

