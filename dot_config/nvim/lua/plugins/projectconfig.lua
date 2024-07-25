local pn = require("plugin_names")

return {
	pn.projectconfig,
	dependencies = {
		pn.nvim_notify,
	},
	opts = {
		autocmd = true,
		project_dir = "~/.config/nvim/projects/",
	},
}
