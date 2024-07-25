local pn = require("plugin_names")

return {
	pn.dressing,
	opts = {
		input = {
			mappings = {
				i = {
					["<C-p>"] = "<left>",
					["<C-n>"] = "<right>",
				},
			},
		},
	},
}
