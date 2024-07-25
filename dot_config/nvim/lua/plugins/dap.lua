local pn = require("plugin_names")

local function dap_config()
	local dap = require("dap")
	local dap_widgets = require("dap.ui.widgets")

	require("nvim-dap-virtual-text").setup({})
	require("dap-go").setup({
		dap_configurations = {
			{
				type = "go",
				name = "Attach remote",
				mode = "remote",
				request = "attach",
			},
		},
	})
	-- require("telescope").load_extension("dap")

	local wk = require("which-key")
	local kb_table = {
		{ "<leader>gr", dap.run_last, desc = "Restart last debugging session" },
		{ "<leaer>gb", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
		{ "<leaer>gc", dap.continue, desc = "Launch/Continue DAP" },
		{ "<leaer>gi", dap.step_into, desc = "Step Into" },
		{ "<leaer>go", dap.step_out, desc = "Step out" },
		{ "<leaer>gn", dap.step_over, desc = "Step over" },
		{
			"<leaer>gv",
			function()
				dap_widgets.centered_float(dap_widgets.scopes)
			end,
			desc = "Show scopes",
		},
		{ "<leaer>gt", dap.terminate, desc = "Terminate session" },
		{
			"<leaer>gf",
			function()
				dap_widgets.centered_float(dap_widgets.frames)
			end,
			desc = "Show Frames",
		},
		{ "<leaer>ge", dap.repl.open, desc = "Open repl" },
		{ "<leaer>gh", dap_widgets.hover, desc = "Hover" },
		{
			"<leaer>ga",
			function()
				dap_widgets.centered_float(dap_widgets.threads)
			end,
			desc = "Show threads",
		},
	}
	wk.add({
		{ mode = "n", kb_table },
		{ mode = "b", kb_table },
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
