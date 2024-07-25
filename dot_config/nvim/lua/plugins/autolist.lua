local pn = require("plugin_names")

local function load_autolist_table()
	local autolist = require("autolist")
	local wk = require("which-key")

	wk.add({
		buffer = vim.api.nvim_get_current_buf(),
		{
			mode = "i",
			{ "<Tab>", "<CMD>AutolistTab<CR>", desc = "tab" },
			{ "<S-Tab>", "<CMD>AutolistShiftTab<CR>", desc = "s-tab" },
			{ "<CR>", "<CR><CMD>AutolistNewBullet<CR>", desc = "cr" },
		},
		{
			mode = "n",
			{ "<C-y>", autolist.cycle_next_dr, desc = "Cycle list type", expr = true },
			{ "o", "o<CMD>AutolistNewBullet<CR>", desc = "o" },
			{ "O", "O<CMD>AutolistNewBulletBefore<Cr>", desc = "O" },
			{ "<CR>", "<CMD>AutolistToggleCheckbox<CR><CR>", desc = "cr" },
			{ "<C-r>", "<CMD>AutolistRecalculate<CR>", desc = "c-r" },
			{ ">>", ">><CMD>AutolistRecalculate<CR>", desc = ">>" },
			{ "<<", "<<<CMD>AutolistRecalculate<CR>", desc = "<<" },
			{ "dd", "dd<CMD>AutolistRecalculate<CR>", desc = "dd" },
		},
		{
			mode = "v",
			{ "d", "d<CMD>AutolistRecalculate<CR>", desc = "recalc" },
		},
	})
end

local function autolist_config(_, opts)
	require("autolist").setup(opts)

	local autolist_autocmd_group = vim.api.nvim_create_augroup("autolist_autocmd_group", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		group = autolist_autocmd_group,
		callback = load_autolist_table,
	})
end

return {
	pn.autolist,
	opts = {},
	config = autolist_config,
}
