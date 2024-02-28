local pn = require("../plugin_names")

local function autopairs_config()
	require("nvim-autopairs").setup({
		disable_filetype = { "TelescopePrompt", "lisp" },
	})
end

return {
	pn.nvim_autopairs,
	config = autopairs_config,
}
