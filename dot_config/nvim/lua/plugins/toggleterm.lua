local pn = require("plugin_names")

local function toggleterm_config()
	local term = require("toggleterm")
	local wk = require("which-key")

	term.setup({
		on_open = function(t)
			wk.add({
				buffer = t.bufnr,
				{
					"<C-C>",
					function()
						vim.api.nvim_buf_delete(t.bufnr, { force = true })
					end,
					desc = "Close",
				},
				{
					"t",
					term.toggle_command,
					desc = "Toggle close",
				},
			})
		end,
	})
end

return {
	pn.toggleterm,
	config = toggleterm_config,
}
