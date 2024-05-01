local pn = require("../plugin_names")
local reg = require("../register_keybindings")

local function trouble_config()
	local trouble = require("trouble")
	trouble.setup()

	reg.register_leader_keybindings({
		t = { trouble.toggle, "Open Trouble" },
	})
end

return {
	pn.trouble,
	dependencies = {
		pn.nvim_web_devicons,
	},
	config = trouble_config,
}

