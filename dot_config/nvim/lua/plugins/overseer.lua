local pn = require("plugin_names")

return {
	pn.overseer,
	keys = {
		{ "<leader>u", "<cmd>OverseerRun<CR>", desc = "Overseer Run" },
		{ "<leader>m", "<cmd>OverseerToggle left<CR>", desc = "Overseer" },
	},
	opts = {},
}
