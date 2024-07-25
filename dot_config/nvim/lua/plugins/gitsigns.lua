local pn = require("plugin_names")

local function gitsigns_config()
	local gitsigns = require("gitsigns")
	gitsigns.setup()

	local wk = require("which-key")
	local kb_table = {
		{
			"[g",
			function()
				gitsigns.prev_hunk({ wrap = true })
			end,
			desc = "Goto previous  change",
		},
		{
			"]g",
			function()
				gitsigns.next_hunk({ wrap = true })
			end,
			desc = "Goto next change",
		},
	}
	wk.add({
		{ mode = "n", kb_table },
		{ mode = "v", kb_table },
	})
end

return {
	pn.gitsigns,
	dependencies = {
		pn.which_key,
	},
	config = gitsigns_config,
}
