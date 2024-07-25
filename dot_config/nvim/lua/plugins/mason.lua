local pn = require("plugin_names")

return {
	pn.mason,
	build = {
		":MasonUpdate",
	},
	config = true,
	lazy = false,
}
