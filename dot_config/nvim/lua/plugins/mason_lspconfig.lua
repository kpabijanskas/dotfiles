local pn = require("plugin_names")

return {
	pn.mason_lspconfig,
	dependencies = {
		pn.mason,
	},
	opts = {
		ensure_installed = {
			"lua_ls",
			"marksman",
		},
	},
	lazy = false,
}
