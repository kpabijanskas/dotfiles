local pn = require("plugin_names")

local function catppuccin_config(_, opts)
	require("catppuccin").setup(opts)

	vim.cmd.colorscheme("catppuccin-latte")
end

return {
	pn.catpuccin,
	opts = {
		cmp = true,
		treesitter = true,
		mason = true,
		dap = true,
		dap_ui = true,
		telescope = {
			enabled = true,
		},
		which_key = true,
		lsp_trouble = true,
	},
	config = catppuccin_config,
	priority = 1000,
}
