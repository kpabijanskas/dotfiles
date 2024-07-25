local pn = require("plugin_names")

return {
	pn.luasnip,
	dependencies = { pn.friendly_snippets },
	build = "make install_jsregexp",
}
