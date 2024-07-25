local pn = require("plugin_names")

local function whichkey_config()
	local wk = require("which-key")

	vim.o.timeoutlen = 0

	wk.setup({
		delay = 0,
		plugins = {
			presets = {
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		-- replace = {
		-- 	{ "<Space>", "SPC" },
		-- 	{ "<CR>", "RET" },
		-- 	{ "<TAB>", "TAB" },
		-- },
		-- win = {
		-- 	border = "single",
		-- },
	})

	local kb_table = {
		{ "<leader>c", "<cmd>nohl<cr>", desc = "Clear highlights" },

		{ "<leader>w", proxy = "<C-w>", group = "Window" },
		{ "<leader>ww", desc = "Goto next split" },
		{ "<leader>ws", desc = "Horizontal split" },
		{ "<leader>wv", desc = "Vertical split" },
		{ "<leader>wo", desc = "Close all splits except current" },
		{ "<leader>wh", desc = "Jump to left split" },
		{ "<leader>wj", desc = "Jump to split below" },
		{ "<leader>wk", desc = "Jump to split above" },
		{ "<leader>wl", desc = "Jump to right split" },
		{ "<leader>wq", desc = "Close current split" },
		{ "<leader>wH", desc = "Swap with left split" },
		{ "<leader>wJ", desc = "Swap with split below" },
		{ "<leader>wK", desc = "Swap with split above" },
		{ "<leader>wL", desc = "Swap with split right" },
		{ "<leader>wn", desc = "New split with a scratch buffer" },

		{ "<leader>v", group = "Vim keybindings" },
		{
			"<leader>vw",
			"<cmd>checkhealth which-key<cr>",
			desc = "Check for any conflicting which-key keybindings",
		},

		{ "g", group = "Goto" },
		{ "gn", "<cmd>bn<cr>", desc = "Goto next buffer" },
		{ "gp", "<cmd>bp<cr>", desc = "Goto previous buffer" },

		{ "m", group = "Match" },
		{
			"mm",
			function()
				vim.cmd([[normal! %]])
			end,
			desc = "Goto matching bracket",
		},

		{ "]", group = "Right Bracket" },
		{ "]d", vim.diagnostic.goto_next, desc = "Goto next diagnostic" },

		{ "[", group = "Left Bracket" },
		{ "[d", vim.diagnostic.goto_prev, desc = "Goto previous diagnostic" },

		{ "z", group = "Z" },
		{ "zz", desc = "Align view center" },
		{ "zt", desc = "Align view top" },
		{ "zb", desc = "Align view bottom" },

		{ "<leader>g", desc = "Debug" },
	}

	local n_only_kb_table = {
		mode = "n",
		{ "<leader>y", 'V"+y', desc = "Copy current line to clipboard" },
		{ "<leader>p", '<cmd>set paste<cr>"+p<cmd>set nopaste<cr>', desc = "Paste from clipboard after cursor" },
		{ "<leader>P", '<cmd>set paste<cr>"+P<cmd>set nopaste<cr>', desc = "Paste from clipboard before cursor" },
	}

	local v_only_kb_table = {
		mode = "v",
		{ "<leader>y", '"+y', desc = "Copy to clipboard" },
	}

	local i_only_kb_table = {
		mode = "i",
		{
			"<C-o>",
			function()
				vim.cmd([[normal! o]])
			end,
			desc = "New line below",
		},
	}

	wk.add({
		kb_table,
		{ mode = "v", kb_table },
		n_only_kb_table,
		v_only_kb_table,
		i_only_kb_table,
	})
end

return {
	pn.which_key,
	priority = 0,
	config = whichkey_config,
}
