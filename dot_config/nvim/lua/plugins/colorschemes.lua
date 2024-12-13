local pn = require("plugin_names")

local function catppuccin_config()
	cp = require("catppuccin")
	cp.setup({
		term_colors = true,
		default_integrations = true,
		color_overrides = {
			surface1 = "#dde0eb",
			surface0 = "#eef0fb",
		},
		integrations = {
			gitsigns = true,
			indent_blankline = {
				enabled = true,
			},
			markdown = true,
			mason = true,
			neogit = true,
			cmp = true,
			dap = true,
			dap_ui = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			nvim_surround = true,
			treesitter = true,
			overseer = true,
			telescope = {
				enabled = true,
			},
			which_key = true,
			lsp_trouble = true,
		},
	})
end

local function cyberdream_config()
	cb = require("cyberdream")
	cb.setup({
		theme = {
			variant = "light",
		},
	})
end

return {
	{
		pn.catppuccin,
		priority = 1000,
		config = catppuccin_config,
	},
	{
		pn.onehalf,
		priority = 1000,
	},
	{
		pn.paper,
		priority = 1000,
	},
	{
		pn.tokyonight,
		priority = 1000,
	},
	{
		pn.newpaper,
		priority = 1000,
	},
	{
		pn.rosepine,
		priority = 1000,
	},
	{
		pn.edge,
		priority = 1000,
	},
	{
		pn.zenbones,
		priority = 1000,
		dependencies = {
			pn.lush,
		},
	},
	{
		pn.github_theme,
		priority = 1000,
	},
	{
		pn.melange,
		priority = 1000,
	},
	{
		pn.cyberdream,
		priority = 1000,
		config = cyberdream_config,
	},
	{
		pn.gruvbox,
		priority = 1000,
		config = true,
	},
	{
		pn.base16,
		priority = 1000,
	},
	{
		pn.nightfox,
		priority = 1000,
	},
	{
		pn.vscode,
		priority = 1000,
		opts = {
			mode = "light",
		},
	},
	{
		pn.doomone,
		priority = 1000,
	},
}
