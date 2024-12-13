local pn = require("plugin_names")

local function dap_ui_config()
	require("dapui").setup({
		layouts = {
			{
				elements = {
					{
						id = "breakpoints",
						size = 0.25,
					},
					{
						id = "stacks",
						size = 0.5,
					},
					{
						id = "watches",
						size = 0.25,
					},
				},
				position = "left",
				size = 60,
			},
			{
				elements = {
					{
						id = "scopes",
						size = 0.6,
					},
					{
						id = "repl",
						size = 0.4,
					},
				},
				position = "bottom",
				size = 20,
			},
		},
	})
end

return {
	pn.dap_ui,
	dependencies = {
		pn.dap,
		pn.nio,
	},
	config = dap_ui_config,
}
