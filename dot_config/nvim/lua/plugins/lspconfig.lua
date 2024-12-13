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

	lspconfig.pyright.setup({})

	lspconfig.clangd.setup({})

	lspconfig.bashls.setup({})

	lspconfig.nil_ls.setup({})

	lspconfig.yamlls.setup({})

	lspconfig.buf_ls.setup({})

	lspconfig.gopls.setup({})

	lspconfig.ts_ls.setup({})

	wk.add({
		{ "<leader>a", vim.lsp.buf.code_action, desc = "perform code action" },
		{ "<leader>k", vim.lsp.buf.hover, desc = "show docs for item under cursor" },
		{ "<leader>r", vim.lsp.buf.rename, desc = "rename symbol" },
	})

	wk.add({
		mode = "v",
		{
			{ "<leader>a", vim.lsp.buf.code_action, desc = "perform code action" },
		},
	})
end

return {
	pn.lspconfig,
	config = lspconfig_config,
	dependencies = {
		pn.nvim_cmp,
		pn.which_key,
	},
}
