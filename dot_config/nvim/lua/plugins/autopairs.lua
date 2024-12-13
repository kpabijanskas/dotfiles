local pn = require("plugin_names")

return {
	pn.autopairs,
	opts = {
		disable_filetype = { "TelescopePrompt", "lisp" },
	},
}
