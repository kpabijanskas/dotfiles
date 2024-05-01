local pn = require("../plugin_names")
local reg = require("../register_keybindings")

local function dap_config()
	local dap = require("dap")
	local dap_widgets = require("dap.ui.widgets")

	require("nvim-dap-virtual-text").setup({})
	require("dap-go").setup()
	require("telescope").load_extension("dap")

	reg.register_debug_keybindings({
		r = { dap.run_last, "Restart last debugging session" },
		b = { dap.toggle_breakpoint, "Toggle breakpoint" },
		c = { dap.continue, "Launch/Continue DAP" },
		i = { dap.step_into, "Step Into" },
		o = { dap.step_out, "Step out" },
		n = { dap.step_over, "Step over" },
		v = {
			function()
				dap_widgets.centered_float(dap_widgets.scopes)
			end,
			"Show scopes",
		},
		t = { dap.terminate, "Terminate session" },
		f = {
			function()
				dap_widgets.centered_float(dap_widgets.frames)
			end,
			"Show Frames",
		},
		e = { dap.repl.open, "Open repl" },
		h = { dap_widgets.hover, "Hover" },
		a = {
			function()
				dap_widgets.centered_float(dap_widgets.threads)
			end,
			"Show threads",
		},
	})
end

return {
	pn.dap,
	dependencies = {
		pn.dap_virtual_text,
		pn.dap_go,
		pn.telescope_dap,
	},
	config = dap_config,
}

