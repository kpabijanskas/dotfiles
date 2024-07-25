local pn = require("plugin_names")

local function oil_config()
	local oil = require("oil")
	local wk = require("which-key")

	oil.setup({
		view_options = {
			show_hidden = true,
		},
		float = {
			override = function(conf)
				local ui = vim.api.nvim_list_uis()[1]

				local col_start = math.floor(ui.width / 100 * 20)
				local col_end = math.ceil(ui.width / 100 * 80)
				local row_start = math.floor(ui.height / 100 * 10)
				local row_end = math.ceil(ui.height / 100 * 90)

				conf.style = "minimal"
				conf.relative = "editor"
				conf.width = col_end - col_start
				conf.height = row_end - row_start
				conf.row = row_start
				conf.col = col_start

				return conf
			end,
		},
	})

	local kb_table = {
		{ "<leader>-", oil.toggle_float, desc = "Open Oil" },
	}

	wk.add({
		{ mode = "n", kb_table },
		{ mode = "v", kb_table },
	})
end

return {
	pn.oil,
	dependencies = { pn.mini_icons },
	config = oil_config,
}
