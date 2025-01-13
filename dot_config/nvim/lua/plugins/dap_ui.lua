local pn = require("plugin_names")

local function dap_ui_config()
  local dapui = require("dapui")
	dapui.setup({
    controls = {
      enabled = false,
    },
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

  local wk = require("which-key")
  local kb_table = {
    {"<leader>gu", dapui.toggle, desc = "Toggle DAP UI"}
  }
  wk.add({
    { mode = "n", kb_table },
    { mode = "v", kb_table },
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
