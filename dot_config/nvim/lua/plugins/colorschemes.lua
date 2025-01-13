local pn = require("plugin_names")

local function catppuccin_config()
	cp = require("catppuccin")
	cp.setup({
		term_colors = true,
		default_integrations = true,
		color_overrides = {
			surface1 = "#dde0eb",
			surface0 = "#eef0fb",
		},
		integrations = {
			gitsigns = true,
			indent_blankline = {
				enabled = true,
			},
			markdown = true,
			mason = true,
			neogit = true,
			cmp = true,
			dap = true,
			dap_ui = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			nvim_surround = true,
			treesitter = true,
			overseer = true,
			telescope = {
				enabled = true,
			},
			which_key = true,
			lsp_trouble = true,
		},
	})
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
end

local function cyberdream_config()
	local cb = require("cyberdream")
	cb.setup({
		theme = {
			variant = "light",
		},
	})
end

local function onenord_config()
  local on = require("onenord")
  local colors = require("onenord.colors.onenordlight")
  on.setup({
    theme = "light",
    fade_nc = true,
  })

  -- vim.api.nvim_set_hl(0, "DapUIVariable", { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, "DapUIValue",{ link = 'Normal' })
  -- vim.api.nvim_set_hl(0, "DapUIFrameName",{ link = 'Normal' })
  -- vim.api.nvim_set_hl(0, "DapUIThread", { fg = colors.yellow })
  -- vim.api.nvim_set_hl(0, "DapUIWatchesValue", { link = 'DapUIThread' })
  -- vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { link = 'DapUIThread' })
  -- vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = colors.yellow, bold=true })
  -- vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { fg = colors.red })
  -- vim.api.nvim_set_hl(0, "DapUIWatchesError", { link = 'DapUIWatchesEmpty' })
  -- vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { fg = colors.light_gray })
  -- vim.api.nvim_set_hl(0, "DapUISource", { fg = colors.purple })
  -- vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = colors.blue })
  -- vim.api.nvim_set_hl(0, "DapUIScope", { link = 'DapUIBreakpointsPath' })
  -- vim.api.nvim_set_hl(0, "DapUILineNumber", { link = 'DapUIBreakpointsPath' })
  -- vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { link = 'DapUIBreakpointsPath' })
  -- vim.api.nvim_set_hl(0, "DapUIFloatBorder", { link = 'DapUIBreakpointsPath' })
  -- vim.api.nvim_set_hl(0, "DapUIStoppedThread", { link = 'DapUIBreakpointsPath' })
  -- vim.api.nvim_set_hl(0, "DapUIDecoration", { link = 'DapUIBreakpointsPath' })
  -- vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = colors.blue, bold=true })
end

return {
	{
		pn.catppuccin,
		priority = 1000,
		config = catppuccin_config,
	},
	{
		pn.onehalf,
		priority = 1000,
	},
	{
		pn.paper,
		priority = 1000,
	},
	{
		pn.tokyonight,
		priority = 1000,
	},
	{
		pn.newpaper,
		priority = 1000,
	},
	{
		pn.rosepine,
		priority = 1000,
	},
	{
		pn.edge,
		priority = 1000,
	},
	{
		pn.zenbones,
		priority = 1000,
		dependencies = {
			pn.lush,
		},
	},
	{
		pn.github_theme,
		priority = 1000,
	},
	{
		pn.melange,
		priority = 1000,
	},
	{
		pn.cyberdream,
		priority = 1000,
		config = cyberdream_config,
	},
	{
		pn.gruvbox,
		priority = 1000,
		config = true,
	},
	{
		pn.base16,
		priority = 1000,
	},
	{
		pn.nightfox,
		priority = 1000,
	},
	{
		pn.vscode,
		priority = 1000,
		opts = {
			mode = "light",
		},
	},
	{
		pn.doomone,
		priority = 1000,
	},
  {
    pn.onenord,
		priority = 1000,
    config = onenord_config,
  }
}
