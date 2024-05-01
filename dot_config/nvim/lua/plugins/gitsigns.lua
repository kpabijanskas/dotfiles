local pn = require("../plugin_names")
local reg = require("../register_keybindings")

local function gitsigns_config()
	local gitsigns = require("gitsigns")
	gitsigns.setup()

	reg.register_left_bracket_keybindings({
		g = {
			function()
				gitsigns.prev_hunk({ wrap = true })
			end,
			"Goto previous  change",
		},
	})
	reg.register_right_bracket_keybindings({
		g = {
			function()
				gitsigns.next_hunk({ wrap = true })
			end,
			"Goto next change",
		},
	})
end

return {
	pn.gitsigns,
	dependencies = {
		pn.which_key,
	},
	config = gitsigns_config,
}

