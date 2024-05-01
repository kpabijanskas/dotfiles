local pn = require("../plugin_names")

local function indent_blankline_config()
	require("ibl").setup({})
end

return {
	pn.indent_blankline,
	config = indent_blankline_config,
}

