local pn = require("../plugin_names")

local function catppuccin_config()
	local catppuccin = require("catppuccin")

	catppuccin.setup({
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
	})

	vim.cmd.colorscheme("catppuccin-latte")
end

return {
	pn.catpuccin,
	config = catppuccin_config,
}
