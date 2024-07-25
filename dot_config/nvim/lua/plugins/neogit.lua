local pn = require("plugin_names")

local function neogit_config()
	local neogit = require("neogit")
	local wk = require("which-key")

	neogit.setup({})

	local kb_table = { "<leader>G", neogit.open, desc = "Open NeoGit" }

	wk.add({
		{ mode = "n", kb_table },
		{ mode = "b", kb_table },
	})
end

return {
	pn.neogit,
	dependencies = {
		pn.plenary,
		pn.diffview,
		pn.telescope,
		pn.which_key,
	},
	config = neogit_config,
}
