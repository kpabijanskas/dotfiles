local pn = require("../plugin_names")

local function mason_config()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"marksman",
		},
	})
	require("mason-tool-installer").setup({
		ensure_installed = {
			"bash-language-server",
			"gofumpt",
			"golangci-lint",
			"gopls",
			"lua-language-server",
			"marksman",
			"mypy",
			"nil",
			"protolint",
			"pydocstyle",
			"pyflakes",
			"pylama",
			"pylint",
			"pylyzer",
			"pyright",
			"python-lsp-server",
			"rust-analyzer",
			"rustfmt",
			"zk",
		},
	})
end

return {
	pn.mason,
	dependencies = {
		pn.mason_lspconfig,
		pn.mason_tool_installer,
	},
	build = {
		":MasonUpdate",
	},
	config = mason_config,
}
