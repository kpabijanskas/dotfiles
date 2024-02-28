local pn = require("../plugin_names")
local reg = require("../register_keybindings")

local function neogit_config()
	local neogit = require("neogit")

	neogit.setup({})

	reg.register_leader_keybindings({
		G = { neogit.open, "Open NeoGit" },
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
