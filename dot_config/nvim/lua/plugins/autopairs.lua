local pn = require("plugin_names")

return {
	pn.nvim_autopairs,
	opts = {
		disable_filetype = { "TelescopePrompt", "lisp" },
	},
}
