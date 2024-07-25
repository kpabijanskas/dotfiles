local pn = require("plugin_names")

return {
	pn.lualine,
	dependencies = { pn.nvim_web_devicons },
	opts = {
		options = {
			theme = "catppuccin",
		},
	},
}
