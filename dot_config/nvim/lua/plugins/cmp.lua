local pn = require("plugin_names")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function cmp_config()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local luasnip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		},
		window = {
			completion = {
				scrollbar = true,
			},
		},
		formatting = {
			format = lspkind.cmp_format({
				with_text = true,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[lsp]",
					path = "[path]",
					luasnip = "[snip]",
				},
			}),
		},
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.close(),
			["<C-k>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { "i", "s" }),
		},
		experimental = {
			ghost_text = true,
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return {
	{
		pn.nvim_cmp,
		dependencies = {
			pn.nvim_lspconfig,
			pn.cmp_nvim_lsp,
			pn.cmp_buffer,
			pn.cmp_path,
			pn.cmp_cmdline,
			pn.nvim_autopairs,
			pn.luasnip,
			pn.cmd_luasnip,
			pn.lspkind,
			pn.friendly_snippets,
		},
		config = cmp_config,
	},
}
