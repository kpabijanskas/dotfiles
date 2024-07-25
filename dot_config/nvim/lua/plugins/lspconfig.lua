local pn = require("plugin_names")

local function lspconfig_config()
	local lspconfig = require("lspconfig")
	local wk = require("which-key")

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
		capabilities = capabilities,
	})

	-- Rust is set-up in its own plugin
	-- Go is set-up in its own plugin

	lspconfig.pyright.setup({
		capabilities = capabilities,
	})
	lspconfig.lua_ls.setup({
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim", "require" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
		capabilities = capabilities,
	})
	lspconfig.marksman.setup({
		capabilities = capabilities,
		filetypes = { "marksman" },
	})

	lspconfig.clangd.setup({})

	lspconfig.bashls.setup({})

	lspconfig.bufls.setup({})

	lspconfig.nil_ls.setup({})

	lspconfig.yamlls.setup({})

	lspconfig.bufls.setup({})

	wk.add({
		{ "gD", vim.lsp.buf.declaration, desc = "Goto declaration" },
		{ "<leader>a", vim.lsp.buf.code_action, desc = "Perform code action" },
		{ "<leader>k", vim.lsp.buf.hover, desc = "Show docs for item under cursor" },
		{ "<leader>r", vim.lsp.buf.rename, desc = "Rename symbol" },
	})
end

return {
	pn.nvim_lspconfig,
	config = lspconfig_config,
	dependencies = {
		pn.nvim_cmp,
		pn.which_key,
	},
}
