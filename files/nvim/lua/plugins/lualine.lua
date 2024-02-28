local pn = require("../plugin_names")

local function lualine_config()
	require("lualine").setup({
		options = {
			theme = "catppuccin",
		},
	})
end

return {
	pn.lualine,
	dependencies = { pn.nvim_web_devicons },
	config = lualine_config,
}
