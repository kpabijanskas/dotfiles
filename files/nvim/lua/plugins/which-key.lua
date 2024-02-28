local pn = require("../plugin_names")

local function whichkey_config()
	local wk = require("which-key")

	vim.o.timeoutlen = 0

	wk.setup({
		plugins = {
			presets = {
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		key_labels = {
			["<space>"] = "SPC",
			["<cr>"] = "RET",
			["<tab>"] = "TAB",
		},
		window = {
			border = "single",
		},
	})

	local reg = require("../register_keybindings")

	reg.init()
	reg.register_window_keybindings({
		w = { desc = "Goto next split" },
		s = { desc = "Horizontal split" },
		v = { desc = "Vertical split" },
		o = { desc = "Close all splits except current" },
		h = { desc = "Jump to left split" },
		j = { desc = "Jump to split below" },
		k = { desc = "Jump to split above" },
		l = { desc = "Jump to right split" },
		q = { desc = "Close current split" },
		H = { desc = "Swap with left split" },
		J = { desc = "Swap with split below" },
		K = { desc = "Swap with split above" },
		L = { desc = "Swap with split right" },
		n = { desc = "New split with a scratch buffer" },
	})

	reg.register_vim_keybindings({
		w = { "<cmd>checkhealth which-key<cr>", "Check for any conflicting which-key keybindings" },
	})

	reg.register_leader_keybindings({
		c = { "<cmd>nohl<cr>", "Clear highlights" },
	})

	reg.register_goto_keybindings({
		n = { "<cmd>bn<cr>", "Goto next buffer" },
		p = { "<cmd>bp<cr>", "Goto previous buffer" },
	})

	reg.register_match_keybindings({
		m = {
			function()
				vim.cmd([[normal! %]])
			end,
			"Goto matching bracket",
		},
	})

	reg.register_right_bracket_keybindings({
		d = { vim.diagnostic.goto_next, "Goto next diagnostic" },
	})

	reg.register_left_bracket_keybindings({
		d = { vim.diagnostic.goto_prev, "Goto previous diagnostic" },
	})

	reg.register_z_keybindings({
		z = { desc = "Align view center" },
		t = { desc = "Align view top" },
		b = { desc = "Align view bottom" },
	})

	reg.register_leader_keybindings({
		y = { 'V"+y', "Copy current line to clipboard" },
		p = { '<cmd>set paste<cr>"+p<cmd>set nopaste<cr>', "Paste from clipboard after cursor" },
		P = { '<cmd>set paste<cr>"+P<cmd>set nopaste<cr>', "Paste from clipboard before cursor" },
	}, "n")

	reg.register_leader_keybindings({
		y = { '"+y', "Copy to clipboard" },
	}, "v")

	reg.register_global_keybindings({
		["<C-o>"] = {
			function()
				vim.cmd([[normal! o]])
			end,
			"New line below",
		},
	}, "i")
end

return {
	pn.which_key,
	priority = 0,
	config = whichkey_config,
}
