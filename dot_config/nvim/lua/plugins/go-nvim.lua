-- https://github.com/blacktrub/telescope-godoc.nvim/blob/main/lua/godoc/init.lua TODO create a better version
local pn = require("../plugin_names")

local function go_filetype_table()
	local wk = require("which-key")

	local go_table = {
		name = "Go",
		U = { "<cmd>GoUpdateBinaries<cr>", "Update Binaries" },
		T = { "<cmd>GoTest<cr>", "Test all" },
		t = { "<cmd>GoTestFunc<cr>", "Test current function" },
		r = { "<cmd>GoTestFile<cr>", "Test functions in current file" },
		R = { "<cmd>GoTestPkg<cr>", "Test functions in current package" },
		a = { "<cmd>GoAddTest<cr>", "Add test for current function" },
		A = { "<cmd>GoAddExpTest<cr>", "Add tests for all exported functions" },
		c = { "<cmd>GoCheat<cr>", "Open cheat.sh for current function" },
		o = { "<cmd>GoPkgOutline<cr>", "Open package outline" },
		g = {
			function()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				pickers
					.new({}, {
						promt_title = "Tag Type",
						finder = finders.new_table({
							results = { "json", "yaml" },
						}),
						sorter = conf.generic_sorter(),
						attach_mappings = function(prompt_bufnr, map)
							_ = map -- Just to avoid warnings shown
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local picked = action_state.get_selected_entry()
								vim.cmd("GoAddTag " .. picked[1])
							end)
							return true
						end,
					})
					:find()
			end,
			"Add Tags By Type",
		},
		G = {
			function()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				pickers
					.new({}, {
						promt_title = "Tag Type",
						finder = finders.new_table({
							results = { "json", "yaml" },
						}),
						sorter = conf.generic_sorter(),
						attach_mappings = function(prompt_bufnr, map)
							_ = map -- Just to avoid warnings shown
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local picked = action_state.get_selected_entry()
								vim.cmd("GoRmTag " .. picked[1])
							end)
							return true
						end,
					})
					:find()
			end,
			"Remove Tags By Type",
		},
		C = { "<cmd>GoClearTag<cr>", "Clear all tags" },
		m = { "<cmd>GoCmt<cr>", "Add comment" },
		i = { "<cmd>GoImpl<cr>", "Implement an interface" },
		f = { "<cmd>GoFillStruct<cr>", "Fill struct" },
		F = { "<cmd>GoFillSwitch<cr>", "Fill switch" },
		v = { "<cmd>GoModTidy<cr>", "Tidy" },
		V = { "<cmd>GoModVendor<cr>", "Vendor" },
		j = { "<cmd>GoJson2Struct<cr>", "JSON To Struct" },
	}

	wk.register(go_table, {
		prefix = "<leader><space>",
		buffer = vim.api.nvim_get_current_buf(),
	})

	wk.register(go_table, {
		prefix = "<leader><space>",
		buffer = vim.api.nvim_get_current_buf(),
		mode = "v",
	})
end

local function go_config()
	require("go").setup({
		max_line_len = 120,
		tag_transform = false,
		test_dir = "",
		lsp_cfg = true, -- false: use your own lspconfig
		lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
		lsp_on_attach = true, -- use on_attach from go.nvim
		dap_debug = true,
		lsp_keymaps = false,
	})

	local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*.go",
		callback = function()
			require("go.format").goimport()
			vim.api.nvim_feedkeys("<cr>", "n", false)
		end,
		group = format_sync_grp,
	})

	local go_autocmd_group = vim.api.nvim_create_augroup("go_autocmd_group", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "go",
		group = go_autocmd_group,
		callback = go_filetype_table,
	})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "gomod",
		group = go_autocmd_group,
		callback = go_filetype_table,
	})
end

return {
	pn.go,
	dependencies = {
		pn.nvim_lspconfig,
		pn.treesitter,
		pn.dap,
		pn.guihua,
		pn.telescope,
	},
	config = go_config,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}

