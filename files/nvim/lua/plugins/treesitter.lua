local pn = require("../plugin_names")

local function treesitter_config()
	require("nvim-treesitter.install").compilers = { "gcc" }
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		ignore_install = { "norg" },
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "org", "markdown" },
		},
		sync_install = false,
	})
end

return {
	pn.treesitter,
	build = ":TSUpdate",
	config = treesitter_config,
}
