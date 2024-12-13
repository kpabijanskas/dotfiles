local pn = require("plugin_names")

return {
	pn.projectconfig,
	dependencies = {
		pn.notify,
		pn.dap,
	},
	opts = {
		autocmd = true,
		project_dir = "~/.config/nvim/projects/",
	},
}
