local pn = require("plugin_names")
local function gen_struct_tags_picker(cmd, tags)
	local pick = require("lib.pick")

	local results = {}
	for _, tag in ipairs(tags) do
		table.insert(results, {
			name = tag,
			command = function()
				vim.cmd(("%s %s"):format(cmd, tag))
			end,
		})
	end

	return function()
		pick(results, "Tag Type")
	end
end
local function gen_struct_tags_add_picker(tags)
	return gen_struct_tags_picker("GoAddTag", tags)
end

local function gen_struct_tags_rm_picker(tags)
	return gen_struct_tags_picker("GoRmTag", tags)
end

local function go_filetype_table()
	local wk = require("which-key")

	local kb_table = {
		{ "<localleader>U", "<cmd>GoUpdateBinaries<cr>", desc = "Update Binaries" },
		{ "<localleader>T", "<cmd>GoTest<cr>", desc = "Test all" },
		{ "<localleader>t", "<cmd>GoTestFunc<cr>", desc = "Test current function" },
		{ "<localleader>r", "<cmd>GoTestFile<cr>", desc = "Test functions in current file" },
		{ "<localleader>R", "<cmd>GoTestPkg<cr>", desc = "Test functions in current package" },
		{ "<localleader>a", "<cmd>GoAddTest<cr>", desc = "Add test for current function" },
		{ "<localleader>A", "<cmd>GoAddExpTest<cr>", desc = "Add tests for all exported functions" },
		{ "<localleader>c", "<cmd>GoCheat<cr>", desc = "Open cheat.sh for current function" },
		{ "<localleader>o", "<cmd>GoPkgOutline<cr>", desc = "Open package outline" },
		{
			"<localleader>g",
			gen_struct_tags_add_picker({ "json", "yaml" }),
			desc = "Add Tags By Type",
		},
		{
			"<localleader>G",
			gen_struct_tags_rm_picker({ "json", "yaml" }),
			desc = "Remove Tags By Type",
		},
		{ "<localleader>C", "<cmd>GoClearTag<cr>", desc = "Clear all tags" },
		{ "<localleader>m", "<cmd>GoCmt<cr>", desc = "Add comment" },
		{ "<localleader>i", "<cmd>GoImpl<cr>", desc = "Implement an interface" },
		{ "<localleader>f", "<cmd>GoFillStruct<cr>", desc = "Fill struct" },
		{ "<localleader>F", "<cmd>GoFillSwitch<cr>", desc = "Fill switch" },
		{ "<localleader>v", "<cmd>GoModTidy<cr>", desc = "Tidy" },
		{ "<localleader>V", "<cmd>GoModVendor<cr>", desc = "Vendor" },
		{ "<localleader>j", "<cmd>GoJson2Struct<cr>", desc = "JSON To Struct" },
	}

	wk.add({
		buffer = vim.api.nvim_get_current_buf(),
		{ mode = "n", kb_table },
		{ mode = "v", kb_table },
	})
end

local function go_config()
	require("go").setup({
		goimports = "gopls",
		gofmt = "golines",
		tag_transform = false,
		test_dir = "",
		lsp_cfg = false, -- false: use your own lspconfig
		lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
		dap_debug = true,
		lsp_keymaps = false,
		max_line_len = 120,
		build_tags = "wireinject",
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
		pn.lspconfig,
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
