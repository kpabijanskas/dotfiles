local pn = require("../plugin_names")

local function bufferline_config()
	require("bufferline").setup({
		options = {
			show_buffer_close_icons = false,
			show_close_icon = false,
		},
	})
end

return {
	pn.bufferline,
	dependencies = {
		pn.nvim_web_devicons,
	},
	config = bufferline_config,
}
