local pn = require("plugin_names")

local function trouble_config()
	local trouble = require("trouble")
	trouble.setup()
	local wk = require("which-key")

	local kb_table = {
		{
			"<leader>t",
			function()
				trouble.toggle({
					mode = "diagnostics",
					filter = {
						any = {
							buf = 0,
							{
								severity = vim.diagnostic.severity.ERROR,
								function(item)
									return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
								end,
							},
						},
					},
				})
			end,
			desc = "Open Trouble",
		},
	}

	wk.add({
		kb_table,
		{ mode = "v", kb_table },
	})
end

return {
	pn.trouble,
	dependencies = {
		pn.web_devicons,
	},
	config = trouble_config,
}
