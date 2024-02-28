local pn = require("../plugin_names")

local function surround_config()
	require("nvim-surround").setup({
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
	})
end

return {
	pn.surround,
	config = surround_config,
}
