local pn = require("plugin_names")

return {
	pn.surround,
	opts = {
		keymaps = {
			insert = "<nop>",
			insert_line = "<nop>",
			normal = "ms",
			normal_cur = "mc",
			normal_line = "mS",
			normal_cur_line = "mC",
			visual = "ms",
			visual_line = "mS",
			delete = "md",
			change = "mr",
			change_line = "mR",
		},
	},
}
