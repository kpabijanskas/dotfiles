local pn = require("plugin_names")

return {
	pn.lualine,
	dependencies = { pn.web_devicons },
	opts = {
		options = {
			theme = "catppuccin",
		},
	},
}
