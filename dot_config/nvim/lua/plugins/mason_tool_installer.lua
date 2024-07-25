local pn = require("plugin_names")

return {
	pn.mason_tool_installer,
	dependencies = {
		pn.mason,
	},
	opts = {
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
			"buf-language-server",
		},
	},
	lazy = false,
}
