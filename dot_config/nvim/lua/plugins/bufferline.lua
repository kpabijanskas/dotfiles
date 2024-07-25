local pn = require("plugin_names")

return {
	pn.bufferline,
	dependencies = {
		pn.nvim_web_devicons,
	},
	opts = {
		options = {
			show_buffer_close_icons = false,
			show_close_icon = false,
		},
	},
}
